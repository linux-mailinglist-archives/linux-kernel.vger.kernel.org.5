Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CD580AFD8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 23:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbjLHWhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 17:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHWh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 17:37:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189EE10CA;
        Fri,  8 Dec 2023 14:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702075056; x=1733611056;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xLx6B97HLGrOIB27WozNrMfOmFDZUjPa75i9EMBvqkU=;
  b=Br1u6cR4rpQ60T558/r6yYhrHMzqsa/3OhMIGzq5kU7Pv+NYPv4qni86
   clnnqfAP6JxNBCVjpL+D86RNmyXFGAitiUevhH0Ipt3nLXRkhJOlO86hw
   icT+A500sW5+LzvWKquiacKl74mr29SatV7EB1fFj2vH5jYtpNhqqxbpk
   256gqGIKp9ITGMcEJBDhnQFbji4TbSnpmj6+isehV64mzpf+N+qusukv0
   W4Soj3fO0e0zFMZNU2DwTSEM/nCxwi95iWZWbuurACrgLM6rKUsqaOyuw
   I5fDvw/VT+ehAXcwqZB8Zt6cqFvaBfeKTVkCZEyMrQLmhm61hYX9Xf3gZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="480669290"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="480669290"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 14:37:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="842768443"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="842768443"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2023 14:37:11 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 14:37:11 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 14:37:10 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 14:37:10 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Dec 2023 14:37:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOoEXlaTIeoTNnoeCXDkuX97BIvKR53iVwJpiuDdKD3sxyNwxzu9HowaISDaT2xCBoIIrwnjTV51AAAZswKizjgrdllVRxJcATSBzZGvIjfcWbwzwvUvuc02RBnPnlL098v9idFMeGDQXQw35H+1UEbjzumIvDnnwP2SJxASniC6rOpi2ziqLQH6Ib6EmTyWT/vfaTpKE+Xbv4UvNdz4OeOgqz64jDr9gig0rCAqcPj2bNX9vB7dFcXnZj4fz1Qha6R2/6NMhqItRoTtirt7MUsWHGKLqv4Gx3+m2nY9UyHhb5EQlM2zct9qgVaBQr8WhxC7ncEYYsY7cUjM07qhlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLx6B97HLGrOIB27WozNrMfOmFDZUjPa75i9EMBvqkU=;
 b=BidpPfGCUZ8A/FQTdTReSSh+joLE+/8dvl/adLYar6DZItB5bGDRuqjL9G5wMSlXNRCtHy173iKj/sgiMfWf1bWB2daNiCYMFVdbS9zqreucAKn1nuralYs8jMYHC6OBS5D2gIuTKK6sfDmzPNLjx1znYkD2BaRGo8DeY+4kbHs57N/MxWhTUFCQOnolYrSDFQPCSaHU0pXdl0JhYlNbIOMxASn8Daw9tJH1vxe6EuBQdBsGd68U3/1XxvWNLrxzx+NzIxj3T/RwXPsU+yrKillOigbVGCfUFaxW17PmRHDmcaHzw6o5+mcCKz+ZfHWJANE1A50bcvkwp8ZUQlZhLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA0PR11MB4654.namprd11.prod.outlook.com (2603:10b6:806:98::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 22:37:08 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848%6]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 22:37:08 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Newman <peternewman@google.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v6 1/3] x86/resctrl: Add mount option "mba_MBps_event"
Thread-Topic: [PATCH v6 1/3] x86/resctrl: Add mount option "mba_MBps_event"
Thread-Index: AQHaKUd4vbZ9pzma9keuObpvNWgZXLCfsvMAgABDQMqAAASpYA==
Date:   Fri, 8 Dec 2023 22:37:08 +0000
Message-ID: <SJ1PR11MB60834864B0C71D9E984917AFFC8AA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231201214737.104444-1-tony.luck@intel.com>
 <20231207195613.153980-1-tony.luck@intel.com>
 <20231207195613.153980-2-tony.luck@intel.com>
 <CALPaoCji1yzfkA=tms3LhYMvRB+wSJQM3qzPKrHNEa7a+KduTA@mail.gmail.com>
 <ZXORTTIUKWXOsd9p@agluck-desk3>
 <CALPaoCj_OvMzD8W9+jEORewwDquM6F-sOW32Ngcy+Gm6A1+OcQ@mail.gmail.com>
In-Reply-To: <CALPaoCj_OvMzD8W9+jEORewwDquM6F-sOW32Ngcy+Gm6A1+OcQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA0PR11MB4654:EE_
x-ms-office365-filtering-correlation-id: 9290aa43-f54e-45e6-16a4-08dbf83e365d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KijCQVBleAGsiCh8Tlcv2axnXA3dgvcP7ffOru+tQK8ZsszxmBZpe0Y6rIKbMAFFrzJd9DwvIhGqhMswTj6+g3y4RYrC0u0/LPH0ZkgUfX1gXyogL7ciLKiDFMTGrf7xPLpU6IUjMv+1FK0zKS8CMUyK4g0cXFBEefdlXgiMZ5r4jWzIBybR/I3U3HcytitFg94bQibnQC0b88FIStuCEvMK+H2eJKRgoHDGkrcYhUN6575FbdxLGoMgb3WZln+NhZDCSSKPb0HBEpuSYV8169ww5qRYVdDOXc8e15PwQNVhkgVtBNQco6bzufxeOl27vHeOz+JUEeEU6BB6TwHVdnRZvFoVvVyuK63l//A346ZXr3IItvO39R99LtPmgl7oPNC6nKjul++0NdE1pZCqBd3RtEQARC43Oq3MULZ3eIh3/qAgin20sYEGBCEdhRRpKqT7qLqZQ7WOrX1TKfPx/SMvxMmRnOPRml4cPJMWq4c3haLawbu2i8jKBl/QU8VOElaJGusUP1hqsaRHho35NJz24wnyJDRpCRFGRdwDqyxyUKLFi43S3EKWri6EGXAPA8hJy2YZEaxtucbpuFXE8Lg6cEKllEMYexO8Lmb+uMeGr4EnDVwSkGJsGmEgC9X8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(6506007)(26005)(7696005)(9686003)(41300700001)(4326008)(8676002)(52536014)(8936002)(4744005)(2906002)(7416002)(5660300002)(478600001)(71200400001)(66446008)(76116006)(66946007)(66556008)(316002)(54906003)(64756008)(66476007)(6916009)(82960400001)(122000001)(38100700002)(33656002)(38070700009)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVZLY0EzZGxwKzNtZWxpaXdMdGN0R2pXcG1ldGRrcDF1b2FvYTBjbmFEbzZJ?=
 =?utf-8?B?ME1lOGZNS053S0p6a0lINVZMK20zaStNMVRXZUJtWGs4UU56UFQ0RG1acWFk?=
 =?utf-8?B?K1MyZWI2RmhpMGc1RXJvTG8wMWJ6WUpRRGRNUVlYeUx4eFlZS0R3a2QwYVN1?=
 =?utf-8?B?V0grMjY1enZUak5CUlB1NTZkTkRGNU9aMXg2RHhTUWVBTTZUVjVFenZSTTJB?=
 =?utf-8?B?WlkxaXc0TDlibnd6ZGlKeXB6Z2lLUk9EZGVkaVdDcGRXNGNuWklOYWlXblRm?=
 =?utf-8?B?VkI1SlhlR2twcENVSlRYY050ZVlIakQ1OVBpSmh0OW5maTZKbENEL0hOdDM0?=
 =?utf-8?B?b3VpTDNMc3ZIYXZlMkdKUHFRRUcyckwrUXNzblNma0J0RE4wS3VWcHl6WGxW?=
 =?utf-8?B?dGVmN1BVS2NxRGlkbXQ5TFltYlg0VlV4alIzNHp6ZzhRdG1LZkw2c1V1MTlD?=
 =?utf-8?B?ZzYzcWNpMHNpbTZ4NlZBdndYeGhldFkybzNvRnZoMnFXNG9FRXBNQ2laR0NX?=
 =?utf-8?B?TTdkbjMxcGFuOGlIM1Zlc0o0UkFlSWFxOXR1R25YN1U1N21YWEVMRDUyK0p3?=
 =?utf-8?B?WDlqakNCYWF4Ym10SXdZZ2E2SFN4SDRhYmNDMGRXWnFyYng2Ky81RTJXSisx?=
 =?utf-8?B?ZUNKb1hKZ0VuNWZIb1RTb0Y5cHUwM3l3MXdiQVovMllLeWZVL0lvS0Q3eFI5?=
 =?utf-8?B?Y2pEY2ZvQ21BbVR4Zks2NWNMSjJheVMrQm5LUmdsWU5memdjdXg5eU5GK3Fj?=
 =?utf-8?B?eXRMZVJQaEd0M1ZOc254RG84anRrbUpVR3Nad3NMVitOamI1c01Ra2VwSTVE?=
 =?utf-8?B?aGhIMER1RG9OQ0hoNThqK2lzQXFXL2tIbDRGclA4UnhUdWpzV1NFMWtTRjBu?=
 =?utf-8?B?STZxbW8xdjA0bjBnUnJwMG5OdEliMjVQc3ZIL0VXZFZFVDBobmpoNEtLMDdh?=
 =?utf-8?B?Sm9JWVVHUHRmZ3Boakw3Z0VOb0JMdHZvWmlzS1J2YmZrcUxmbTFvbXJKdmJl?=
 =?utf-8?B?LytTZXF3MGY0c0xBNGNidERaRkxIQ1U2TGp0TTRmZVBwdEJhckM2VVZYNERL?=
 =?utf-8?B?ODNsNVU5Ky9mbGxtTlVUdVZqRm9MQmRnUSsxdGdMdEZhRkFmanpuUlJkb2ZR?=
 =?utf-8?B?dFRzbkpoT1dzRWIxN0tNc3orcjRaS3lvL09UTjIxUWM1V3BiTVhwZXpFRTF1?=
 =?utf-8?B?a2N5eXZLNDdESEREZFY3ZmFvcHBRWHJCMW5DTTYwRk82WmZhakJSM2dodmlM?=
 =?utf-8?B?dDBRSE9FdWpNYlhTaFFpU2RMYVRrTlhwZ1k3eHJCSjlYajQ4bTlvSmJvMzNO?=
 =?utf-8?B?RXRyNGhnbmxNem83OVVUZXUvNENRUWlxNVhkNm82WWJEUVYvWnlhQ2hLSklp?=
 =?utf-8?B?aTR3QjVGamJhci9Sd1Vwd2VtdkZwb041NmNmSDRHOXNTUERRUWw3RVhiNGtN?=
 =?utf-8?B?K2x2aFEyZUJjdFRhQ1U1TVBTSURBOTlHa0hXUlpMbXNYaWFhT2FvcTBBdGVq?=
 =?utf-8?B?V1RKTXdjNWhIU0EvbElDVVdFRC9OaDhMN3VCN3FmUWNRdG41VkdQdHdQUnFa?=
 =?utf-8?B?SCtKRy84Zis2VHFRbE95bXprTW8xS3ZnTTZlVnlVUytXSUVSY0hYcC9POGdw?=
 =?utf-8?B?ckJUZGVPODVabXF5STJqZjVxK1pvMm1RbmdWV1lqRGIxaTdKdURJNHlTZlpH?=
 =?utf-8?B?TlBxVGMwU0l1RG5XMVpWMjcvMXZ2amRicjlaeFFoT2NrMmV0aG43UHplQndG?=
 =?utf-8?B?ajBuZXVkWHZQYjZGalcyaWNTTjZTZUh2NFo4QXc5WTN0THdLWmtGcGN2VUFx?=
 =?utf-8?B?RHE1MDFIMnNzYStnaEJzdWVnKzN5dFFmODF1MEtXTkxnbFZ6anRhR3B2YTBL?=
 =?utf-8?B?T1ZFU21XaStkZWJOYW9ySFhJVWtyWHdIK0NCRG9sRXduNVhHd0RPYTk5WFB1?=
 =?utf-8?B?TDN1b0lYYVE3dXIyS21TZ2VFSkJKSTg0cnROUWFxcnY5VlF5c0ZLMWdRSWQz?=
 =?utf-8?B?bEo1OEdVcDlRYlNzKzBHOVhqWXRjWnZtU3ZtOEt6clJlaHBmRUVmdGdrMHoy?=
 =?utf-8?B?bWo2UGdVeDhScWE1d28vT3JSWERURngzM082VUxNckJRR2Y4REhMc2lzMDB0?=
 =?utf-8?Q?23dXKcpBn/5qCfNpS3PrXChxP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9290aa43-f54e-45e6-16a4-08dbf83e365d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 22:37:08.6250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N8IzKxjO5um+y70VtVrxK2hKezCD40OoRWOWG0AD4/jALvVDbap4iEewQmzSLsdwlHrC48CV0wleuhhbSNZ4Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4654
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

PiA+IFRoYXQncyBnb2luZyB0byBiZSBjb25mdXNpbmcuIEknbGwgYWRkIGNvZGUgdG8gc3RvcCB0
aGUgdXNlciBmcm9tDQo+ID4gcGFzc2luZyBib3RoIG9wdGlvbnMuDQo+DQo+IEFsc28ga2luZCBv
ZiBjb25mdXNpbmcsIGFmdGVyIHJlYWRpbmcgdGhlIHNlY29uZCBwYXRjaCwgSSByZWFsaXplZA0K
PiAibWJhX01CcHNfZXZlbnQ9bWJtX3RvdGFsX2J5dGVzLG1iYV9NQnBzIiBhbHNvIHJlc3VsdHMg
aW4gYm90aCBiZWluZw0KPiBzZXQuIElmIHlvdSdyZSBhYmxlIHRvIGZhaWwgdGhlIG1vdW50IG9w
ZXJhdGlvbiBpZiBib3RoIGZsYWdzIHNvbWVob3cNCj4gZ2V0IHNldCwgdGhhdCB3b3VsZCBhZGRy
ZXNzIHRoaXMgb25lIHRvby4NCg0KUGV0ZXIsDQoNClllcy4gVGhhdCdzIHBvc3NpYmxlIHRvby4g
SSdsbCBjb3ZlciB0aGF0IGNhc2UgaW4gdGhlIG5leHQgdmVyc2lvbi4gSSdsbCB3YWl0DQp1bnRp
bCB0aGlzIGdldHMgdG8gdGhlIHRvcCBvZiBSZWluZXR0ZSdzIHJldmlldyBxdWV1ZSBiZWZvcmUg
cG9zdGluZw0KYWdhaW4uDQoNCi1Ub255DQo=
