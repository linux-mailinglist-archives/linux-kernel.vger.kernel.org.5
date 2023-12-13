Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806A6811F8C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378997AbjLMT4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbjLMTz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:55:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839D619AE;
        Wed, 13 Dec 2023 11:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702497280; x=1734033280;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2PKk63s5/N7TOpt00vRftf5+bvZmG0JNyrQ/GHYV7FY=;
  b=VPDcBOZjzpTYoSNvJgRJOaYT+FIYgi8s4hfgogAUwl4JrZeqt7rTjZrj
   vpVSSF8o1TUcOERpHxaNTKMmj+wRpXtOyAjvHA8wPF4I73ZHjonQuzWFt
   x9IMWekyn8f0tNNYahAkfGezBiiNnaqJob9fWQ+JB3IpLPREqiIZenB/+
   K3wpdR7o4A40Z3XlPMreERnRED4SXS2Bh+5KywDm0tXvJ429qYdI8SFsn
   k9YHHNXLuR6VAvoyPnfemsr2fZbrH4SQ+Huyx2S9RCMzTG5xaoxnNWGpy
   eKwOVvCwKX58QGGPYNJzcMVNV9QY9+av0Ld8/2LvkTTsPe3dMQI8Qyq/7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="2103474"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="2103474"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 11:54:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="802991107"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="802991107"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 11:54:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 11:54:38 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 11:54:38 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 11:54:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJxH3R+fhVF6W1yOux7724aYoH43ObeTRTdfLFca/2w0nsj2eOsKZEQKAclP8vVsGOn9MIZ8YMSfNWlQA3/sGtHJWAjnjaI9kLCLlmdrNvhaWEBGSHU3Qpd/k7ilBuax+0uz6dtEBgClACx6IIS7jqvFQhPCYrw2BCzfDISadg9F+0K4aPTF83K6N0QEr5x9TiBkXJju0GJo+5Jo3CETdTpTzvZY5Peg3ExbwsJAdyvGxi3/CsNPkW4/gyAfo3DcUIKiDE0VZReqh9pkFAnYUwlbYTNQ7ujrDmcoaDBARZEsLXxm/CNld9xry6IGXecqHn3JohM2/1X50IoZpYCtBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PKk63s5/N7TOpt00vRftf5+bvZmG0JNyrQ/GHYV7FY=;
 b=aP9bV49+6zk5B6fKXu7r0MprPsW4bYIJ+DZsiBK23ZV6cffietJkifvh8er2PAR0kNOyGk+QVUEyctva2lgDY33Yo5LbldklejZ9h0WgVMobTDovq+1VcVcV6Dvf6ICA083t5IgEPz4xbwdMhTW9hNLVhdg3M0H+IJ0My+Guk/51OJkpmoRI4lv2FX/429iBbYLZ4IvJ77vW92DZB4WfSNmhqaIfvKBBJhvTnwkTWwhcI05k9X+NfVYoYIE+cTySKprx4YboqyRUzcLaorraYI4+xTz5sEbr0a7UcDywHY5hbs9EdEmhVGbW5Bg5aqfNcG5z9QGhXIVA3NbMObDQ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH3PR11MB8547.namprd11.prod.outlook.com (2603:10b6:610:1bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Wed, 13 Dec
 2023 19:54:25 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848%6]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 19:54:25 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Mehta, Sohil" <sohil.mehta@intel.com>,
        "x86@kernel.org" <x86@kernel.org>, Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: x86/mce: Is mce_is_memory_error() incorrect for Intel?
Thread-Topic: x86/mce: Is mce_is_memory_error() incorrect for Intel?
Thread-Index: AQHaLfp9bgKjYRR/fkuwixIlQVKQBrCnnS1w
Date:   Wed, 13 Dec 2023 19:54:25 +0000
Message-ID: <SJ1PR11MB60831E048B544C83E845D907FC8DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231206013846.1859347-1-sohil.mehta@intel.com>
 <4ce89a5e-96f8-4939-b86e-f65c16f4bd4e@intel.com>
In-Reply-To: <4ce89a5e-96f8-4939-b86e-f65c16f4bd4e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH3PR11MB8547:EE_
x-ms-office365-filtering-correlation-id: 6f594a44-e35c-4847-b47d-08dbfc154eee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: egUl9InFnXt1q8ORmxbEjaxUo/tRYQ7BfYAWt569W01zf+cLT4XfxpQ9FMmi0QY/ltx2rLYnUQGxiL808y6yonI7G42bdvCsYC3C22xwdaMyunpLl5ka+uLUnTFya6vXmYYXBmQJPQtz6sT27uwz2+zkaXhnbkAwyy27JKBlFT3BAoNYmOOE68dOLtc5EMCScw45mNLe1aEJWTOi60KaeUkmbrjPVKGc6rqOrsEdr72FuKSV0OxtU2GgtN8mu8mIdO4ybzQ0UoOYJEO3q+u0aGgAc0/OqIoe+u/aDCrV/MmNDDxaxmGfkmz6VKY2eIM6pqcVxPPgr7NLO3mcdGFM9Ihyo5I5ykZG4y4hHzG5otmZv25dWT+C7QXRGv4H3zu2KIlUu8fPhFMWMDMFiBqafkc1ZR/U5g93FJ4L95fj1GxYOz/O8DTND61vlQ72x6rd3j25TbDppSv1zTG1nzeSm/DnBz/dl6aY10ROtN6q8twn6iTVNISPM2ko6pNUy0VtEc5NiUas38zwzop5d6cai2N68tsw2s5oBl59aulGBhz8avddQlARIF6UvqEbxjuI6PQOM18qiUnaLc7McXLGtQqX0/BRPyYg+B65DINX54pFWBporysOTKPujxGRI5nB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(55016003)(26005)(7696005)(6506007)(33656002)(82960400001)(38070700009)(86362001)(38100700002)(122000001)(4326008)(52536014)(5660300002)(7416002)(9686003)(71200400001)(76116006)(316002)(110136005)(8676002)(8936002)(66946007)(54906003)(66556008)(66476007)(66446008)(64756008)(2906002)(41300700001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aStnQXhOYWZQdHhmODdTTmdLMm81c1lsR2RiZkRYRSs0U3hGUzNPNE44QTE3?=
 =?utf-8?B?UTFmanlncm1PM25LV2t2Ymw3SnROMFdVZEk5T2trTnVIMzBoeG53eW5YVlRW?=
 =?utf-8?B?VkVqNExSaXhzNFBEd0pJYlRqWDNSamhWajU3N2xsT2R1KzV0ZUtIaEhtOEhV?=
 =?utf-8?B?cHV1dlppK2tZUkVXTUJyUWNvV3NuclJCNWtPbnZjYUkvamVCMldGeDBXWjlC?=
 =?utf-8?B?R293YURGVFNFV2lWRWlqaFhXSk90b3FhbDdsV3VrN1RudzErUEhObVgra09P?=
 =?utf-8?B?akJ3UVhsaFZLY3pNT2xOSjM4N0lJclJxeGY4WXFUVmdkemg1L1gyMzlKK2ZQ?=
 =?utf-8?B?VXZoUG8yUkVaR2pRR2k0VTZ4Sjgrck4zdFpDSUo5WEV1cGw3TlB0ODZ0dDVX?=
 =?utf-8?B?b1pqWXJET3NmcS9xVHkvZHJRdmJWSjh6OW9qNko5OTZUNXhpL0lQa1dvN3Qz?=
 =?utf-8?B?T2NGaUoxNjE0L3B5ZkYzY0xxbVJCVnhmbTYyKzBsUXNYdlp5bTM0aVN4eUlq?=
 =?utf-8?B?ajdadWcxcGtpdW1TelgwSzgrUVlWemZvL0FRM2RSNUIyUUNQSFRzKyttaTZN?=
 =?utf-8?B?SlY5ckJ5SkxlTm51SUs5NWh5aVlQMVRqNG03U2FxLzVqcm9rZ3RKVVBzak9J?=
 =?utf-8?B?VTA1c2lPR0R4YklwQ256T0VTUUlVbkZOcGxmdEl0MTl5WmxVVE90bWxoT3pa?=
 =?utf-8?B?UGYzWU5OL1NoemV5TnRwdkk0eUk0eXlkeTRtQkhwMTgvVGpjSmJaMWNrRm5h?=
 =?utf-8?B?Szc5UGozd3pLM1o4Rkx2QzVSeVpYMU0vSGptcHdza004eEZzci9abzlueTlU?=
 =?utf-8?B?eFhLVGE4M2kyQVB5NjhlTGZnTTZFWGJXMGNGL0pPMXIxNUdyYnlOT29Rek90?=
 =?utf-8?B?TklkL0UwN2huOE9MejlUSG1XUHJGQjJLWHdVYkJwSjMxWTY0enVuYm9qUVI2?=
 =?utf-8?B?ZDJQM0NvK1VQWTJ5Um5mRUdVUlFMY2pRdGhwckZSTmtXU01va29RM1l0S00r?=
 =?utf-8?B?ZGNBVmdqSVNkUjU1SnltU09EZ1VHRTZFbFQyNnMwYmE2Qmxvdzh3dTBQd3NJ?=
 =?utf-8?B?VnFUZGVYUFVjU3FJaHV2ck9SWVlpQlhTU0NxRlVQaHd2SzJodUVENnpNZ2dI?=
 =?utf-8?B?eFdwQWVMcVdtZTg1eGNueEQvR25uNDhFbHBKR0ZwK2NxeVJIcGpQTTk5aWVi?=
 =?utf-8?B?OEt4Rlh6bEVuRWJyYUdLU1p0RmRlU0swV2s2c3JZd2xQMk5IVHRrR2RlZ0V5?=
 =?utf-8?B?SDFybmxoRUhocFh1Q0Y5UktkQlUwNmR3Z3VyWlNZY2dLMi9XcFFCZTRveDRN?=
 =?utf-8?B?MUdOQm43MGszTkJQaWZha0kvTnNSdU5wRXV3M0p3K0FNY1pOalgvbENaT1NN?=
 =?utf-8?B?NTY2VVplNjNjQ1B5OEk5aElXT2gwcGV4R01paC9GVmU3N0xUeklwUktpUm0x?=
 =?utf-8?B?OXJJR0RGUlpINVBRT0NmNmZFKzEwWjNXZHdPZVBFUldEQWlZTzJjZGhpTzhC?=
 =?utf-8?B?WXBLNlcyb2FsaEEzdUM3aDR2SWFIYU55dDhja3ZxKzlZdi9RNFkzRWw1N1BI?=
 =?utf-8?B?R0ZuUWxXcDYzdnU0RmpTVGlmZkxGWFZGYkVlV1dkMmRUbm1BYTdsR3ZuSjNX?=
 =?utf-8?B?SC9qcEl3T3YxaUVVUE5abk5icDN2OUluVDhXQkFwNnl5S082NE1FMmcvbk1L?=
 =?utf-8?B?YjJDclJ5bVRJYWJCU0txNyt6VWJMcVN4YSt6cVo2NktqeTc5cUw3czFVbzJR?=
 =?utf-8?B?b3BiYmZ4QytZU2Z2b2FTdnM5RkFkMHE3WkJpMytkUGdtcmY0R1N3RXVXKzA4?=
 =?utf-8?B?UGhhU0xTOFN1VnRqV3VlODZubjIrVjRVS2RRMWUyajJqczNIZkpNU3VFU3FQ?=
 =?utf-8?B?WWdIN0JENUx3bHhlL21hNFdRdEhJKzNWbnlQSDVjQ3E1S0xNMUNKTXl0WGFD?=
 =?utf-8?B?TFlGVW1JeFVwS2ZtUUFvblRzOUVTR0ZqM25OUmdTMjZQMGxvcE5XMG1UNjBV?=
 =?utf-8?B?Ynp6QzV5bzVxT0FOU2hMTTRxYStEOFRmT3RDditlZmZTWUhOSkNkNnNxbDRz?=
 =?utf-8?B?UjRhcitHYW1BcDJzeWVpczZUY3dFQW9JSUE5TUVKZk9TUDgwV29Vc3ZFbDB2?=
 =?utf-8?Q?k28TDBUBeXlU2gmQfPCrFYbkE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f594a44-e35c-4847-b47d-08dbfc154eee
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 19:54:25.1734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stFj4p/bPMS0n+X61TGZ9BWa/tdgbPclrKWB0g6KRFfLgEXlic0khTqFO2kWFqW3ALgGnFJOrs8Zb1w9jPuZuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8547
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

PiBUaGUgY29kZSB0cmllcyB0byBpZGVudGlmeSB0aGUgbWVtb3J5IGFuZCBjYWNoZSBlcnJvcnMg
YnkgbWFza2luZyB0aGUNCj4gc3RhdHVzIGFuZCB0aGVuIGNvbXBhcmluZyBiYXNlZCBvbiB0aGUg
Yml0IGVuY29kaW5ncyBiZWxvdy4gQnV0IGl0IHNlZW1zDQo+IHRvIGJlIG1pc3NpbmcgdGhlICJF
eHRlbmRlZCBNZW1vcnkgRXJyb3JzIiBlbmNvZGluZyB3aGljaCBtYXkgaGF2ZSBiZWVuDQo+IGFk
ZGVkIGFmdGVyIHRoZSBvcmlnaW5hbCBjb2RlIHdhcyB3cml0dGVuLg0KDQpUaGF0J3MgcmlnaHQu
IFRoZSAiRXh0ZW5kZWQgTWVtb3J5IEVycm9ycyIgd2VyZSBhZGRlZCBmb3Igc3lzdGVtcyB0aGF0
IHVzZQ0Kc29tZSAiZmFzdCIgbWVtb3J5IGFzIGEgY2FjaGUgZm9yICJzbG93ZXIiIG1lbW9yeS4g
SW5pdGlhbCB1c2UgY2FzZSB3YXMgZm9yDQozRC1YcG9pbnQgKHVzaW5nIHRoaXMgdG8gYWRkIGNh
cGFjaXR5IHJhdGhlciB0aGFuIG1ha2luZyB1c2Ugb2YgcGVyc2lzdGVuY2UpLg0KDQo+IFR5cGUg
ICAgICAgICAgICAgICAgICAgICAgICAgIEZvcm0NCj4gLS0tLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgLS0tLQ0KPiBHZW5lcmljIENhY2hlIEhpZXJhcmNoeSAgICAgICAwMDBGIDAwMDAgMDAw
MCAxMUxMDQo+IFRMQiBFcnJvcnMgICAgICAgICAgICAgICAgICAgIDAwMEYgMDAwMCAwMDAxIFRU
TEwNCj4gTWVtb3J5IENvbnRyb2xsZXIgRXJyb3JzICAgICAgMDAwRiAwMDAwIDFNTU0gQ0NDQw0K
PiBDYWNoZSBIaWVyYXJjaHkgRXJyb3JzICAgICAgICAgICAgICAgIDAwMEYgMDAwMSBSUlJSIFRU
TEwNCj4gRXh0ZW5kZWQgTWVtb3J5IEVycm9ycyAgICAgICAgICAgICAgICAwMDBGIDAwMTAgMU1N
TSBDQ0NDDQo+IEJ1cyBhbmQgSW50ZXJjb25uZWN0IEVycm9ycyAgIDAwMEYgMVBQVCBSUlJSIElJ
TEwNCj4NCj4gSSBhbSBub3Qgc3VyZSB3aGF0IGFyZSB0aGUgcHJhY3RpY2FsIGltcGxpY2F0aW9u
cyBvZiBnZXR0aW5nDQo+IG1jZV9pc19tZW1vcnlfZXJyb3IoKSB3cm9uZy4gKFRoaXMgaXNzdWUg
aXMgY29tcGxldGVseSB0aGVvcmV0aWNhbCByaWdodA0KPiBub3cuKSBBbnkgaW5zaWdodHM/DQoN
ClRoaXMgZnVuY3Rpb24gaXMgdXNlZCB0byBjaGVjayB3aGV0aGVyIGFuIGFkZHJlc3MgaXMgT1Mg
YWRkcmVzc2FibGUgbWVtb3J5DQooaS5lLiBmb3IgYSBwYWdlIHRoYXQgY291bGQgYmUgdGFrZW4g
b2ZmbGluZSkuIFRoYXQgZG9lc24ndCBhcHBseSB0byB0aGUgY2FjaGluZw0KdXNlIGNhc2UgKHRo
ZSBvbmx5IHdheSB0byAib2ZmbGluZSIgc3VjaCBhIHBhZ2Ugd291bGQgYmUgdG8gb2ZmbGluZSBl
YWNoIG9mIHRoZQ0Kc2xvdyBtZW1vcnkgcGFnZXMgdGhhdCBpdCBtaWdodCBiZSB1c2VkIGZvciku
DQoNCkknbSBub3QgcXVpdGUgc3VyZSB3aHkgYml0IDggKGNhY2hlIGhpZXJhcmNoeSBlcnJvcikg
d2FzIGFkZGVkIGludG8gdGhpcyBjaGVjaywNCkl0IHdvdWxkIHNlZW0gdG8gaGF2ZSB0aGUgc2Ft
ZSBpc3N1ZXMgYXMgZXh0ZW5kZWQgbWVtb3J5Lg0KDQo+IEEgY291cGxlIG9mIG90aGVyIHBvaW50
czoNCj4NCj4gLSBUaGUgY29kZSBzZWVtcyByaXBlIGZvciBhIHJld3JpdGUgdG8gYmUgcmlkIG9m
IHRoZSBtYWdpYyBtYXNrcyBhbmQgYml0DQo+IGNvbXBhcmlzb25zLiBJIGFtIHRoaW5raW5nIG9m
IGRvaW5nIHRoYXQgaW4gYSBzZXBhcmF0ZSBwYXRjaCBhbG9uZyBzaWRlDQo+IG9mIHJld3JpdGlu
ZyB0aGUgY29tbWVudC4gV291bGQgdGhhdCBiZSB1c2VmdWwgZXZlbiBpZiBubyBpc3N1ZSBleGlz
dHM/DQoNCk1heWJlIHRoZSBjb2RlIHdvdWxkIGJlIHByZXR0aWVyLCBvciBhdCBsZWFzdCBlYXNp
ZXIgdG8gcmVhZCwgd2l0aCBzb21lIHdlbGwNCmNob3NlbiBuYW1lcyBmb3IgdGhlIGJpdHMgYW5k
IGZpZWxkcy4gT25seSB3YXkgdG8gdGVsbCB3b3VsZCBiZSB0byB3cml0ZSB0aGUNCmNvZGUgYW5k
IHNlZSBob3cgaXQgbG9va3MuDQoNCj4gLSBSZWx5aW5nIG9uIHRoZXNlIGJpdCBlbmNvZGluZ3Mg
c2VlbXMgcHJvYmxlbWF0aWMgaW4gdGhlIGxvbmcgcnVuIHdpdGgNCj4gdGhlIHBvc3NpYmlsaXR5
IG9mIG1vcmUgdGhpbmdzIHRoYXQgY291bGQgYWx3YXlzIGJlIGFkZGVkLiBJcyB0aGVyZSBhDQo+
IGJldHRlciB3YXkgdG8gZG8gaXQ/DQoNCkNvbXB1dGVyIGgvdyBhcmNoaXRlY3R1cmUgaXMgZ29p
bmcgdG8gZXZvbHZlIHNvIGNoYW5nZSBpcyBnb2luZyB0byBiZQ0KbmVlZGVkIGhvd2V2ZXIgeW91
IGNvZGUgaXQuDQoNCi1Ub255DQo=
