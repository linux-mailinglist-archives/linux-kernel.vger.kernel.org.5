Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E3F801239
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379073AbjLASIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379046AbjLASIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:08:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307F1FE;
        Fri,  1 Dec 2023 10:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701454139; x=1732990139;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=r8QMy2iwD86O0h0QV34eBJLrm8tyY6LGzWSfhFoUfLI=;
  b=FpK85FO/wkexxK4R81FCelq/AZGA39owizOa+nJpiwNTOhcPVhMhMFm3
   vwpHllGkWMLGRKtLuM7GktuN+gBPm5zPQjtWET4rjg5SMmeMTPwB5Yc4V
   8BM1NKCRqMee3efOVKXfxBQA0Y6spXut8hFqV89ji3Q0G47YgAR1vmj+/
   DPMt2s+gmjnX6HoMwr2VezCNGDYAMaJIL9h1JnLq+s/mwynef4M7F86X4
   z6S0TYPiSI0ygJ4EjVy+JVcRLG0xARoYrX7/PIGyP5RLiccIRnnz7bXcv
   z1pjtsS5JwZndymRHqX29mqqoQK9cazuNGchUI2XfP3vZGb0Zrgm1Ef4D
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="460027463"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="460027463"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 10:08:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="769760991"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="769760991"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Dec 2023 10:08:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 10:08:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 10:08:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 1 Dec 2023 10:08:57 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 1 Dec 2023 10:08:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NaIhVWZfR6QvMZrLgvSlmdqtTqK0bYUztiGsxUQz3EldDRebRi36grli1R67nbG1bJWs1tpzWOjlSUpsSlCclUQc1a1khmFFaSJJMuqGs9kk4/lIwtyF988/C2cytJiGKXphTu7yFHhWbMmG2hu1xIZchDCTQxSr1cKB7r8awNHKJN5avmokQkl/q7WcFZV6mml434EN2Xl/xW6/1kk5ufsjDz5VSBtNn2noq0ngUoI0cWWKHRvngZtbH86pjclCBXoOhxrBvEMt13sVfAxWpCxZkQhmWKEaE9tvX5C/KPxZU4VElcP7CiMjw6N0Zn/Y3sMM/Bi23Dmfc0TuayLDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8QMy2iwD86O0h0QV34eBJLrm8tyY6LGzWSfhFoUfLI=;
 b=aij97OUTtEJ42aqDGQr8Axyv9y3P6d3TT15KbzJp5XM+R5WEkA8I6oQgfBtmwV9PupPaOUkwqVKiLIEY/5MaCk2c0/Hm+PAMngH5VwMFZVJXz8GX6omZbklBbGw57aGcwpkuORXOjTuT6x8Lhhk8+5HIZCCsAkzhdCuclddyZYRA7HmiyaG+wfX8JbIcFFtY5f8Hwbnfn9lSPZtXpmCZKXiOpleVMPyn3GS3cJhCbezS9EFGo79onwP1lUCUsyWeel5yOMzGQXp6WRdE8IOgIwopLTIuUI0ZFs/BQDrOpde3RNQU4lCwPnqaCOhtlt2IoYONUyGj5+zgGn2be9Pzzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CH0PR11MB5506.namprd11.prod.outlook.com (2603:10b6:610:d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 18:08:56 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e10c:91d7:d34b:aa1d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e10c:91d7:d34b:aa1d%6]) with mapi id 15.20.7025.022; Fri, 1 Dec 2023
 18:08:55 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "ashok_raj@linux.intel.com" <ashok_raj@linux.intel.com>
CC:     "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jsperbeck@google.com" <jsperbeck@google.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tip-bot2@linutronix.de" <tip-bot2@linutronix.de>
Subject: Re: [tip: x86/urgent] x86/acpi: Ignore invalid x2APIC entries
Thread-Topic: [tip: x86/urgent] x86/acpi: Ignore invalid x2APIC entries
Thread-Index: AQHaExJ8HYCIhq0C9kqRsYucn9Sz1LCG/duAgADzWYCAC/TXAIAA9rMA
Date:   Fri, 1 Dec 2023 18:08:55 +0000
Message-ID: <b561524f3378fb1d4c69451fdbf70bb5cbbb5ec9.camel@intel.com>
References: <169953729188.3135.6804572126118798018.tip-bot2@tip-bot2>
         <20231122221947.781812-1-jsperbeck@google.com>
         <1e565bb08ebdd03897580a5905d1d2de01e15add.camel@intel.com>
         <ZWlSRE6KNNFwIYyq@araj-dh-work.jf.intel.com>
In-Reply-To: <ZWlSRE6KNNFwIYyq@araj-dh-work.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CH0PR11MB5506:EE_
x-ms-office365-filtering-correlation-id: 4911fb79-3b5f-4f95-f92c-08dbf2989570
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WDezrtc75dnRusC2UXM8kQ1uQ6hOe8XKXZHsfnrfPoQ6cBJvVpG15+7Kpv1QFefyQrqLsuIVmW6FWGvAq+y87c8YJdNvkY6IjrPkMPbpqzT0CPTNBlkei8FXXCiHxVDZ/78itodi0Jv4xd3VMbrmCSudqhybXzZAFXA9MqC9gxlfFzXiNMw+Gy4uSXYWMXcP5vWiw7yN90K7DBKWUBCdHpRtDZJ6h3L3qlUOiZXvF5tc1XiQ4iJQDGiN9ZgHsZ6JBYzQgFfbYL5rhUFLpf+H+pW5f1Ct+IqzAxeV19URUNS7fI/I/Tv9TsDgoqktAGas+16G7UuKNxt78+pXYriVP1Rfy8qYvUaj4qq98DK9Nsx/GKARKOYkifG9PxPg5Fr2eWiZxu1pcCGvnW6OmgumzIysIuw1OOaxS8Mgr80zWrG1ZM2GM+0d6wefeKfNURcGQSudDGqTpsfqmvPZDZK25M8wbvm/xyJwKquVuGE5xlnAL9EBkcOX6/qijBUKt1U1Jvk+EmsZGcCk631sIXVTaslBBQkqUb/etB8u4LjNDaJZFmPAPznvZ4wgstvYAG4NzXcitV+kNBbRRJvjVFjMgTd5bsutrMAxV3WcO5K+GPg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(26005)(6506007)(2616005)(83380400001)(6512007)(122000001)(71200400001)(5660300002)(8936002)(4326008)(8676002)(41300700001)(2906002)(4001150100001)(6486002)(966005)(478600001)(316002)(66946007)(6916009)(54906003)(64756008)(66446008)(66476007)(66556008)(76116006)(91956017)(36756003)(38100700002)(82960400001)(38070700009)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGFDbnNvVHkvRDA2WkhhQ3Y3NTVlVEtSMUprMk1ZUlkwL1ZQUEdmSEpMbHJw?=
 =?utf-8?B?RXIxMEcvejJFbTNlNm5pTGVZYVJOMXVlaytLbHF3NWRzWkFrU0FSa0RTeVdl?=
 =?utf-8?B?MFRLUVAyaVl3azM4RUgxYzNMNkZCblhINUNrdXk5RVlLNVh4ZFRCTjU1MDly?=
 =?utf-8?B?L1VRQXVVZjVLUXFlUnVMUTJqUEsrYXdUU2dRcENNNWZLdWdiTlI5dTB6OHZi?=
 =?utf-8?B?clNwL1BoYTNNOUZSdW5obS9xdUt5cnF4QkVyUERhRjBWSjlkUEJuTFJaT1NE?=
 =?utf-8?B?NjRxMTNTQW9MdHRkTHBvd2dnNXBiL2NFcVc5ZWlQMUN3dTVpUWU3cEE1Wklm?=
 =?utf-8?B?Z1lXUlVmRVVPQXQ1c0ZEcVV6ZzNzTWl3OXVxd1FZemZoM202SE1la2psQi9G?=
 =?utf-8?B?RHllQW9WOG1EMzJ0dnV3TUFMNGZ0L3JneWxBdndBV3RKdlpIMldmUzdZM3Vr?=
 =?utf-8?B?c2RiMXluMEE3OTBFK2tzUUFnU21LVzZPaWRmZTlqNXlieWNMVEVrMGdGZFB2?=
 =?utf-8?B?VE81N3JLR1pGb2dZNnVRcXlFV29rSFNuR2lVcHV1R1JJd2ZOcExyREZ6V3lh?=
 =?utf-8?B?a2FGaVFscDRvdzRrcnh1MW9GY3h5RUpOcnI5djNQdW42a2tqM2JCVEdhcmIz?=
 =?utf-8?B?YlYzTXpEdkUvRjE0TGxMQVVRSjNFT0hhZUxtMDM3NDRaU3gvZUp4c2JpN3hl?=
 =?utf-8?B?T25MRlBaTWFVTGZCSElBT2NRWVJQTUhZa01ET29Qd1cweU9jSWFkZ1F4ZDdG?=
 =?utf-8?B?Ri8wbnNwdENJbUgrdk9HVlNNWkJKZzQ5ZkwxdGRsNzduNVpQWDF4ZG84T1BB?=
 =?utf-8?B?TW5UbE9ER3lPOEZJUHpUTnNITGJ5akQwTEZudTJJeS9mRDlqTGFqbWZlNGRQ?=
 =?utf-8?B?SHFzMVNSZmxZVjBQMnpRWTdreDVlRTg2TlB6TlVIOG1KQ1lVMm9hb0xiT2RY?=
 =?utf-8?B?WDhSUWZuNk9rNytUU1J0SDFlRWZvaS9iZTMxU0lMYlRwUkZoeFYwVlFMbTc5?=
 =?utf-8?B?MDF0ZjVTV2NOSGxiSkJxVFhicWRJTmdPT0RqL09lYk9oc1JLaEJmT0t3clFI?=
 =?utf-8?B?blVsbjZEVXpIbjhxU0xCV214ZnNPTzY4RVk0elJYZ3dVSWNvRW1DeGN6Q1RV?=
 =?utf-8?B?bzhyaGo5U0RNRUVKZUlvS1Vuclg0ZmpkKy9ITzBwbGRPaGFPTmlhbVJucENn?=
 =?utf-8?B?cXJiQWpINzdYYXREdVlxV09oWmRjY2l6YUw4RVZseGI0U2FJMDhPRVFsV2dD?=
 =?utf-8?B?RjVVU1BtUDBhL2xab2l1b1JPeXFqMzM5eXYrdVIrenczUnM4bE9FbzRFc2RB?=
 =?utf-8?B?cWpNcno0R1VLTmQwVW11c2VPNTRlbnZHZWpMNmVFSmtHalNRZzVhdTdpWjlH?=
 =?utf-8?B?eG1TYlI0SVFuSWpBQmIzVjdqK2RCaEdPSUoyL0NYK1NSUmltOFU2OHBZZnpZ?=
 =?utf-8?B?MFdLeVBVUDVRaEtsOVpiNHpYOFViY1l6YTMvY0ZLN0tDaXUwM3N0Qk1tTjRx?=
 =?utf-8?B?TnkyZ1lWUFI0d2hBRWl4dWdmZjVKaFE3a01LRXRqS1dUK3c2K3gyVUJRdTYv?=
 =?utf-8?B?a3FQZGdWKythWEJ3em1MRnlnLzZOcW5TK3Uzb2dzbFRjSlhwR0hOYTZxaDJu?=
 =?utf-8?B?eDBDUXUvVUV1TVBrdVpNWFNsUnpxSWUzTmthTFBPUUIzbE5jYy8yZFUvT3Jr?=
 =?utf-8?B?Q2Fsa2dHWTNzRnU2TVNuOUJrWVVuaUhYUlVXVU90c0lBeUdlaVZKMnZ2YktX?=
 =?utf-8?B?NDF5UVE1OTB3dENPTEt4UmQ5NjJBTVI4K3RqaVAvcmptQjJLMk5oQU14WUxK?=
 =?utf-8?B?R3pMdGt0UVpyYm1zQ25CZEtoczRuUFJWSXZ4QlNiaFBic2JubWgwQXRRNXd6?=
 =?utf-8?B?Z0hoNHk5ZkxvMThLZ3dCaWxYYVlUeFYrUlBJYkRsenA1S3p2WGdYazQ0SDgv?=
 =?utf-8?B?SHZHSHRDN0N0ZFIrTGNwR0pCZEY1dE1aRWNsVEJ0OWRkaTkwSUpJdW1BQXpL?=
 =?utf-8?B?cWZyanBOdFZwZjk3RytZcHhGWHRYV0VrQ1JPTkFoT0sxSjE0aUFWWGJoeUYw?=
 =?utf-8?B?dDdXTDNoK3JEMUR2RHlYbG5veHFwOExlTFhCKy9LYjl3NjJjY2xXWDl2Y2Jn?=
 =?utf-8?Q?XkGJJPSbDWwL59Sb5L7WCA7U5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26EBF7251CB46D4BA91BCC072E6EA441@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4911fb79-3b5f-4f95-f92c-08dbf2989570
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 18:08:55.8973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1LHU00+Tc78XsN2kbIMhGQHW2EnTGcYoqorPiapu1tlC05201yIT+DeaZzRKfENyIW7ubs8bmIQ+J/HU3B0o7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5506
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTExLTMwIGF0IDE5OjI1IC0wODAwLCBBc2hvayBSYWogd3JvdGU6DQo+IE9u
IFRodSwgTm92IDIzLCAyMDIzIGF0IDEyOjUwOjQ3UE0gKzAwMDAsIFpoYW5nIFJ1aSB3cm90ZToN
Cj4gPiBIaSwgSm9obiwNCj4gPiANCj4gPiBUaGFua3MgZm9yIGNhdGNoaW5nIHRoaXMgaXNzdWUu
DQo+ID4gDQo+ID4gT24gV2VkLCAyMDIzLTExLTIyIGF0IDIyOjE5ICswMDAwLCBKb2huIFNwZXJi
ZWNrIHdyb3RlOg0KPiA+ID4gSSBoYXZlIGEgcGxhdGZvcm0gd2l0aCBib3RoIExPQ0FMX0FQSUMg
YW5kIExPQ0FMX1gyQVBJQyBlbnRyaWVzDQo+ID4gPiBmb3INCj4gPiA+IGVhY2ggQ1BVLsKgIEhv
d2V2ZXIsIHRoZSBpZHMgZm9yIHRoZSBMT0NBTF9BUElDIGVudHJpZXMgYXJlIGFsbA0KPiA+ID4g
aW52YWxpZCBpZHMgb2YgMjU1LCBzbyB0aGV5IGhhdmUgYWx3YXlzIGJlZW4gc2tpcHBlZCBpbg0K
PiA+ID4gYWNwaV9wYXJzZV9sYXBpYygpDQo+ID4gPiBieSB0aGlzIGNvZGUgZnJvbSBmM2JmMWRi
ZTY0YjYgKCJ4ODYvYWNwaTogUHJldmVudCBMQVBJQyBpZCAweGZmDQo+ID4gPiBmcm9tDQo+ID4g
PiBiZWluZw0KPiA+ID4gYWNjb3VudGVkIik6DQo+ID4gPiANCj4gPiA+IMKgwqDCoCAvKiBJZ25v
cmUgaW52YWxpZCBJRCAqLw0KPiA+ID4gwqDCoMKgIGlmIChwcm9jZXNzb3ItPmlkID09IDB4ZmYp
DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOw0KPiA+ID4gDQo+ID4gPiBX
aXRoIHRoZSBjaGFuZ2UgaW4gdGhpcyB0aHJlYWQsIHRoZSByZXR1cm4gdmFsdWUgb2YgMCBtZWFu
cyB0aGF0DQo+ID4gPiB0aGUNCj4gPiA+ICdjb3VudCcgdmFyaWFibGUgaW4gYWNwaV9wYXJzZV9l
bnRyaWVzX2FycmF5KCkgaXMgaW5jcmVtZW50ZWQuwqANCj4gPiA+IFRoZQ0KPiA+ID4gcG9zaXRp
dmUgcmV0dXJuIHZhbHVlIG1lYW5zIHRoYXQgJ2hhc19sYXBpY19jcHVzJyBpcyBzZXQsIGV2ZW4N
Cj4gPiA+IHRob3VnaA0KPiA+ID4gbm8gZW50cmllcyB3ZXJlIGFjdHVhbGx5IG1hdGNoZWQuDQo+
ID4gDQo+ID4gU28gaW4gYWNwaV9wYXJzZV9tYWR0X2xhcGljX2VudHJpZXMsIHdpdGhvdXQgdGhp
cyBwYXRjaCwNCj4gPiBtYWR0X3Byb2NbMF0uY291bnQgaXMgYSBwb3NpdGl2ZSB2YWx1ZSBvbiB0
aGlzIHBsYXRmb3JtLCByaWdodD8NCj4gPiANCj4gPiBUaGlzIHNvdW5kcyBsaWtlIGEgcG90ZW50
aWFsIGlzc3VlIGJlY2F1c2UgdGhlIGZvbGxvd2luZyBjaGVja3MgdG8NCj4gPiBmYWxsDQo+ID4g
YmFjayB0byBNUFMgbW9kZSBjYW4gYWxzbyBicmVhay4gKElmIGFsbCBMT0NBTF9BUElDIGVudHJp
ZXMgaGF2ZQ0KPiA+IGFwaWNfaWQgMHhmZiBhbmQgYWxsIExPQ0FMX1gyQVBJQyBlbnRyaWVzIGhh
dmUgYXBpY19pZCAweGZmZmZmZmZmKQ0KPiA+IA0KPiA+ID4gwqAgVGhlbiwgd2hlbiB0aGUgTUFE
VCBpcyBpdGVyYXRlZA0KPiA+ID4gd2l0aCBhY3BpX3BhcnNlX3gyYXBpYygpLCB0aGUgeDJhcGlj
IGVudHJpZXMgd2l0aCBpZHMgbGVzcyB0aGFuDQo+ID4gPiAyNTUNCj4gPiA+IGFyZSBza2lwcGVk
IGFuZCBtb3N0IG9mIG15IENQVXMgYXJlbid0IHJlY29nbml6ZWQuDQo+IA0KPiBUaGlzIHNtZWxs
cyB3cm9uZy4gSWYgYSBCSU9TIGlzIHBsYWNpbmcgc29tZSBpbiBsYXBpYyBhbmQgc29tZSBpbg0K
PiB4MmFwaWMNCj4gdGFibGUsIGl0cyByZWFsbHkgbWVzc2VkIHVwLiANCj4gDQo+IFNob3VsZG4n
dCB0aGUga2VybmVsIHNjYW4gdGhlbSBpbiBzb21lIHByaW9yaXR5IGFuZCBvbmx5IGNvbnNpZGVy
IG9uZQ0KPiBzZXQgb2YNCj4gdGFibGVzPw0KPiANCj4gU2hvdWxkbid0IHRoZSBjb2RlIHN0b3Ag
bG9va2luZyBvbmNlIHNvbWV0aGluZyBvbmNlIGEgdHlwZSBpcyBmb3VuZD8NCj4gDQoNCkkgYWxz
byB3YW50IHRvIGdldCB0aGlzIGNsYXJpZmllZCBidXQgdGhlcmUgaXMgbm8gc3BlYyBzYXlpbmcg
dGhpcy4gQW5kDQppbnN0ZWFkLCBhcyBtZW50aW9uZWQgaW4gdGhlIGNvbW1lbnQsIHdlIGRvIGhh
dmUgc29tZXRoaW5nIGluDQpodHRwczovL3VlZmkub3JnL3NwZWNzL0FDUEkvNi41LzA1X0FDUElf
U29mdHdhcmVfUHJvZ3JhbW1pbmdfTW9kZWwuaHRtbCNwcm9jZXNzb3ItbG9jYWwteDJhcGljLXN0
cnVjdHVyZQ0KDQoiW0NvbXBhdGliaWxpdHkgbm90ZV0gT24gc29tZSBsZWdhY3kgT1NlcywgTG9n
aWNhbCBwcm9jZXNzb3JzIHdpdGggQVBJQw0KSUQgdmFsdWVzIGxlc3MgdGhhbiAyNTUgKHdoZXRo
ZXIgaW4gWEFQSUMgb3IgWDJBUElDIG1vZGUpIG11c3QgdXNlIHRoZQ0KUHJvY2Vzc29yIExvY2Fs
IEFQSUMgc3RydWN0dXJlIHRvIGNvbnZleSB0aGVpciBBUElDIGluZm9ybWF0aW9uIHRvDQpPU1BN
LCBhbmQgdGhvc2UgcHJvY2Vzc29ycyBtdXN0IGJlIGRlY2xhcmVkIGluIHRoZSBEU0RUIHVzaW5n
IHRoZQ0KUHJvY2Vzc29yKCkga2V5d29yZC4gTG9naWNhbCBwcm9jZXNzb3JzIHdpdGggQVBJQyBJ
RCB2YWx1ZXMgMjU1IGFuZA0KZ3JlYXRlciBtdXN0IHVzZSB0aGUgUHJvY2Vzc29yIExvY2FsIHgy
QVBJQyBzdHJ1Y3R1cmUgYW5kIGJlIGRlY2xhcmVkDQp1c2luZyB0aGUgRGV2aWNlKCkga2V5d29y
ZC4iDQoNCnNvIGl0IGlzIHBvc3NpYmxlIHRvIGVudW1lcmF0ZSBDUFVzIGZyb20gYm90aCBMQVBJ
QyBhbmQgWDJBUElDLg0KDQp0aGFua3MsDQpydWkNCg0KPiBzYXBpYyBpcyBvbmx5IGZvciBJQTY0
IGNvcnJlY3Q/DQo+IA0KPiBzYXBpY19lbnRyaWVzID0NCj4gYWNwaV90YWJsZV9wYXJzZV9tYWR0
KEFDUElfTUFEVF9UWVBFX0xPQ0FMX1NBUElDLC4uLi4pDQo+IA0KPiBpZiBzYXBpY19lbnRyaWVz
DQo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gc2FwaWNfZW50cmllczsNCj4gDQo+IHgyYXBpY19j
b3VudCA9IC4uLg0KPiANCj4gaWYgeDJhcGljX2NvdW50DQo+IMKgwqDCoMKgwqDCoMKgwqByZXR1
cm4geDJhcGljX2NvdW50Ow0KPiANCj4gYXBpY19jb3VudCA9IC4uLg0KPiANCj4gTWF5YmUgeW91
IHNob3VsZCBhZGQgaWYgYWxsIGVudHJpZXMgYXJlIG1hcmtlZCBJTlZBTElEIGZvciBBUElDLCBq
dXN0DQo+IGlnbm9yZSB0aGUgd2hvbGUgdGFibGU/DQo+IA0KPiBDaGVlcnMsDQo+IEFzaG9rDQoN
Cg==
