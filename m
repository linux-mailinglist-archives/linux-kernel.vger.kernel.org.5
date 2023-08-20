Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6423D781D28
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 11:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjHTJVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 05:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjHTJV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 05:21:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A399F2D65;
        Sun, 20 Aug 2023 02:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692523242; x=1724059242;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WyGW5GMBghj+ndjoHwlfTzLTgCzbxZOVzlrS7yI80jo=;
  b=YHeX8hVDMLp2shXr31ArgxgFkK6CzF1/NxlyGliYcYHtvC4dFB88uuVe
   EgTVMA9BQdyeu0fKSluRuMohoDCjLlAoIIiFhYuAfyI87MzdIcJ4JPq05
   irZ3CKWggfK6vP2f3HrtfdVD87kVpqnd98jZBx0bBB11cq0+fs72+j5hq
   o7JblzdleQaS8A31GPxRCjeZzCgP+CZ3rAD+PWwxIMQY4SiHS8C+Iohwt
   CVRd3nQrXgINqUcwc94mvIMoU2O1t+A/E1DW8K9n6Zu8RlG4L+7opqPiR
   kdvu9vzLNDD/QOmNHVJBNTewZ7IT11Pu+13VL6B2tUO62zqrYOBY3c/3K
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10807"; a="372295101"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="372295101"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2023 02:20:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10807"; a="729086136"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="729086136"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 20 Aug 2023 02:20:40 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 20 Aug 2023 02:20:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 20 Aug 2023 02:20:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 20 Aug 2023 02:20:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpzte2lTFmnjYpp78ffCaoADpFiWvSFGNL28Z0WFgfrxXbQ9bM1KUT7YwhBAmSba+IA6rSfMV75c3Y7xGfAupwfyvexDAu3pg42Byu0yC+k5soa3T7ml6xTiBKBa7IdZgv9m5RJ8EYtuZW8G42blwp2YyHlTGaRQN6/WXvXNTZHSdiXGAZufoK4444bCYap8Jum8ZxIrdADj9RBijpgej1Rf7/5XDGDoNJ7N+etAs6dyBokHKyu4KGLAfCJo1obcWQWgu08N0yiFJgdSxoRi/SQuqq771vbllkG0Nb3E6v0cy/7EXAluP2gXPn+zbS8yFujjmzPFqO7hIhDUZesmTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyGW5GMBghj+ndjoHwlfTzLTgCzbxZOVzlrS7yI80jo=;
 b=R6QIFSV+8T5JV/GOvFw4XcEO4dT8PtC1ay4AmSrGCAHAQhRIQCkYbRvueH5iqdoH/TWMUodETbTwqn66W0lVeNbbL6VAMsqqKyBCEaA4UfZDXc2fWc8rLCitvYsiH+kOYxnbZl3+UXn4JWQH26UyKnYzy0H7PXhDfIZsblz9C0J9U24xhH0++lE+OPb75Sjmfguk0qHsyib6lbqRnZLocscDM/NGUiBfgEy4g+93uBfNBPzRxsbCtWh5DLcB+IyqtQrXX/QIQgXG3+Vgh8OisZPPDYe3+GDRHzcVI/0ArL6DFdAz/KABKB0yVQ/n0o7kIZYFkCWsN4f5emd0mVotTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by MN6PR11MB8220.namprd11.prod.outlook.com (2603:10b6:208:478::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sun, 20 Aug
 2023 09:20:33 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e971:f9e7:17a5:1a85]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e971:f9e7:17a5:1a85%6]) with mapi id 15.20.6699.020; Sun, 20 Aug 2023
 09:20:33 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "smarter3@gmail.com" <smarter3@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "noltari@gmail.com" <noltari@gmail.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Bityutskiy, Artem" <artem.bityutskiy@intel.com>,
        "Kumar, Vinay" <vinay.kumar@intel.com>
Subject: Re: [PATCH] intel_idle: Add RaptorLake support
Thread-Topic: [PATCH] intel_idle: Add RaptorLake support
Thread-Index: AQHZK9QM69Ctt/8BWU2kz43rXhq0Oq6l6maAgU1oRgCAAOTNgA==
Date:   Sun, 20 Aug 2023 09:20:32 +0000
Message-ID: <7e2c1da24b48217045e8ad95b739ec96cdce5931.camel@intel.com>
References: <20230119070205.90047-1-noltari@gmail.com>
         <c79904e98b86b68c87add286aa1487b3f81712b6.camel@intel.com>
         <c7d1eced-d77b-aca7-1422-6eefaf704f3e@gmail.com>
In-Reply-To: <c7d1eced-d77b-aca7-1422-6eefaf704f3e@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|MN6PR11MB8220:EE_
x-ms-office365-filtering-correlation-id: 35a1bb3a-bbab-40fa-1eea-08dba15eb475
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fC9HXkl0rbcoHLdVAAHXyGt2J746o4u+xVD8XuPA46FT/l0yCxw7r6oZMR7vD5qRYnUIt/KpnZQDuCO2ZIW8sO67TiW6dOlkkE85WBaeNHucevu0RC1wJ+/rDen8vjFvjPIZi4yPpH+VgVaiPc12R47b1NXlZBL32kg5IwWJjYHcdO4M/blyE6sl3vSwrg7TVpQ6onFBF6x3VXk4zjOTchGl0as8zAExhCacT62A3ymHLS/1YlhoIoknYFkArYy3pFa4SZ68GMDwp1bYfCAYcArUgx3r53eQ9iaDFtYGPquHgcyZrD2V6Sa3OahdXPEDTOZAqE0r37HQxp6pVYmjLt5IMYkFbGivr32kYvEfs2Zhr/yWOjNNYiItHNs2yEurX8fTQURzM2/BBP7Z5g4QVkMLwqjvdUygrNZNzE0pWQeFBa4tgLxm5hnxTwRUgnhbObptgKAaFEXLgWbQok75YyGOev0lgmZ/JMKzNSsdf18a9uMMhTY8h+ggDe24TRG8xe1N5Jg2BV1h8bAffgj+MqY2zLXf2Sq0ai7t8e+822zFibvPDDRipSpkAbJj6Z04Cmn2KnCATd0EdofVUmCdYU0dztQEcjOaplkUOoD2U0ucm7TCglkU8sy+84uV4ZJo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199024)(1800799009)(186009)(91956017)(86362001)(76116006)(110136005)(64756008)(5660300002)(2616005)(41300700001)(316002)(2906002)(66946007)(66556008)(54906003)(66446008)(66476007)(8936002)(4326008)(8676002)(478600001)(82960400001)(71200400001)(6486002)(53546011)(38100700002)(38070700005)(6506007)(122000001)(6512007)(26005)(36756003)(66574015)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFh1UXorOFZDT05Cemw4TzBsT0h6QUkrVWNGSGpLM0ZoVEw5SHBMV2JSczkz?=
 =?utf-8?B?MG9qZk5Fd0xVaW1HcjRSbDZCMzA1dDZGYXRmVFhaMlkwQVVFV242by8wT0g2?=
 =?utf-8?B?dUJOQ0hXUW1OdEFISTZQcFNDTjRFUWo2QlNZSGJRRVVxTDB2RlpEVTNsRzlv?=
 =?utf-8?B?TWVZYXVkbE9LQnUzSkNYRDVyejcveGNySU1nT09SMlZrM3h2ZXRETlBDNHRL?=
 =?utf-8?B?Qjk5Sk1BdUZ4LzJxNjd6V3dJVW9Ra0YrTzlBb2FIY3JJMlgrYmZwUisxZUEw?=
 =?utf-8?B?RWNMSktweHhUQzhLQ3k5Ulo3TEZvM3JOTXBtOE9qQ3hUTGNIOVQ4eDRueVMx?=
 =?utf-8?B?S2M3NzZJb3FDY0lzM0lIN2MwVWU2bGZaYktPUXdRdEJFb09iZlZTQnFBY3Vr?=
 =?utf-8?B?VnFsOVIycnRYeVdoRTI4V0V3eTdJcElMbCtlekVUeEpiNHBFT2RIbTN0d0ox?=
 =?utf-8?B?VTY3Q2lBd1lDYWpKR0wwdDZ0ZFl5N2ZxWE9LcTdkaktBN0lIcWNWdmdya0FC?=
 =?utf-8?B?UjZJc2FoQ2Y1RElrc1NvZlNPQ1lKa0Z4U2djQVJQQ01yQlN6dDRHU3RwT0NK?=
 =?utf-8?B?LzJzMWV4Z01zejZJQTIrMSttU3pmM09zNldvNWlYa3ZDdkRTblI1OVo2MTdE?=
 =?utf-8?B?alQ1aFJqYkZTRXFxejVEajI1bmhCRnF5MEpEZDhDNU52d0ZSNDVQY09BZEUy?=
 =?utf-8?B?K3hGbUh2STltY1VRa0NxRmRQL1ZlbXhCS3pmNUVvdFlEU0RHeXhFNmVPS0pN?=
 =?utf-8?B?d0ZQRkU1djZyQ2c0ZGFPRU10ZnJwVENBMWp4Mzd3eFljSDBYeENsc2ljT0lO?=
 =?utf-8?B?SHgyRjBrQy9CWVVDQS8zUlhoZjMxekI0dVB6c3d5OGxqWnlCdG5JRkhzUmVp?=
 =?utf-8?B?eXlUN1IyZmhzWEpoOGFFWGlVOVNUTXlEL2luY3plSkNhSUZ6NFlMOTBWekJk?=
 =?utf-8?B?cGk2Q2tENGRBelo3SWp4MnlsbFF2Wk5wZlErMGdmYituU2krNSttZGZuMlZC?=
 =?utf-8?B?MHFUU29tNWpHd0dWNEJQdVJEMGplQitkVW92MEY1RGlHWXpWaWZjbVN5UGJ3?=
 =?utf-8?B?ejVYU0U0S2tPcGxyelZSRmdwM3k2RjJDU05UREY3b1c4bGlEeXFVNlN4QTJC?=
 =?utf-8?B?UGtkMmdLV1BHc0htZ3Y5MTZGNlRXMjBCdnVVTWw1WU0vMUI0T2U4QXZGaEdG?=
 =?utf-8?B?WklWczhXNkcwbTRoTWpGOVBURjE5bldJQ0tzL2hVb1J4eVluazhnTmFSTzFo?=
 =?utf-8?B?THd3cllzdnAyd3VuenZGNkxJNm9ZU1lxYXlkYjBvakpjM29zekhFcEYxMTdn?=
 =?utf-8?B?cFFKenNwc1A1Q0k4Lzh1V0laQkQ1bnE4SEhqUXJHMzB3WDZtRUl1R3hqUDF5?=
 =?utf-8?B?RGN1SnB4WnBNY1A4NHNQQjBwSWVSTzVEUUR6dFN0SjhnT1JURmwwUm95cGNR?=
 =?utf-8?B?NlVJVGMvUGRJaFY5STUraStwZ21aSCsyRmNHOWhVcDZvVEdLbjhwMmhhTFdy?=
 =?utf-8?B?ZWtFM3BRK0Zhb0FIM3N5N3ljYnlrblJJUUdKZXdvUmIxQmlFRm83VE1zWmdF?=
 =?utf-8?B?WUdPVGlQZG5jeGJzVmQxUXJKLzhZUGwrc1YvVUlmOEgwQUNUQ0RidXZDM3B3?=
 =?utf-8?B?cW1sS3FHNHRmOTJaSHFWMG1nV2UrekpBUGZpWTBDSWJaVnNUS2tFbDlQUmVt?=
 =?utf-8?B?T1pZQlY2dXVkcTE4d2JIWXpyYVdHNEVGalUxVlRuQ2YvcExzVW93aExkYzdy?=
 =?utf-8?B?OHlDbHJ5ZUNMR0dlZ01WeklGUkZCMFNkMXdzRExWdCsyeTBKV0xLQzc1Y1o2?=
 =?utf-8?B?cG9pUDA0Y0ZUbm9KR1NBZTdyajZpRmt0ZWFxODhqMnhUZndIbW5iSUN3OU50?=
 =?utf-8?B?bERUd2d5bWdYV21jLzlVR3FUV1A5anExUDZNTC81WWR2MXl4ZEVqRHNUSlBP?=
 =?utf-8?B?OXJCeDFKLzVuRVFsUWZaNDcreTQ3Zk9kbEYzem9HUW0vQzBXeGNDcktHYmhr?=
 =?utf-8?B?OEpuN0w2S1o5Rm5XbXdHTklSNk16NkZ6UWN2TGFNaU04bXZSanRoSEdYYXRK?=
 =?utf-8?B?SjlFL0xvY05XdVJMdUczM3hqUU9jYi94dEhtN3pPb05hdGg3ZWhrS2JUWHly?=
 =?utf-8?Q?qEwYrLLKNclrWhCZkHjvgUwNb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FD43D7395C53B438918CDECD76AAE2C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a1bb3a-bbab-40fa-1eea-08dba15eb475
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2023 09:20:32.9516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tKjLgIqzBknak8xQIVDGad762/UzAqEDarr2EfSkoaJbCbR3XyWDV0eqOMb9XzvOJ/uyUDLOsMQ+oEnCSFenEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8220
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIzLTA4LTE5IGF0IDIxOjQxICswMjAwLCBHdWlsbGF1bWUgTWFydHJlcyB3cm90
ZToNCj4gT24gMS8xOS8yMyAxNzoxMywgWmhhbmcsIFJ1aSB3cm90ZToNCj4gPiBPbiBUaHUsIDIw
MjMtMDEtMTkgYXQgMDg6MDIgKzAxMDAsIMOBbHZhcm8gRmVybsOhbmRleiBSb2phcyB3cm90ZToN
Cj4gPiA+IFRoaXMgcGF0Y2ggYWRkcyBSYXB0b3JMYWtlIHN1cHBvcnQgdG8gdGhlIGludGVsX2lk
bGUgZHJpdmVyLg0KPiA+ID4gDQo+ID4gPiBTaW5jZSBSYXB0b3JMYWtlIGFuZCBBbGRlckxha2Ug
Qy1zdGF0ZSBhcmUgY2hhcmFjdGVyaXN0aWNzIHRoZQ0KPiA+ID4gc2FtZSwNCj4gPiA+IHdlIHVz
ZQ0KPiA+ID4gQWxkZXJMYWtlIEMtc3RhdGVzIHRhYmxlcyBmb3IgUmFwdG9yTGFrZSBhcyB3ZWxs
Lg0KPiA+IA0KPiA+IFJQTCBhbmQgQURMIGhhdmUgc2FtZSBjc3RhdGVzIGFuZCB1c2UgdGhlIHNh
bWUgbXdhaXQgaGludHMsIGJ1dCB0aGUNCj4gPiBsYXRlbmN5IG9mIGVhY2ggYy1zdGF0ZSBhcmUg
c3RpbGwgZGlmZmVyZW50IG9uIGRpZmZlcmVudCBwbGF0Zm9ybXMuDQo+ID4gU28gd2UgY2FuIG5v
dCBqdXN0IGR1cGxpY2F0ZSB0aGUgQURMIHRhYmxlIG9uIFJQTC4NCj4gPiANCj4gPiBUaGVyZSBp
cyBhbiBlZmZvcnQgb25nb2luZyB0aGF0IG1lYXN1cmVzIHRoZSBsYXRlbmN5IG9mIGVhY2gNCj4g
PiBjc3RhdGUgb24gdGhlIFJQTCBwbGF0Zm9ybXMuIEFuZCBiYXNlZCBvbiB0aGUgbWVhc3VyZW1l
bnQgcmVzdWx0LA0KPiA+IHdlDQo+ID4gY2FuIGRlY2lkZSBpZiBhIG5ldyBjdXN0b20gdGFibGUg
aXMgbmVlZGVkIG9yIHdlIGNhbiBqdXN0IGNvcHkgdGhlDQo+ID4gcHJldmlvdXMgcGxhdGZvcm0u
IEhvcGVmdWxseSB3ZSB3aWxsIGhhdmUgYSBwYXRjaCBpbiBhIGNvdXBsZSBvZg0KPiA+IHdlZWtz
Lg0KPiANCj4gSGksIEkganVzdCBzdHVtYmxlZCB1cG9uIHRoaXMgcGF0Y2ggc2VyaWVzIGFzIEkg
d2FzIHdvbmRlcmluZyBhYm91dA0KPiB0aGUNCj4gbGFjayBvZiBzdXBwb3J0IGZvciBSYXB0b3Ig
TGFrZSBpbiBpbnRlbF9pZGxlLg0KDQppbnRlbF9pZGxlIHN1cHBvcnQgZm9yIFJhcHRvckxha2Us
IGFuZCBhbHNvIG90aGVyIHBsYXRmb3JtcyB0aGF0IGRvbid0DQpoYXZlIGEgY3VzdG9tIHRhYmxl
LCBpcyBhbHdheXMgdGhlcmUgYXMgbG9uZyBhcyB3ZSBoYXZlIEJJT1Mgc3VwcG9ydC4NClRoZSBj
dXN0b20gdGFibGUgaXMganVzdCBhbiBvcHRpbWl6YXRpb24uDQoNCj4gIFlvdXIgbGFzdCBtZXNz
YWdlIGZyb20NCj4gSmFudWFyeSBtZW50aW9ucyBhIGZ1dHVyZSBwYXRjaCwgaXMgaXQgYXZhaWxh
YmxlIGFueXdoZXJlIG9yIGlzIHRoaXMNCj4gc3RpbGwgZnV0dXJlIHdvcms/DQo+IA0KDQpUaGlz
IGlzIHN0aWxsIHdvcmsgaW4gcHJvZ3Jlc3MgYmVjYXVzZSB0aGVyZSBhcmUgc3RpbGwgc29tZSBv
cGVuDQpxdWVzdGlvbnMgdGhhdCB3ZSBjYW5ub3QgYW5zd2VyIGZyb20gb3VyIG1lYXN1cmVtZW50
LCBhbmQgdGhlIHRhYmxlIGlzDQpub3QgZmluYWxpemVkIHlldC4NCg0KdGhhbmtzLA0KcnVpDQoN
Cg0K
