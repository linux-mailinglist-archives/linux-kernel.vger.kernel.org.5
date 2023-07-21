Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120FA75CFC2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjGUQil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjGUQiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:38:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4444E3C34;
        Fri, 21 Jul 2023 09:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689957407; x=1721493407;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w3ppgr6Esm/8cktbp5aFx21anIyWmd593fpQOmlHypU=;
  b=oJUvDzeuYPh7itqttbiHRuST38RzRCRhm+UpMK2UyMDOfyWdsm3IrEXe
   PGFalpnRIyMsSFOR6FxBVa4JKW81Inkl+5AJoWMVg9eL8VhKsxTqyjFHq
   gIfVN0VY5ve05Ns4b36S/BDW1nh/x5vC4n0Ce4x2+wviQGlEt3ECW/09E
   oM3kJzElWikddDb1z9QH9jZ68iRHXOO331X07Hy2/fqU6M9FoLEibYqNw
   xi+RwPC+nwBVG9cD/r/6XjB4ov+EbznKdTEtngp0n/6jEiWn2CHJZTiV2
   thrx/4MzBiwlXUohlbI6/f8Vao5O/z9lgXuHoYaoFMftE3EOUpSrFTw/n
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="347354997"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="347354997"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 09:33:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="760007461"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="760007461"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 21 Jul 2023 09:33:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 09:33:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 09:33:54 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 09:33:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfUt3s6VKgkfdpuOT8TyrH7jDlibtypmf7MMOy9P0l7qd2Ckg+/hwksH2MRQkVG7+sELJmbNanr8NoQ6UCwFMkY6l/mOa0ejdngOUPUAAHxF8QVos5nfB5dVaUvFyp0fa6eDRgKZqZUlpH4xngaE+Uoyg3juZnBMBvRFyY9KKBiKZ4Vy79nf1jJNWqdRY1lhdGP/lISHr9sWhoSmdROu0uLLvPEpHo+/S8u6WImXlxC2+xwLAz9bv1kRTZ7U18UwOQRSBCQlZqTyCh5Uls75pFAggB6jCX1f+pWKQ933Z2MnklSEY4nC5DoWvZdTTk59Bq4ys8zD60gnewwxBJq6mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3ppgr6Esm/8cktbp5aFx21anIyWmd593fpQOmlHypU=;
 b=natncpVXw1fY+Zqx1QhI/5+MsTY8yTO/AYtHYmMY5GaDth1YpkkK6n1aDRDT0FiUClZRh0F0uBNYCJ3azWl4P2hIiQ1RnxlDLD0FSP9njLiBGVLCh5CVBk1fOxvYwHbFHf1zzl0gH1tRzQIpbSd+T0wm4ZTuTMlHCqbq+Z2rwa5ORKScIVFzdU3cUnjL9S9wVhSMR2DfgT/iNJN8nUFTVTbmV2H6YM2w5+g5gsgJkzjf6WzLr/EiIrVkPNZe+QQQlHcPuGWW2/K559Ezhg2w9HQxieLCSaHNUDyW9/+okKq5P5Gf+csKDAJQRSndUaicp1BuVHt7ckZ/Og95nUr73w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 SJ2PR11MB7518.namprd11.prod.outlook.com (2603:10b6:a03:4c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 16:33:51 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531%3]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 16:33:51 +0000
From:   "Ng, Boon Khai" <boon.khai.ng@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Boon@ecsmtp.png.intel.com" <Boon@ecsmtp.png.intel.com>,
        "Khai@ecsmtp.png.intel.com" <Khai@ecsmtp.png.intel.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Tham, Mun Yew" <mun.yew.tham@intel.com>,
        "Swee, Leong Ching" <leong.ching.swee@intel.com>,
        "G Thomas, Rohan" <rohan.g.thomas@intel.com>,
        Shevchenko Andriy <andriy.shevchenko@linux.intel.com>
Subject: RE: [Enable Designware XGMAC VLAN Stripping Feature 1/2] dt-bindings:
 net: snps,dwmac: Add description for rx-vlan-offload
Thread-Topic: [Enable Designware XGMAC VLAN Stripping Feature 1/2]
 dt-bindings: net: snps,dwmac: Add description for rx-vlan-offload
Thread-Index: AQHZu5xgG1a+wZGOqU+EmB1OiRdona/EAA+AgABTXyCAABQrAIAAAvSw
Date:   Fri, 21 Jul 2023 16:33:51 +0000
Message-ID: <DM8PR11MB5751CB29CB9BF99D240DA2EEC13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20230721062617.9810-1-boon.khai.ng@intel.com>
 <20230721062617.9810-2-boon.khai.ng@intel.com>
 <e552cea3-abbb-93e3-4167-aebe979aac6b@kernel.org>
 <DM8PR11MB5751EAB220E28AECF6153522C13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
 <8e2f9c5f-6249-4325-58b2-a14549eb105d@kernel.org>
In-Reply-To: <8e2f9c5f-6249-4325-58b2-a14549eb105d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|SJ2PR11MB7518:EE_
x-ms-office365-filtering-correlation-id: c27531dc-3e4b-4679-f684-08db8a084466
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pjhmMXVFgfcM69HCg6vwb8iF0X7uPDWzKYdY4n73HG3MQPn9aDQjk3qH24TMf9qTHId8dNo2eEKh37cl/j3r/sqoOroSxCthHKO0m1lDfovhUvZW+tfeKxlwVoFfILbBGokdOMRH+MM3q4l0X4uoeaqkDbYijexvdKlbGyr0NmRRqANt74a4FKIafSVtXzyZ5zIknpuDoq1XrOR/HlO1PmiqpPrJTVE757xpbqDaPqm1tBewvUvdYlJWsoB37HYyOaq3SKV5VFONFfOVRYx79R9uhpiWHwR5xsbO/mHn3hA8mKGb7d2tGZEk/UhINRHOzS6HKWkk3qds/XmCi9kDpQ8aacattCXsCoxz+EzuM16JVW3tnx1M4Bc6f/xVt3aIKHmfsuo2gr/6EZa9p6abDNCIkitxkLZxiFJLNyTIeHQM83zWhgNKI4Uw+GYUL/8Csw6R5T3L5Ea+O12ZDEYC7t0D+5y9UqjeeEoIlDdftEQksmrKg4NBbzdBV+117vNSFGeNeqIEQnBKqTI4qCgP9PLtL5tIbK3canBX10GllLV5GcpxmpyFfB3kSHXUoBImHBzGd4NFk3tE7B57fKRgtkswefCbLqEvagLT7ANScl43sPay9t0ryvWkgCDnRatXG1Ide/rK9XX6dojBeyGYrbbIea2zNWqJ0p3TCRUhPTM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199021)(2906002)(8936002)(316002)(8676002)(5660300002)(52536014)(7416002)(38070700005)(41300700001)(33656002)(55016003)(86362001)(921005)(122000001)(71200400001)(110136005)(54906003)(478600001)(82960400001)(6506007)(26005)(53546011)(7696005)(186003)(9686003)(4326008)(76116006)(38100700002)(66946007)(66556008)(66446008)(66476007)(64756008)(83380400001)(168613001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGl1V1daRmU3aWxBOWVyVE5LTjV5Zkxoa1p4eThhbVpMTWhJMUZDaEFrYlBB?=
 =?utf-8?B?MmdBTlNOVzdNTUdrc2V3dnN3b1hJemxCQUdZMC9mdllSY2wwVkpEVlFTWG8v?=
 =?utf-8?B?T1hyTmNDTmY3dHNwY1J0UjlWZHZGWXRsKyt0ZDg0WEhkV2xzVmdjT0Q0MUl0?=
 =?utf-8?B?cDFoV3ZZWkxjYkF4RmhyMzAxL3pvRzR0OE5LemZCeDQrZ1U5MnVTY3dzWkEz?=
 =?utf-8?B?S0tRN0Nrb1FyM1VTeUYxOUhpdW56NkErT0N3VkltdjFySnJmVzdwT2ZxejVS?=
 =?utf-8?B?K1NDRTZkU0Vtb2ZCNlpIcHhBaTBIcEpMdEszRlFYeDVVaFFsRCtLMnlWV0Jp?=
 =?utf-8?B?eEVQcStSQks3eDlvNFR2Z2FwdWFKOGZmUE1JVnZYSUVQMzAzOTNWcXNNM2Yy?=
 =?utf-8?B?QXRMUFNYVEpNb29QbHFmN0p4Rm8zTVNpRTZYdFl6UTlvcmlMOGJuMTJOem9O?=
 =?utf-8?B?WGNyYmgyNm54WnFIU1o0QXkrNzJSb0Uvc3RTbHhMeWp4VGxtTE50aVBsWFhr?=
 =?utf-8?B?Uzhncnh6ekpZc21GMG5YaXo1T1R0VlkrRnU4cy9rOWwrRmRQZmZ4bytRY201?=
 =?utf-8?B?Q1kyUG9VRVF4OHF2bnMwcnEya2pKRHp3S01XSVRTaWU3Z3JZc1ZtMlhBMzBM?=
 =?utf-8?B?L05NWXpxaEpWYzZxR1FDMjBjTHc2RlVBdEp6QWo5Z0Ryaks4ZWxHTmtxUXcy?=
 =?utf-8?B?OTMva3NSc0pvUERGQmcwUkxzNWxvalZTMmlaUEVJKzQweGlDRVlMVzZWSFBk?=
 =?utf-8?B?bFRpVGwyQlZ1WUhGa29NUTU5TmFhMm5PbmVxWjlodTZUMFV1cGlxQUtJTzVH?=
 =?utf-8?B?U1U0SmhnSTdDNHdOS2xWUGMyQkVnRmpZU3JVZ2hYL2tKSHVsNG82MTNrVHh4?=
 =?utf-8?B?VTZhR3dkRWZ4L0wwL0w5Rk5UbTJqalFUNnRPUzZ3cVZ3NU9ZOFhkUitYU1NB?=
 =?utf-8?B?SFBTK0tnVWI5Q0R6WTdOUXdUa1dxcjAyell5Rk1LUEdia0s1SUI2TXRpOXVU?=
 =?utf-8?B?UWtqQ3F5TzR1ZHlrclNLV0pLQVRQRFFWajQ0aEowMVQ2NkY1RmFXZW1QMTJ6?=
 =?utf-8?B?Q1Q3KzA4UURlekJqT2F6bXVOSk5BdEMxYVJjWW9BeVBQZy9Nb0tyM2kvbTI1?=
 =?utf-8?B?SjNJQVg5NUNSdlJWQ1lQeGk5TUtVaTZWU1VNc0xrTzlldGwvaFNUV1NmcXpD?=
 =?utf-8?B?V1JrSllZVlBSMi9Xa256L1RCTDJ5UnJDTUthSmN3cWl6NExwSEJ0N0k0eDNq?=
 =?utf-8?B?Z2F2eVpEcm5NbUZGUHBXbzh4THVpQk9xMUR6eUhSQVFsYmVPS2RNM1lhV1FQ?=
 =?utf-8?B?bER2eFUxb2FldEhGTjdPOGpXOVBIcEY3R01ZVUNEUVBWMWVzYVk2eVhnNXhM?=
 =?utf-8?B?a1Nzb3BKL01PenhIZXZkOWRSbFlzVHJaQTlNRHlGY3ZZMkMvbVAwQTdORWww?=
 =?utf-8?B?N2txTnRKQTBiREZrRUd1eDVKdnNKekRkZlhreTIvL0xBK0c5SEkrNjVEb3hP?=
 =?utf-8?B?cjF3TVJsZlNsZjBaWXdUSjVva3Z3U2RDTnZQNFloSll6WmVlUnMwNk9Pb1lk?=
 =?utf-8?B?TEF1T3E5QnVuYmRMaFQ0em5QTUxkVnNocVJTU2xTcGRpYnlOUVVXbXZUdHYw?=
 =?utf-8?B?VGQra2dPOXpUd01ObDJZanNRZjc0SUh4TmpOV29UQkxRSEhOdFhQQ0xTTXhH?=
 =?utf-8?B?UnpSZjJiNWpyVTQyOU9KUFNjelE2aUx1TUhsVFNRTm96USswdkx4ZFl4Mk1Q?=
 =?utf-8?B?OGNKVCt5Vk13c0NGM2Nhc2NRZHdIZm5NTUVNWmIxb0doUDNGRzFZZG1FVDVR?=
 =?utf-8?B?UE5WMWdOaG93cVZpMGFRL0J1Uk4wbkl0czlVVzcyQlRwblBpVDYrRExJWHdZ?=
 =?utf-8?B?NXdpWE94Qk5oVjcrN1RLUUdwbUpjZms4K0tuYmtWYXk5c3lyUk1jNEhOZjN0?=
 =?utf-8?B?Mnc4elg0RUs5MVllZUttYktzT3FFR0p2SFhTZTRFUjkxREUvZHNwWHEzWEw0?=
 =?utf-8?B?dEVKbFk3SGw5ZHVYZFJTZHFaRVJWcHZWVkFMSG1CZVgvR3ZLQTNuRkNsR3pC?=
 =?utf-8?B?bDZmWXNhMWJTcmErNUtweDhiaDUyaHc5cEo2NEYxYXVzRGJSdDc5ZGpycEx6?=
 =?utf-8?Q?mQxc8avKp4Lt5zvv/Et5xUWn/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c27531dc-3e4b-4679-f684-08db8a084466
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 16:33:51.4444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mbGBy7uNQg2AcQpgAE1guGte/9waNNR4Ks5vIDtAAMpaNFh4pbo/QIKC8o/+RmhK9MDHw2PvhoNiFZeV1qBThQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7518
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFNhdHVyZGF5LCBKdWx5IDIyLCAyMDIzIDEyOjIy
IEFNDQo+IFRvOiBOZywgQm9vbiBLaGFpIDxib29uLmtoYWkubmdAaW50ZWwuY29tPjsgQm9vbkBl
Y3NtdHAucG5nLmludGVsLmNvbTsNCj4gS2hhaUBlY3NtdHAucG5nLmludGVsLmNvbTsgR2l1c2Vw
cGUgQ2F2YWxsYXJvIDxwZXBwZS5jYXZhbGxhcm9Ac3QuY29tPjsNCj4gQWxleGFuZHJlIFRvcmd1
ZSA8YWxleGFuZHJlLnRvcmd1ZUBmb3NzLnN0LmNvbT47IEpvc2UgQWJyZXUNCj4gPGpvYWJyZXVA
c3lub3BzeXMuY29tPjsgRGF2aWQgUyAuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVy
aWMNCj4gRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtpY2luc2tpIDxrdWJh
QGtlcm5lbC5vcmc+Ow0KPiBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+OyBNYXhpbWUg
Q29xdWVsaW4NCj4gPG1jb3F1ZWxpbi5zdG0zMkBnbWFpbC5jb20+OyBuZXRkZXZAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1zdG0zMkBzdC0NCj4gbWQtbWFpbG1hbi5zdG9ybXJlcGx5LmNvbTsgbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiBDYzogU2hldmNoZW5rbywgQW5kcml5IDxhbmRyaXkuc2hldmNoZW5rb0Bp
bnRlbC5jb20+OyBUaGFtLCBNdW4gWWV3DQo+IDxtdW4ueWV3LnRoYW1AaW50ZWwuY29tPjsgU3dl
ZSwgTGVvbmcgQ2hpbmcNCj4gPGxlb25nLmNoaW5nLnN3ZWVAaW50ZWwuY29tPjsgRyBUaG9tYXMs
IFJvaGFuDQo+IDxyb2hhbi5nLnRob21hc0BpbnRlbC5jb20+OyBTaGV2Y2hlbmtvIEFuZHJpeQ0K
PiA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW0Vu
YWJsZSBEZXNpZ253YXJlIFhHTUFDIFZMQU4gU3RyaXBwaW5nIEZlYXR1cmUgMS8yXSBkdC0NCj4g
YmluZGluZ3M6IG5ldDogc25wcyxkd21hYzogQWRkIGRlc2NyaXB0aW9uIGZvciByeC12bGFuLW9m
ZmxvYWQNCj4gDQo+IE9uIDIxLzA3LzIwMjMgMTc6MjgsIE5nLCBCb29uIEtoYWkgd3JvdGU6DQo+
ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEtyenlzenRvZiBLb3ps
b3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj4gPj4gU2VudDogRnJpZGF5LCBKdWx5IDIxLCAyMDIz
IDY6MTEgUE0NCj4gPj4gVG86IEJvb25AZWNzbXRwLnBuZy5pbnRlbC5jb207IEtoYWlAZWNzbXRw
LnBuZy5pbnRlbC5jb207ICJOZw0KPiA+PiA8Ym9vbi5raGFpLm5nIkBpbnRlbC5jb207IEdpdXNl
cHBlIENhdmFsbGFybw0KPiA+PiA8cGVwcGUuY2F2YWxsYXJvQHN0LmNvbT47IEFsZXhhbmRyZSBU
b3JndWUNCj4gPj4gPGFsZXhhbmRyZS50b3JndWVAZm9zcy5zdC5jb20+OyBKb3NlIEFicmV1IDxq
b2FicmV1QHN5bm9wc3lzLmNvbT47DQo+ID4+IERhdmlkIFMgLiBNaWxsZXIgPGRhdmVtQGRhdmVt
bG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQNCj4gPj4gPGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1
YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8NCj4gQWJlbmkNCj4gPj4gPHBhYmVu
aUByZWRoYXQuY29tPjsgTWF4aW1lIENvcXVlbGluDQo+IDxtY29xdWVsaW4uc3RtMzJAZ21haWwu
Y29tPjsNCj4gPj4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgtc3RtMzJAc3QtbWQtIG1h
aWxtYW4uc3Rvcm1yZXBseS5jb207DQo+ID4+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgbGludXgtIGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gQ2M6IE5nLCBCb29u
IEtoYWkgPGJvb24ua2hhaS5uZ0BpbnRlbC5jb20+OyBTaGV2Y2hlbmtvLCBBbmRyaXkNCj4gPj4g
PGFuZHJpeS5zaGV2Y2hlbmtvQGludGVsLmNvbT47IFRoYW0sIE11biBZZXcNCj4gPj4gPG11bi55
ZXcudGhhbUBpbnRlbC5jb20+OyBTd2VlLCBMZW9uZyBDaGluZw0KPiA+PiA8bGVvbmcuY2hpbmcu
c3dlZUBpbnRlbC5jb20+OyBHIFRob21hcywgUm9oYW4NCj4gPj4gPHJvaGFuLmcudGhvbWFzQGlu
dGVsLmNvbT47IFNoZXZjaGVua28gQW5kcml5DQo+ID4+IDxhbmRyaXkuc2hldmNoZW5rb0BsaW51
eC5pbnRlbC5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbRW5hYmxlIERlc2lnbndhcmUgWEdNQUMg
VkxBTiBTdHJpcHBpbmcgRmVhdHVyZSAxLzJdIGR0LQ0KPiBiaW5kaW5nczoNCj4gPj4gbmV0OiBz
bnBzLGR3bWFjOiBBZGQgZGVzY3JpcHRpb24gZm9yIHJ4LXZsYW4tb2ZmbG9hZA0KPiA+Pg0KPiA+
PiBPbiAyMS8wNy8yMDIzIDA4OjI2LCBCb29uQGVjc210cC5wbmcuaW50ZWwuY29tIHdyb3RlOg0K
PiA+Pj4gRnJvbTogQm9vbiBLaGFpIE5nIDxib29uLmtoYWkubmdAaW50ZWwuY29tPg0KPiA+Pj4N
Cj4gPj4+IFRoaXMgcGF0Y2ggaXMgdG8gYWRkIHRoZSBkdHMgc2V0dGluZyBmb3IgdGhlIE1BQyBj
b250cm9sbGVyIG9uDQo+ID4+PiBzeW5vcHN5cyAxMEcgRXRoZXJuZXQgTUFDIHdoaWNoIGFsbG93
IHRoZSAxMEcgTUFDIHRvIHR1cm4gb24NCj4gPj4+IGhhcmR3YXJlIGFjY2VsZXJhdGVkIFZMQU4g
c3RyaXBwaW5nLiBPbmNlIHRoZSBoYXJkd2FyZSBhY2NlbGVyYXRlZA0KPiA+Pj4gVkxBTiBzdHJp
cHBpbmcgaXMgdHVybiBvbiwgdGhlIFZMQU4gdGFnIHdpbGwgYmUgc3RyaXBwZWQgYnkgdGhlDQo+
ID4+DQo+ID4+IFN1YmplY3QgcHJlZml4IGlzIHRvdGFsbHkgYm9ndXMuDQo+ID4+DQo+ID4NCj4g
PiBXaGljaCBwYXJ0PyBJdCdzIGEgMTBHIEV0aGVybmV0IElQIGZyb20gU3lzbm9wc3lzLCBpbiBS
b21hbiBjaGFyYWN0ZXIgaXQgaXMNCj4gWCAobWVhbiAxMCksIHNvIFhHTUFDLg0KPiA+IEV2ZW4g
dGhlIGRyaXZlciBmaWxlIEknbSBlZGl0aW5nIGl0IGlzIGR3InhnbWFjIi4NCj4gDQo+IEV2ZXJ5
dGhpbmcgaW4gW10uDQo+IA0KPiA+DQo+ID4+DQo+ID4+PiAxMEcgRXRoZXJuZXQgTUFDLg0KPiA+
Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IEJvb24gS2hhaSBOZyA8Ym9vbi5raGFpLm5nQGludGVs
LmNvbT4NCj4gPj4+IFJldmlld2VkLWJ5OiBTaGV2Y2hlbmtvIEFuZHJpeSA8YW5kcml5LnNoZXZj
aGVua29AbGludXguaW50ZWwuY29tPg0KPiA+Pg0KPiA+PiBQbGVhc2UgdXNlIHNjcmlwdHMvZ2V0
X21haW50YWluZXJzLnBsIHRvIGdldCBhIGxpc3Qgb2YgbmVjZXNzYXJ5DQo+ID4+IHBlb3BsZSBh
bmQgbGlzdHMgdG8gQ0MuIEl0IG1pZ2h0IGhhcHBlbiwgdGhhdCBjb21tYW5kIHdoZW4gcnVuIG9u
IGFuDQo+ID4+IG9sZGVyIGtlcm5lbCwgZ2l2ZXMgeW91IG91dGRhdGVkIGVudHJpZXMuIFRoZXJl
Zm9yZSBwbGVhc2UgYmUgc3VyZQ0KPiA+PiB5b3UgYmFzZSB5b3VyIHBhdGNoZXMgb24gcmVjZW50
IExpbnV4IGtlcm5lbC4NCj4gPj4NCj4gPg0KPiA+IFRoaXMgaXMgYmFzZWQgb24gbmV0LW5leHQg
cmVwb3NpdG9yeSBzdWdnZXN0ZWQgYnkgdGhlIGdldCBtYWludGFpbmVyIHNjcmlwdC4NCj4gPg0K
PiA+IEkgZ290IHRoZSBsYXRlc3QgbmV0LW5leHQganVzdCBub3cgYXQgdGhlIENvbW1pdC1pZCBi
NDQ2OTM0OTVhZjggd2hpY2gNCj4gPiBqdXN0IGNvbW1pdHRlZCB5ZXN0ZXJkYXkuDQo+ID4NCj4g
PiAkIC4vc2NyaXB0cy9nZXRfbWFpbnRhaW5lci5wbCAgLS1zY20gIC1mDQo+ID4gZHJpdmVycy9u
ZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvZHd4Z21hYzJfY29yZS5jDQo+IA0KPiBUaGF0J3Mg
bm90IGhvdyB5b3UgcnVuIGl0LiBnZXRfbWFpbnRhaW5lcnMucGwgc2hvdWxkIGJlIHJ1biBvbiBw
YXRjaGVzIG9yIG9uDQo+IGFsbCBmaWxlcywgbm90IGp1c3Qgc29tZSBzZWxlY3Rpb24uDQo+IA0K
PiA+IEdpdXNlcHBlIENhdmFsbGFybyA8cGVwcGUuY2F2YWxsYXJvQHN0LmNvbT4gKHN1cHBvcnRl
cjpTVE1NQUMNCj4gRVRIRVJORVQNCj4gPiBEUklWRVIpIEFsZXhhbmRyZSBUb3JndWUgPGFsZXhh
bmRyZS50b3JndWVAZm9zcy5zdC5jb20+DQo+ID4gKHN1cHBvcnRlcjpTVE1NQUMgRVRIRVJORVQg
RFJJVkVSKSBKb3NlIEFicmV1DQo+IDxqb2FicmV1QHN5bm9wc3lzLmNvbT4NCj4gPiAoc3VwcG9y
dGVyOlNUTU1BQyBFVEhFUk5FVCBEUklWRVIpICJEYXZpZCBTLiBNaWxsZXIiDQo+ID4gPGRhdmVt
QGRhdmVtbG9mdC5uZXQ+IChtYWludGFpbmVyOk5FVFdPUktJTkcgRFJJVkVSUykgRXJpYw0KPiBE
dW1hemV0DQo+ID4gPGVkdW1hemV0QGdvb2dsZS5jb20+IChtYWludGFpbmVyOk5FVFdPUktJTkcg
RFJJVkVSUykgSmFrdWINCj4gS2ljaW5za2kNCj4gPiA8a3ViYUBrZXJuZWwub3JnPiAobWFpbnRh
aW5lcjpORVRXT1JLSU5HIERSSVZFUlMpIFBhb2xvIEFiZW5pDQo+ID4gPHBhYmVuaUByZWRoYXQu
Y29tPiAobWFpbnRhaW5lcjpORVRXT1JLSU5HIERSSVZFUlMpIE1heGltZQ0KPiBDb3F1ZWxpbg0K
PiA+IDxtY29xdWVsaW4uc3RtMzJAZ21haWwuY29tPiAobWFpbnRhaW5lcjpBUk0vU1RNMzIgQVJD
SElURUNUVVJFKQ0KPiA+IFJpY2hhcmQgQ29jaHJhbiA8cmljaGFyZGNvY2hyYW5AZ21haWwuY29t
PiAobWFpbnRhaW5lcjpQVFAgSEFSRFdBUkUNCj4gPiBDTE9DSyBTVVBQT1JUKSBuZXRkZXZAdmdl
ci5rZXJuZWwub3JnIChvcGVuIGxpc3Q6U1RNTUFDIEVUSEVSTkVUDQo+ID4gRFJJVkVSKSBsaW51
eC1zdG0zMkBzdC1tZC1tYWlsbWFuLnN0b3JtcmVwbHkuY29tIChtb2RlcmF0ZWQNCj4gPiBsaXN0
OkFSTS9TVE0zMiBBUkNISVRFQ1RVUkUpIGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZw0KPiA+IChtb2RlcmF0ZWQgbGlzdDpBUk0vU1RNMzIgQVJDSElURUNUVVJFKSBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gKG9wZW4gbGlzdCkgZ2l0DQo+ID4gZ2l0Oi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25ldGRldi9uZXQuZ2l0DQo+ID4g
Z2l0IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXRkZXYv
bmV0LW5leHQuZ2l0DQo+ID4gZ2l0IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC9hdG9yZ3VlL3N0bTMyLmdpdA0KPiA+IHN0bTMyLW5leHQgZ2l0DQo+ID4gZ2l0
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4
LmdpdA0KPiA+DQo+ID4+IFlvdSBtaXNzZWQgYXQgbGVhc3QgRFQgbGlzdCAobWF5YmUgbW9yZSks
IHNvIHRoaXMgd29uJ3QgYmUgdGVzdGVkIGJ5DQo+ID4+IGF1dG9tYXRlZCB0b29saW5nLiBQZXJm
b3JtaW5nIHJldmlldyBvbiB1bnRlc3RlZCBjb2RlIG1pZ2h0IGJlIGENCj4gPj4gd2FzdGUgb2Yg
dGltZSwgdGh1cyBJIHdpbGwgc2tpcCB0aGlzIHBhdGNoIGVudGlyZWx5IHRpbGwgeW91IGZvbGxv
dw0KPiA+PiB0aGUgcHJvY2VzcyBhbGxvd2luZyB0aGUgcGF0Y2ggdG8gYmUgdGVzdGVkLg0KPiA+
Pg0KPiA+DQo+ID4gVGhpcyBpcyBhIG5ldyBkZXZpY2UgYnJpbmd1cCwgdGh1cyB0aGUgRFQgaXMg
bm90IGF2YWlsYWJsZSB5ZXQuIFRoZQ0KPiA+IERUUyB3aWxsIGJlIHVwc3RyZWFtZWQgYnkgbXkg
YW5vdGhlciBjb2xsZWFndWUsIHVubGVzcywgaWYgSSBjYW4gdXBzdHJlYW0NCj4gb25seSBteSBw
YXJ0IG9uIHRoZSBzZXR0aW5nPw0KPiANCj4gWW91IGFyZSBtaXhpbmcgbm93IERUUyBhbmQgRFQg
YmluZGluZ3MuIFNvcnJ5LCB3ZSBkbyBub3QgdGFsayBhYm91dCBEVFMuDQo+IA0KPiBGb2xsb3cg
b3VyIHByb2Nlc3Mgb2Ygc3VibWl0dGluZyBwYXRjaGVzLiBGb3Igc3VyZSB0aGVyZSBhcmUgZm9s
a3MgaW4gSW50ZWwNCj4gd2hpY2ggY2FuIGV4cGxhaW4gaXQgdG8geW91Lg0KPiANCg0KQWggc2Vl
LCBzbyB5b3Ugd2VyZSBzYXlpbmcgSSdtIG1pc3NpbmcgdGhlIGNjIGxpc3Qgb2YgdGhlIG1haW50
YWluZXIgcmVsYXRlZCB0byB0aGUNCkRUIGJpbmRpbmcuIA0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMs
DQo+IEtyenlzenRvZg0KDQo=
