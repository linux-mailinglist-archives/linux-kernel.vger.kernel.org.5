Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021B07B98A3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 01:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240547AbjJDXSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 19:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjJDXSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 19:18:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1D1C0
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 16:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696461488; x=1727997488;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NLfaBnzRrcV8JkYANU35Irybs13SorYkUL7VHzeCpDY=;
  b=K+62lzvzpp/Sy2DtPnRveV42kKrg/oNazmT9HLCRg/9ipAHRDnwk45dg
   dbzPEq2wKSX66kEd8/ivCS8NEGxwhnJJ+csckpycbEGM6xeFuxxu7qypv
   jw3l5XVyYJWkDJNj8m0b8rJZ/srs/0UjoGOw2KFfgWDoAiGEgbHj6ZJkw
   HBL70RQoo5QZ09Jay9cbU614pBfqjH2S+cNStFzojZwu4HMwAtXsVAbtJ
   nyTCRAWP1h2ueMgoeHuX2cLNyxvf38LfcU2WkB7JwvfldzjFS1BuSn9Ub
   6g+ATxOPOfshdyp1XB7OSuwudzlOsymsGB1i7flxSnuHQ+tHOuCFgAj9b
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="469605832"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="469605832"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 16:18:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="755150909"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="755150909"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2023 16:18:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 16:18:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 16:18:06 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 4 Oct 2023 16:18:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 4 Oct 2023 16:18:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GawbTh8cUIgL3Aigq9PCSRKDW2630mcUHQiboKquFJAh6kwL9HEE1QvJyESQVeReZMfPVk0aR7r8+9W418MJnNgndyrwTlN5OkXnbdnxShVFSzLCpEFnkRIPWP/jzzFDzPDI7xEeTrKVtEcMIEphNAZJ5/qyI6Nkny0fBH2jnsP6OcI/mF8rCAzF0Ghw43v+btS3uQr6BthKbnRMn6e/z0iIiIXSKC8/4T7mH2bSqI0e/S2D3910hjXAFXZmVrGUF1xGmVhFCDVvraZjPi97pJKrhnl4CDIkLPzlw7uVSCH+PuRQ14Odf7Tr9s/h2jsrwoRcytxzM5iLtZ+R7P2WWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLfaBnzRrcV8JkYANU35Irybs13SorYkUL7VHzeCpDY=;
 b=ed4hXMORzlQ97QkcfzmJm6lmcHxUyOtkKTe/3GIpSgM6p52XoTek7D4uEckdWlA3Rxs+Y1hHMFndociZpSniX/fGG9yGkBrJEhiWabqB6yubQ9p2LyssUxOFlEyVcivp1ep4eHSPmgHMohSHQ9hhfMs43MZJ8BQ7uElRUsOhcnTkOr8ntjjwbGD4ucy9Vt0oXtwoUgMS/CU2ggLywV1DIZV4kkqi+eUayExMFhWLEYXM9it2MOLUaGYPXJxqHO+VUMlPOZhsaT06z87rQSdTdhx7v45TwPN6tldPS0JuhDXUS5ZiTrsgxFk8Hbgd1YVn7RNhW15J/48vDz/HROflsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by DM4PR11MB6094.namprd11.prod.outlook.com (2603:10b6:8:ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 4 Oct
 2023 23:17:54 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::1a1e:c953:cc6c:439]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::1a1e:c953:cc6c:439%5]) with mapi id 15.20.6792.020; Wed, 4 Oct 2023
 23:17:54 +0000
From:   "Colberg, Peter" <peter.colberg@intel.com>
To:     "russ.weight@linux.dev" <russ.weight@linux.dev>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "lee@kernel.org" <lee@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rix, Tom" <trix@redhat.com>
CC:     "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH 3/3] mfd: intel-m10-bmc: Change contact for ABI docs
Thread-Topic: [PATCH 3/3] mfd: intel-m10-bmc: Change contact for ABI docs
Thread-Index: AQHZ8iuEUroGGuJgHkKPBVNcSxabrLA6TacA
Date:   Wed, 4 Oct 2023 23:17:54 +0000
Message-ID: <f555dd7162546ab766a4e2f85dadc09bc10e2ade.camel@intel.com>
References: <20230928164738.278635-1-russell.h.weight@intel.com>
In-Reply-To: <20230928164738.278635-1-russell.h.weight@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|DM4PR11MB6094:EE_
x-ms-office365-filtering-correlation-id: f228d02c-3e21-432f-6705-08dbc5302365
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W7KyU1YgzqMtpnNZU/ziigfxdMSDy1NGlT6PDdT4J+hQpn/3Uzf6g9lQSOP5SJAEzn8i+f2u0JHtFnz6MzUa4UKBUUrfgx9GlO6OPjmTyMZXjBUSAAsgJWrVbH6T08SRntSDAcy1N8cwrACWqiVOBFcgBLRU+rXjSgwVxdKWxyn/BIicHgTx6vWeZdbRSR9uYQhzkKAojul18KKZbZm3i8ulEtofX1MiMp1FJMTqvUxHVEutQEHNalCJltZkPkkxIV/nkj/tVfope5AL3VzgfP00fmklp7AjA/qd6YB7xZbXiRhjgxcYZ0lCenoZyQNu7k0C7RTKJjM4T1idSW3f7fchZz6daNOFElopNL7UB5A1YTYdP+ZorBLh+jkcYEz++6i04xrDyM7np5pn3wh2pnD18jmhU7i7+ZmuBCkMcWk0RqmZ3s0muvHvtCRalLZ49Yd/pAAkWGxfCH6s6+H7Jpow8BZd7CJBcLaDZKQOlf4E8tBLT4HjCp0ky8u7Q79tSyXOxBJX2PgB5fA0ca2tWAv9FbtxOlck7L4Dqdl4i8hLh3VGczaKryfC7RXYftXc3m/mn8vbbdRQbEpUDPN5gVyuKxvyTYeDFT2wf1qa7urmARhVqs0sTQ/ksbkPKrZ7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(86362001)(8676002)(5660300002)(8936002)(4326008)(2906002)(478600001)(26005)(36756003)(82960400001)(122000001)(6512007)(2616005)(38100700002)(38070700005)(83380400001)(6486002)(6506007)(71200400001)(316002)(110136005)(91956017)(66946007)(76116006)(41300700001)(66556008)(66476007)(66446008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YldDVC9obTBpL2NFVFZheFVIM2xpNm4xWVp5bjFkajhwbU1lSWJ2eWNuQnVY?=
 =?utf-8?B?ZzFkS2Rhd1ZGTlBUZ0ZRYzNITG9zYzd2SEhrNnlDTC9OaTdHamxsRktmQkdr?=
 =?utf-8?B?d0tMYlZQMDhCVFFMckFubUptWUFYeWRiU2xwS0g2Mjl5a1RSbk81VE1yZzFj?=
 =?utf-8?B?N1RlNGJJVmJQc3lSNEM3NWxGM0NOR1UyaXRhVTZMaXpnL0RYVkVCZ05lcVZi?=
 =?utf-8?B?OTB1dW5IN3NkM09ZNEdPMVNBU3dXR0lIODl2V2J4aVFsNlpLUnloOWxFM29s?=
 =?utf-8?B?RjY5Sk5QZ0p1NmM5VkE2YndleXZhV2JOYUlnL28rRW1ndXlJWUF4QTNsTisy?=
 =?utf-8?B?S2wrdmN2eGZzTXZzME0vMGVCT3R3RllIWXh6bHd1eVZ4eTd5bE40Umg3OS96?=
 =?utf-8?B?Rmx3TzBhZjhUOGhOcTRieWx1Umw1Tjh0bEVzaGw5YXdpeDJseHNpeWNpTld3?=
 =?utf-8?B?VVQ1YktlYWwvZmRsRWQvMlBmOThPS0dMVm9XWWZ1Z1VzcmZZQ2dHKzljQkNT?=
 =?utf-8?B?ZUcyWStMRzduQi96Rlp2QkVkVHN6dVMyQW84SkJqbGxQUjh3RFhqTGxMTjJX?=
 =?utf-8?B?YS9RN1dNMEpIckxNUWR3QmVwbjc2TElVK1dzNXprZ3dLOU10d0IzZXB2UGps?=
 =?utf-8?B?Q21mOWtscWEyeklIZm9ZajRpQUVmcEtFRzVGOFBxOUZPYnoyTU9KMzdnRUkr?=
 =?utf-8?B?ZWlzekR6emdPbjF0eHZDRTF0eXFwU3BuUzc4cldwdHNqakljK0tIbFZ1VnUr?=
 =?utf-8?B?NFhaMXJZekhXekxwWnhwcFVLL1dEVmI3Q3l1VFNNN2x3ZnAzeTlFRzkvMUdW?=
 =?utf-8?B?bDdWN3MyanZ3SHI3K1k1MUJOL0tOUStjZG9US052SzVWWGNlYklRd2VpMmp4?=
 =?utf-8?B?WHRVa0FDbjFCbDBHS1lRRnh4RVhIWjM2VFcyMnFmRmZPQVRWRVl0citXWVN0?=
 =?utf-8?B?RFdwNjdWRDVyWUlYWkM3cm1menc2akFjMzN3UjgyalB0dHZ4cVl6dXRaazNL?=
 =?utf-8?B?WGFDdnhpNnNiNU0xeHd2YmI1MkliaEY2aE9zVkFXaWQ0K1dMTmdzdnI5NExq?=
 =?utf-8?B?RkZRcU15cVo2a3NUNHg2YkZUTmoxaWhocTE0OXc1TXJqaDNGdTk4byt6YTlz?=
 =?utf-8?B?aS9GWmhCUEgvZTRBbVdrdEJaV1NTcm0xMTZqazlzM3lDSDJpVFE4bWJhUldy?=
 =?utf-8?B?eE1TNnVNb2kwbzZPVElaUTU1SGNSeXVZb1VXS3YrYVo0VUpJTDdvcUx0L2di?=
 =?utf-8?B?dXVyT2ozTDd6UlYrVlVmczBPZm96cG9zV0Q0U3RIbTN5enJXeVJYMElFcEJ1?=
 =?utf-8?B?TjlRMFZXeGtieExET01vb0lTVVJoTit4SGdaUmplbjVBTUdqL2kreFNObm4r?=
 =?utf-8?B?YVRXS29jc1dGNXdRT0JQZURZQnROV0dSOWd2eTNwMExPR1dYNHAvbkNmZjlH?=
 =?utf-8?B?QUlxN1JOV01rcXlIeXNCbkdSZ3ZIaENkVC9MMXE2emN0KzhyLzdnUTBVV3hM?=
 =?utf-8?B?U3plVERRNW1GYXZYTlE0eWwvNzNyb0hlZTc1N21ZL1IwWXdndUpmUTA2UTVO?=
 =?utf-8?B?RlA5Z1E3NzR3c3lTOTFNN0c4bjJqaFU3a2xMcDc1ZjkxWitvSjVzNVo0ZG4z?=
 =?utf-8?B?aE1SS1h0WFVYbVFKUllOdjhObjBYMzRWVHRoTnRSV3pZN3lvNXh1Y3JSclkr?=
 =?utf-8?B?dHA3eHBIQnlPSHp5K0RucXltL0EwbDZVUHZzelh4VDc4RU13d3hNY3ozSjQy?=
 =?utf-8?B?WEVoRkg4Y2o0dFNtUjNEMktrc0gyNTBZWUZGbEt3eldqS2VyVkF0aGNNaHJV?=
 =?utf-8?B?OWd3aWJsVmIyQUY1THNCajNXUm9vN1lwZjdPN0k5aVZKZy82VzgwejBZNTd5?=
 =?utf-8?B?Vis5ZkMrUkNzVCtRcGM0NGhST2FJaDlwL3IyRitzRzFHbTdaZEkvS1JocFlS?=
 =?utf-8?B?RzZlaTBVV1pIMGpOcGtPZzIvOFR2NkVMSlpnWFBUWmZEZm1GQXVaNVg1anRp?=
 =?utf-8?B?eXlrcmNob0pJWGt4NDh3SWNUd05wYjdia0Job1lmWVJqNkNZT0FrWm5jOGIw?=
 =?utf-8?B?MTZFdGV5MmFDaFBQeEQxZGJ2bzZQVkh1T2hpSHlTaVQ5WjdwcUZ2M0JJWmh1?=
 =?utf-8?B?K2taRHl4d3JualFad2tIZDBXbzZYWjAwc1RZcEFxTE5YQjJHazM5UmRKeXY3?=
 =?utf-8?B?cHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81650B689FE5464F9EA9C550289218D0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f228d02c-3e21-432f-6705-08dbc5302365
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 23:17:54.5617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3CI5Z2tMlksN/Jl8o9qwy2mRqwvjibt+WTR6aVMIPslgSB1iVfhx4uUb4AT2h5LWI0y6CHwMw+2kRMgqNSEsgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6094
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

T24gVGh1LCAyMDIzLTA5LTI4IGF0IDA5OjQ3IC0wNzAwLCBSdXNzIFdlaWdodCB3cm90ZToNCj4g
Q2hhbmdlIEFCSSBkb2N1bWVudGF0aW9uIGNvbnRhY3QgaW5mb3JtYXRpb24gZnJvbSBSdXNzIFdl
aWdodCB0bw0KPiBQZXRlciBDb2xiZXJnLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUnVzcyBXZWln
aHQgPHJ1c3NlbGwuaC53ZWlnaHRAaW50ZWwuY29tPg0KDQpBY2tlZC1ieTogUGV0ZXIgQ29sYmVy
ZyA8cGV0ZXIuY29sYmVyZ0BpbnRlbC5jb20+DQoNCj4gLS0tDQo+ICBEb2N1bWVudGF0aW9uL0FC
SS90ZXN0aW5nL3N5c2ZzLWRyaXZlci1pbnRlbC1tMTAtYm1jIHwgNCArKy0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtZHJpdmVyLWludGVsLW0xMC1ibWMg
Yi9Eb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWRyaXZlci1pbnRlbC1tMTAtYm1jDQo+
IGluZGV4IGE4YWI1ODAzNWM5NS4uYzEyMzE2ZGZkOTczIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVu
dGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWRyaXZlci1pbnRlbC1tMTAtYm1jDQo+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtZHJpdmVyLWludGVsLW0xMC1ibWMNCj4gQEAg
LTE3LDcgKzE3LDcgQEAgRGVzY3JpcHRpb246CVJlYWQgb25seS4gUmV0dXJucyB0aGUgZmlybXdh
cmUgdmVyc2lvbiBvZiBJbnRlbCBNQVgxMA0KPiAgV2hhdDoJCS9zeXMvYnVzLy4uLi9kcml2ZXJz
L2ludGVsLW0xMC1ibWMvLi4uL21hY19hZGRyZXNzDQo+ICBEYXRlOgkJSmFudWFyeSAyMDIxDQo+
ICBLZXJuZWxWZXJzaW9uOiAgNS4xMg0KPiAtQ29udGFjdDoJUnVzcyBXZWlnaHQgPHJ1c3NlbGwu
aC53ZWlnaHRAaW50ZWwuY29tPg0KPiArQ29udGFjdDoJUGV0ZXIgQ29sYmVyZyA8cGV0ZXIuY29s
YmVyZ0BpbnRlbC5jb20+DQo+ICBEZXNjcmlwdGlvbjoJUmVhZCBvbmx5LiBSZXR1cm5zIHRoZSBm
aXJzdCBNQUMgYWRkcmVzcyBpbiBhIGJsb2NrDQo+ICAJCW9mIHNlcXVlbnRpYWwgTUFDIGFkZHJl
c3NlcyBhc3NpZ25lZCB0byB0aGUgYm9hcmQNCj4gIAkJdGhhdCBpcyBtYW5hZ2VkIGJ5IHRoZSBJ
bnRlbCBNQVgxMCBCTUMuIEl0IGlzIHN0b3JlZCBpbg0KPiBAQCAtMjgsNyArMjgsNyBAQCBEZXNj
cmlwdGlvbjoJUmVhZCBvbmx5LiBSZXR1cm5zIHRoZSBmaXJzdCBNQUMgYWRkcmVzcyBpbiBhIGJs
b2NrDQo+ICBXaGF0OgkJL3N5cy9idXMvLi4uL2RyaXZlcnMvaW50ZWwtbTEwLWJtYy8uLi4vbWFj
X2NvdW50DQo+ICBEYXRlOgkJSmFudWFyeSAyMDIxDQo+ICBLZXJuZWxWZXJzaW9uOiAgNS4xMg0K
PiAtQ29udGFjdDoJUnVzcyBXZWlnaHQgPHJ1c3NlbGwuaC53ZWlnaHRAaW50ZWwuY29tPg0KPiAr
Q29udGFjdDoJUGV0ZXIgQ29sYmVyZyA8cGV0ZXIuY29sYmVyZ0BpbnRlbC5jb20+DQo+ICBEZXNj
cmlwdGlvbjoJUmVhZCBvbmx5LiBSZXR1cm5zIHRoZSBudW1iZXIgb2Ygc2VxdWVudGlhbCBNQUMN
Cj4gIAkJYWRkcmVzc2VzIGFzc2lnbmVkIHRvIHRoZSBib2FyZCBtYW5hZ2VkIGJ5IHRoZSBJbnRl
bA0KPiAgCQlNQVgxMCBCTUMuIFRoaXMgdmFsdWUgaXMgc3RvcmVkIGluIEZMQVNIIGFuZCBpcyBt
aXJyb3JlZA0KDQo=
