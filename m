Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B047892C3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 02:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjHZApz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 20:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjHZApv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 20:45:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC3026B6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 17:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693010749; x=1724546749;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LElZVk46MXN6GOoOrEMEAt6OT/o9sLtpoLlRRFHxXc8=;
  b=LjODiTS5H2f0F2ilvMnYo+Etzkf/ba4OtxSmGdw6+o0pc/g/ZtJv5VPX
   PjrHWgLDmjtNFuCUM0qY8xsAD2VMiKMEC0r6hGaP9ZTcwnwjIxNuaIMKt
   +JJLY3ttgVtEUZcTFO+W/pe6i7Oreevh6Zq1D8TxUAv0VD9EhVIu8RPiT
   h48qISz/M2cfOYAzZ9F0p/tUzrDImNh6CoxukDVNkkKsYLu1AGz0XPXRA
   uElRMl0PtPDfWtUDHnbvEImR8NSxbhqbCP4RgtvIdjQGGOOD1W7e36gIg
   YqbDZJkKJ24rrr1zuPE8QiboYtTfpXHSk+9/8VjQ9slpJqpYi2jRFWlWD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="378614498"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="378614498"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 17:45:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="803127607"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="803127607"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 25 Aug 2023 17:45:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 17:45:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 17:45:47 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 17:45:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHWsuX2EYFKXAYF0CuJ00IgkhmPsDLegg5mR5CTT9MyJUyc4ITGutGBfLNZuV52/7REFnSSluHgQfnbptS77Ohwuvp2gYnMGSEw7t8PfPnGRxz01Tx3Qvx8XOsVyJQChg5JfRosaVPm5aR9CeONsbKlIgl0yt5wy6bVVyzyMZ1dh2Y3nVUqSa4akoz76vMitReO4bHtY4yyPjBlHZYjm+oTM5jD0AdNRq3In6AYtF6EuuBEEL0uRw4LXgID4m9dvZTQFx6TfeZLNP9gbhz/10lJa9lVE2EUsfSIRXGqRiVZ2dTukotPS9nK6WY71fK2O4ko6DYBQ7daRSoQxs58i6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LElZVk46MXN6GOoOrEMEAt6OT/o9sLtpoLlRRFHxXc8=;
 b=GtpYwleyETYkXcld+Ikzu8GBtLU1wd0LzrSrHni5Z6hq72KOVFFgteBL5AS+LDKdNxN0UljZRupuicm4HvnuG/BFYt3NKzFSC130/dYiQOBVkd0NLIyCoa7IvbBobUB06yyDpP4ioNHMm6Hw7e3qikxnU7TlvLWvLHoenS3ohcPi1B0C3NamOlTlRmNvvDZGPT+y7LHOaYEB2XW9wVPuq9HaFa0qFNxCV5+AEfiegQjBh3N5cwTzxMWm0gGsnZcWeK6indAhz97wZC3oAmryyWGbn813cekwPZTku7UIWExBv8qchLxN8t/QWBrA1naZWmLC4WLK6OjGnkkgKoXkPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SN7PR11MB6993.namprd11.prod.outlook.com (2603:10b6:806:2ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Sat, 26 Aug
 2023 00:45:28 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6699.028; Sat, 26 Aug 2023
 00:45:28 +0000
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
Subject: Re: [PATCH v4 12/12] x86/virt/tdx: Adjust 'struct tdx_module_args' to
 use x86 "register index" layout
Thread-Topic: [PATCH v4 12/12] x86/virt/tdx: Adjust 'struct tdx_module_args'
 to use x86 "register index" layout
Thread-Index: AQHZz2d8pcIgXWwxVUy8S+3Z2ve+rq/7vWIAgAARAoA=
Date:   Sat, 26 Aug 2023 00:45:27 +0000
Message-ID: <c7ce1d6e1f83ddb3c0af5607563bc26056df7fe3.camel@intel.com>
References: <cover.1692096753.git.kai.huang@intel.com>
         <fb599b890b34c7d76c57543a784c281111ea0bf0.1692096753.git.kai.huang@intel.com>
         <20230825234432.3ynoxtlguhqj4axl@box>
In-Reply-To: <20230825234432.3ynoxtlguhqj4axl@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SN7PR11MB6993:EE_
x-ms-office365-filtering-correlation-id: d4ee8a29-a90b-48c7-bd19-08dba5cdbe1d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nlVhC8IPf7HsKoFbC9/uSF5KQ6buq2TjYc62dMoEwinXhHlcEi+yOzmzy2KohWoaHpqZs7iqTXRa41nTthfS6isvSdOtKu14e45YxX6eU36PoBIB6kOVLYcOKASkyHJKRK66eAQtE7/3SEPgIfi5envoCABOt54SQE1WJ96ECcbK/CV+vYOVpOBOvjRk0AHkISjVDe5tLbMTG4wv3w8a4YwggELi4h8XW9ycMEOI2OrcQx8LNmQAPoYTlkcw4+V1AppfyvY/MFmL8TAxAT5nWtxCR6Ix7V1FFBWIQG0NNUdm1PWN9PxmvqRTOVpZf92+yZb4Fu44ZBpB9KOm+wBxI4B7mZmm3wkcL9kqwNGwe6dtIwtVK0rZvtgb6nx4tH2tX8PFQtYbFvoWlZo17hklqoxTwa3buGKomRMhZhCZ8CdS+RYwAu1P+RS1xRCBclA9cAoqZRF6O9jqsx4WrKuAvUNfyJ2XRF+GNQ0x9TBg6c+SBYdaFLo4v1TI7gU0x4VqefAbJh8FVwl4Bw4/ZNgV+WRe0hnddJEm5nvENJ7JRqDAiGkxEL+P+jF6o6BYbNXNjNE4XJmTRCqaO3APpwO/+UTp3FNgSeksYeGplLpYpnhteIWxEFMpIe3QINQs92mP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(186009)(451199024)(1800799009)(64756008)(2616005)(83380400001)(6512007)(26005)(7416002)(66946007)(41300700001)(6506007)(66476007)(66556008)(66446008)(54906003)(91956017)(8676002)(6916009)(2906002)(4326008)(8936002)(6486002)(478600001)(5660300002)(71200400001)(316002)(76116006)(82960400001)(86362001)(122000001)(38100700002)(38070700005)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0h3VFJZRHA4cGhhUDlGMU05MFJWMlFPVm5idTVsSzViUmNUakh1TVQ2N2l4?=
 =?utf-8?B?QXhwbldtZTI4RTZPRzM3RXdaRTBNWnUxRFVuTkx6Q1hOQU5HTCtCZzFmaVph?=
 =?utf-8?B?UjFqZlVrUHVHTis3cUQxZ0tiNGtXc09iV2tRRXhxZzVqVU1NSE9XTHJib0tq?=
 =?utf-8?B?WEYzZnJMYlZYMTV4QUVFWlRpUEo2cThuNk4xaFdWZ2JzU2hjd0RXdDUrc2pU?=
 =?utf-8?B?NEtiRUxrVHNSdUNPRUJYZ2QrYXYySUE3L2lPUmdpeEE4OGVNcllJTkEzWkhj?=
 =?utf-8?B?RTdBdFhDVEtoRXZicFh6TnpseTJmUmRpOXBTWWFuTlZJYkdNMEJJc1RrMEIz?=
 =?utf-8?B?RTJmY045UVVpNFNwSys2UnBIVURmNHRVRXcyYnJKTlZyMHNNYTl6TUk1NXdR?=
 =?utf-8?B?VjRsZWVKR0tSbVFwQWNyNlJNZTNYQ3R3MFpVL3VaTFNBUWhzYTh0bDNuSVh3?=
 =?utf-8?B?N2pBRXlEa1RucVl6T0h1dCtmZXUvTml6eW1ORXVBbytPOEZUWXdYR2RvS0ZR?=
 =?utf-8?B?dlZvME9KVE8xekFVczk3VGoxTXZISlJLN0FMWHdrbm9IVHpTRU5DZENvaWxK?=
 =?utf-8?B?TFA4LzNCaTJrNjdDOW9sSlBLZXU4MytqT1owQU1JbDFSQy90SkJuOVpnMHRP?=
 =?utf-8?B?d20vOEVQQndsVjVsZytrNS90VVRwVlAwNGxMUzA1djN3Q1k5MVluSysvRHZC?=
 =?utf-8?B?cmxhNElxMFhpOVZ6bE1JdmRLYzd3V0ZkY2ZXVzJjanRFMWlzQktidEtzZWYw?=
 =?utf-8?B?bHZ2T0IvbjdXSEkzbzhYZWZ5Q3Rybk4wWG1YU2VKZFpwd09YcmR3aVpnSnph?=
 =?utf-8?B?RGZ6MU51K1hQQ2xIVUJlbGlyQUdvU2hldXpFOG12eFFuRE9WbWZJT0JCOEdx?=
 =?utf-8?B?bWtEOUZ1RkhqRWNyZjUvVDAxMng1RzVsRTlPTFIwSkFBZFVFV2ZVMDZVSWw4?=
 =?utf-8?B?dlhYK3BuUEFOWkI3SlFnc1E3SklOM3pvZzNFWkhLbXNZZlFTMXhDZW5Ucnds?=
 =?utf-8?B?SVQzdk8wck90clRYZW5BWUhIWThsWjg2ZUFYZTJpcDJNRUpCMkduUm4vN0NG?=
 =?utf-8?B?UDA5bzVxeXl6bmZOc1daK2VaY3Bzem1ILzZ4bzE3bkRJay9BZTlmTHpiRGRU?=
 =?utf-8?B?MXBUSjAwMzRzMEFINmZycU1Cb3BWUlN1aVJ1THo2V0Q3c2JOcWp6SGxkK3ds?=
 =?utf-8?B?UnZ2OHZxcVFtTDFMY255UFZBeldrbDBpdjBPSFNXdkZGWnN2Q01IK0dWajZh?=
 =?utf-8?B?SkNRVjd2R0xhNVdxNDFKZHRvNlNXRTZNRDl1Ukc2ZVpjRy9rRHNmMmlySWc2?=
 =?utf-8?B?ZmxKaXdOVXBjdzRpQU5kYXRaUXJ1TjQwc3VWdXJ4UC8xUHJUU0RrK1BPdVFm?=
 =?utf-8?B?TytjWkZoY01FeG1nQm4yMDVNdlltcG5JOXpzTXJEMHY1VlJTeXJFZ1hhYnBG?=
 =?utf-8?B?K0JVMTd4K1d4TEw3K2RqOXBjZmlFRjlIcU1yZzJsTVBXRXpOSjZRYzBmRGtz?=
 =?utf-8?B?MWIyVHJmZElHWDhTNm11YjhaWUsxaTZmS0hjeC8zL01qN2RsVnV1Rk5oMDQ0?=
 =?utf-8?B?c3luN0tpZGkrWTJJUllGY0JQS0pmcEdHV2F2SWdEdGdFQTJIeHNUZnV2Q3M0?=
 =?utf-8?B?VUpHcWdwK1I4MzBOMWZoSFZDczNLeW1RWjdVOWE5STBpNHROQWpVZHNoM3U5?=
 =?utf-8?B?cDdBeVBVRm9KeWJ2SnhZeEhheWFLb0xhUHd4MUxseGNDV25CajBweWdnVGRJ?=
 =?utf-8?B?dkhFcndCMm93UlFSV2FEQkhOODFya1Z0OVRmcXBQWDh3aUlhekVYZlZGNWVI?=
 =?utf-8?B?eFByTStoR1ljcVkzNVlOSjcxWStRZXFNMVhxZWhWOU1CcHlqS0xFUDJwMUtY?=
 =?utf-8?B?WEpuUk5NR2krVXlBRDVITzJpMGRNU3dhR0tZWnBmQjd2QnptRzBOTHJudHE1?=
 =?utf-8?B?eGlmMG9CUDFmMGQ0Y2cyd1R6bkN1b25ib2lWWWRFclFSREpsQzdrZEMzWnBX?=
 =?utf-8?B?anRoWCtpUHFNOTlKWllpdDdhakJGNElGajJ2dGM3bld3NDNBV0lXSDVsUEhY?=
 =?utf-8?B?Z2FlQW5MeXB3d0kwRHdWMUJrRjhUVE5lTm41UmNIM3grdWJjd0dIUmZWazcw?=
 =?utf-8?Q?aFedBDRFDjioTnOIvDFwa9myS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E32BC5BE36BC5447AD090C03E4C73B6A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ee8a29-a90b-48c7-bd19-08dba5cdbe1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2023 00:45:27.9501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nXnkPPzGowi9+dMrDJnqlLbkknC23plJX689vw9XiPEjvjz3CnGgqkS1oRcBqgJGL2SUSp5N+PX72W3Y3uQl0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6993
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

T24gU2F0LCAyMDIzLTA4LTI2IGF0IDAyOjQ0ICswMzAwLCBraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tIHdyb3RlOg0KPiBPbiBUdWUsIEF1ZyAxNSwgMjAyMyBhdCAxMTowMjowNlBNICsx
MjAwLCBLYWkgSHVhbmcgd3JvdGU6DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUv
YXNtL3NoYXJlZC90ZHguaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NoYXJlZC90ZHguaA0KPiA+
IGluZGV4IDc0ZmM0NjZkZmRjZC4uOGQxNDI3NTYyYzYzIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gv
eDg2L2luY2x1ZGUvYXNtL3NoYXJlZC90ZHguaA0KPiA+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUv
YXNtL3NoYXJlZC90ZHguaA0KPiA+IEBAIC01OCwyNCArNTgsMzEgQEANCj4gPiAgICogVXNlZCBp
biBfX3RkY2FsbCooKSB0byBnYXRoZXIgdGhlIGlucHV0L291dHB1dCByZWdpc3RlcnMnIHZhbHVl
cyBvZiB0aGUNCj4gPiAgICogVERDQUxMIGluc3RydWN0aW9uIHdoZW4gcmVxdWVzdGluZyBzZXJ2
aWNlcyBmcm9tIHRoZSBURFggbW9kdWxlLiBUaGlzIGlzIGENCj4gPiAgICogc29mdHdhcmUgb25s
eSBzdHJ1Y3R1cmUgYW5kIG5vdCBwYXJ0IG9mIHRoZSBURFggbW9kdWxlL1ZNTSBBQkkNCj4gPiAr
ICoNCj4gPiArICogTm90ZSB0aG9zZSAqX3VudXNlZCBhcmUgbm90IHVzZWQgYnkgdGhlIFREWF9N
T0RVTEVfQ0FMTCBhc3NlbWJseS4NCj4gPiArICogVGhlIGxheW91dCBvZiB0aGlzIHN0cnVjdHVy
ZSBhbHNvIG1hdGNoZXMgS1ZNJ3Mga3ZtX3ZjcHVfYXJjaDo6cmVnc1tdDQo+ID4gKyAqIGxheW91
dCwgd2hpY2ggZm9sbG93cyB0aGUgInJlZ2lzdGVyIGluZGV4IiBvcmRlciBvZiB4ODYgR1BScy4g
IEtWTQ0KPiA+ICsgKiB0aGVuIGNhbiBzaW1wbHkgdHlwZSBjYXN0IGt2bV92Y3B1X2FyY2g6OnJl
Z3NbXSB0byB0aGlzIHN0cnVjdHVyZSB0bw0KPiA+ICsgKiBhdm9pZCB0aGUgZXh0cmEgbWVtb3J5
IGNvcHkgYmV0d2VlbiB0d28gc3RydWN0dXJlcyB3aGVuIG1ha2luZw0KPiA+ICsgKiBUREguVlAu
RU5URVIgU0VBTUNBTEwuDQo+IA0KPiBJIHN0aWxsIGRvbid0IGxpa2UgS1ZNIGRldGFpbHMgbGVh
ayBoZXJlLiBJIGRvbid0IGZlZWwgc3Ryb25nIGVub3VnaCBhYm91dA0KPiBpdCB0byBOQUsgdGhl
IHBhdGNoLCBidXQuLi4NCj4gDQoNCkkgYW0gZmluZSBkcm9wcGluZyBpdC4gIEl0J3MgYW4gb3B0
aW1pemF0aW9uIGFueXdheS4NCg0KSSdsbCBsZWF2ZSB0byBQZXRlci4gOi0pDQo=
