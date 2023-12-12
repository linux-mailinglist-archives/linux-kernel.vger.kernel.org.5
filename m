Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED66180EE4D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376418AbjLLOEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376403AbjLLOEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:04:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E2194
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702389884; x=1733925884;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tPhIoIsx7fg5jeLFqKIskUS1i+VwCiS+KfBK8fw4320=;
  b=nZZ+T9SgnM1EE7T2b6U2kjjIozZeKv92qql7GhPXOXi1xwcfkGBWVsaR
   SRV/sRvJUpk++NUOKK/nbfbcPA2B4lu0tKpU53dpq0yT2DBGUxNSp61kJ
   CrqCRssNsazeII/MqSdK3soiL9i+aaNaAqCXnVpszjL8tmvALmnTZETtI
   RPuTnrCXfIg1DrFnKgexml7e1xOMXIoty+0gvy195RqrUJ5QHEhObZKDB
   beD6teVEltMeGQ4UhSHpKW/QQoXk4jl2Q5obrxshHP4xpVZdXb6hqYar8
   zD/LPgl48eamj9PU7dd7jHHddIg2+rBTLp90XKHjpJDwV03BTIClauUaq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="379805132"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="379805132"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 06:04:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="21525967"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 06:04:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 06:04:24 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 06:04:24 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 06:04:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K43rWCqRtM+0fXdXkCLs+uJFYuEfJ4DWXGjoeYsvjh4WwhgTNWjuW1HnIjD0mEBkdrMmwOF28+6rPadN/O21ptc84KGpOQm/a660YagLQrPVITdpX06pJ2fDf925Zo9gWFTKfI6QbyzrXLUb8SvdbcIIhqKWPAT4WAzIZ3KRp4aaANFmggu9Tz/tZ1soZIfEaaB0BTLELXNErAtDqzoOjEov8zy0ewnXeJPOO+HETnpJMgY089VgnYsKAab/Ws+ydM3AwW9h3P1sEpb1Z9SiYQQIhHViJvfOw25PAN3oXGVI3vzjqi+/gQ96c6epcpspGFsM+DNTrtZC4ikhzhH67w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPhIoIsx7fg5jeLFqKIskUS1i+VwCiS+KfBK8fw4320=;
 b=XXgDxk3Qe+VGWm3esTOWDCA+fQNlvsF2AhnNxmJj3ujKEklRyZaJt0pisYCFn4fVl/QuC/Q4nB6FRJVoB/zNYdAcQM5PyfZW0SGSsN4wfODTF4u58oEcKodLe8WuaHzQcOaTtJ3jDA4fWzy3jHOTq2Ykruq6xaeaDmexcZFmXEbsoFY+mVQSsgCsldZ9fU4tYaSnCxnbWDEhPUT/cGOV3bSX8C50se5MpQeqd597lIMKgxxcqHuZlm1hzPoUSQcjjVz5HWuLzGsSqxfxNifFDCOZM674U8kojkgWFLcuz4o4AZVoonZ7beI25qPHLQfUP5RXtXBGDvssefoBTXPYGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 BN9PR11MB5354.namprd11.prod.outlook.com (2603:10b6:408:11b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26; Tue, 12 Dec 2023 14:04:21 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::9e26:3fcf:912c:4259]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::9e26:3fcf:912c:4259%6]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 14:04:21 +0000
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "frederic@kernel.org" <frederic@kernel.org>,
        "Dutka, Gianfranco" <gianfranco.dutka@arista.com>
CC:     "bsegall@google.com" <bsegall@google.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "vincent.guittot@linaro.com" <vincent.guittot@linaro.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "longman@redhat.com" <longman@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.com" <bristot@redhat.com>
Subject: Re: Modifying isolcpus, nohz_full, and rcu_nocb kernel parameters at
 runtime
Thread-Topic: Modifying isolcpus, nohz_full, and rcu_nocb kernel parameters at
 runtime
Thread-Index: AQHaKSr9Hkym0B6WFkS99bPthRBpCLCeapcAgAAqB4CAANv9gIAGOxcAgAAKLAA=
Date:   Tue, 12 Dec 2023 14:04:21 +0000
Message-ID: <2059341ff4189c8828a41082248f11712edd2b9e.camel@intel.com>
References: <76587DD3-2A77-41A3-9807-6AEE4398EBA6@arista.com>
         <CAKfTPtAkhfAhFouCGTy7m4swCeeEsu1VdWEX_ahOVDq1U594Dg@mail.gmail.com>
         <ZXJKAnrRjBUmKx1V@slm.duckdns.org>
         <d46834f4-a490-4a4a-9e95-cca4a6316570@redhat.com>
         <25E6E1E4-DC16-490E-B907-A3236FB9317A@arista.com>
         <ZXhf3A0FNjFZaZGK@lothringen>
In-Reply-To: <ZXhf3A0FNjFZaZGK@lothringen>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|BN9PR11MB5354:EE_
x-ms-office365-filtering-correlation-id: 08d12e70-43e4-4e76-df2a-08dbfb1b3d3e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gloRrmo+NbzwKxmJpAuXjAdSqyxo8OFba0IR51g2g3w3v//fntcfiRkSfEwWNfHQZVTz6E3qw3pCEt6avtxMO5BR/Aol30KJFXLYIseid50X0cgjiAkGURAMLaLDsKTlbTeFHsfvyb87E2u9oljCdLimXJK5C05hy4nyOZgzOjWzcKyn5CpdocOxdpzxOFgrNFZwbNOpu1Ek7lM0ECTOLBfDNTdjQdGg3zkBh9ieMl+MZE20nPT4enR5awwOr7RnMgXoICsuwLsLZXZAogrg9cw4Ojg5bA/d4KcRjs8GwZxVdbpiwWcWc1+cToaNmCSz6mMn6hDVVQ4gzs+Z+gazE/WhVVy17rrrrsd0r+udTzy69q7KdRmeI+R/MYG2zibCI4Tfro6sb/6PWUZOk8FlyqDH7LgUD3lSzO6dlp3YGTW4VP8tOLXIhTf7ddmsn2YUn4gXN2Hoss6cAxsOy+Avb+vlccNMrG3MQMpoBnsdfYvlzJ/vncXJDZfkF9HtxRd1oBmYbU0+yLCwQLaGIex8S5dj3g9F+/3BAtB4i1NEQuxMrZVo5hilGOxA61/5iE2v/geTkY/v2Rx9aiBRGpoQhlgx67yBNQqK6z1ADbIVX6E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(110136005)(26005)(83380400001)(6506007)(6512007)(2616005)(122000001)(5660300002)(4326008)(8936002)(8676002)(41300700001)(7416002)(4001150100001)(2906002)(966005)(6486002)(71200400001)(478600001)(38100700002)(316002)(66476007)(66446008)(91956017)(54906003)(64756008)(66556008)(66946007)(76116006)(36756003)(86362001)(82960400001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VExsRnUrbDA4KzlYek1ic09iZmJ2U29SRGh4Sng2UG84dTFXeHlZcWJkbFZ3?=
 =?utf-8?B?dURyRU9aRFRoWjBUZWNjamQzWDEzY2Z6eXRYTXlGR0IraDdrT1RrSVBKcDBB?=
 =?utf-8?B?bmdjUjlzMUhTTTNqUml6N3RQWklmaWVGZHd4cnhiNGlYeS9nTE1kVzhRWVlo?=
 =?utf-8?B?WmVVRUZrZ1dyUGhUdmZSRWcyM3BnSklNUTgzb1VoNUEzcXdyYkYzWWVJaWU2?=
 =?utf-8?B?Vnk3L3htRkVaaFM2b0dtVVArcW1DTFp0a3Y0RlE0OWpFM2dGTDlySW03T0NC?=
 =?utf-8?B?b3U5eDBHN3V1cGxYVXNOSXg0TGJwN0pETklxZnVORGJxa05ma3lidDlKb2FR?=
 =?utf-8?B?ZTZiN1pqbDlpVmxERVY1d2ZOM0lka1pYOHVJcU1WYUpCNDBCbzdOcW95aVJF?=
 =?utf-8?B?TEY3dklNY0w1TlJhWEl1TkVPdFlFZkJyaXdBZ3NSV0h6MUNnNVFpUGNtUlZK?=
 =?utf-8?B?K1dpNGlqWUQzYlkzOHh6RENENEZjdW1wMkZhdlJsRFFkQ05hUHEwcGFwRXZi?=
 =?utf-8?B?ZlIyTkdSY0dSOW1Ta1ZpUE5DaDBNM25xOXRTTWJvWndSZDNRbExkeXRxZ3JZ?=
 =?utf-8?B?eWE1WG91eFY5enhrc0ViRzIyRUJQd1VnZWdob1BlY2tyS0QxTDlxRXc5bFRm?=
 =?utf-8?B?SEw1K0VvUHVwQU5GODQ1UTdaVXJEazlIajRZcUlkUWtWVUNCdmlhRGJSZ09n?=
 =?utf-8?B?Mll3aVh5c20vd1ZiMGdUNTdkSExHbTFnQnE4eWE1OFRwakkwSm1sR0VqMWVa?=
 =?utf-8?B?ZGl1ZTh1bU00S0RGelZ0aEhHU3NDcGVaWGZ0bFM2UnhVNG5SaHhrNUVyblQr?=
 =?utf-8?B?Q3VlQ044eHkzUUxwKzF0S0JONFQ1NHVaemwwQWd6YVZ5QTROaVlnZldzRzdY?=
 =?utf-8?B?UTdYbEtXSGQrTFVJNFNhczBpSU5la1JmdHYvZ2xxbGJoM1preE1VRjIvWlR4?=
 =?utf-8?B?N3lGeEM0VEprUkhVNllPaVhGL1Y1bjl3Mm1xcHpMejBseFVSNFRDVldyM3kx?=
 =?utf-8?B?MmoyVHNGcmlzbHpVV1czdUlMUm9wcHpmeVF4MnNWTFJ3dTZTWktOUVVWK1JV?=
 =?utf-8?B?VVBkaGV6NURUZ0M3MjY1ZUx6Q0hkcnlDaUxlZG9YTXVBL2lkVnlmQUlJVDNx?=
 =?utf-8?B?am9qZWVRRVp0WktjWkhYOW9CTHZ3R040U0laWHFtLzUrN1UwS0g3SGt1MGow?=
 =?utf-8?B?NmEvYkxRL1UzazZFQWNsbzhnRUM0OVVzcmEwOTViRkxGRkc2blFmYytVWnRl?=
 =?utf-8?B?ODRsVVVrSEtsZ0paUU9raHpsUVlHVEFKaDROUkFYK0hIZERkYW1rZGZYTzZL?=
 =?utf-8?B?SFVWd3hVdW5LL2JBYkRvVHE5Y2FLSEdINzRjVHBvU2ZHOFlCN1ZKMDk3MXM5?=
 =?utf-8?B?RlpUZTNDa21ydHRJV3lQVnYxdHhOeFZVMkV5NklaV0E1M3hYQlJkQ2dSb1Rx?=
 =?utf-8?B?WmsrVzNpejFleDY4bTU1anZoaEhUVTVzclczOWJ1anIzaWtVbnl3cWJKZ0x0?=
 =?utf-8?B?WFB0a0NmbEdxUTlxNVNmcG5WWS9iUEtSRUVkZDF2TzBGUXFnNzdzR2piZzFU?=
 =?utf-8?B?ODZ3M05adlBweTlKam93UVZqcmlqbWZxeVRzeENqVDIrS3dBb3U2Z2VXVFdD?=
 =?utf-8?B?U0Q0ajdUY0xHeEw0b0pkUVoxc095WFpnUFpyY1VEU2EvWmxDdm5VNnNsQkhn?=
 =?utf-8?B?dU5Yc2U4SzUySTMvNmRSc3ZTVU1Pbm91WWdqdlJucnJYRHovWldXc2R3ZUZz?=
 =?utf-8?B?QzRnZEdDOWwrMXdnVUx1R2lPcDVMbzZaSWJiWTM1dklLdHZmejE2blM2UDdu?=
 =?utf-8?B?S2lNU2ViTXp6TGg0VFJuaWlqc0pHd0taWGpXcmNSa2N6SXl1d09GcGMwWTdx?=
 =?utf-8?B?dDVyVk90c1RvR1NwUjVVRFhmS09LZDNWak5LNFc0R0dUcVBmNEpkL3hsKzlH?=
 =?utf-8?B?T0FyWFN2S3BiRmhNQ1RTQ01RQTZOcUNUZXkrOUViMnVxQXkyQnpiejBRME5j?=
 =?utf-8?B?b0tVWG9JamtTcmhEbFRNSlAzOGUzeUVqVXk4UmZEcmNUYkJNZzRIZm41ek1P?=
 =?utf-8?B?aW1mKzZTdXRKRU5xUEQxNVFEQ29XZHZMNTVWNGFGUzhkZ2R6cDdUTTVJVXJl?=
 =?utf-8?B?UUNJSXV3SGRkRzdIWjlNMTV6K1NNQ2c5WFlrQlgyZFlPSml5YkRwN0szdUpV?=
 =?utf-8?Q?JuDerCsl2uT8DJZ5tOQw/5E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF998F83CEECC942B8171356B9D87422@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d12e70-43e4-4e76-df2a-08dbfb1b3d3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 14:04:21.2887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amDqlSeUYTf0YQcu+U7VcvaWHJ+xHk4fF/b5S6MJeuFeRpF83ZovlIbUVZ+9VUdhB7mgdnyRNEpPCs3SUrNR7afySFT7YKNjc1rpzhmVpBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5354
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRnJlZHJpYywNCk9uIFR1ZSwgMjAyMy0xMi0xMiBhdCAxNDoyNyArMDEwMCwgRnJlZGVyaWMg
V2Vpc2JlY2tlciB3cm90ZToNCj4gT24gRnJpLCBEZWMgMDgsIDIwMjMgYXQgMDk6MTg6NTNBTSAt
MDUwMCwgR2lhbmZyYW5jbyBEdXRrYSB3cm90ZToNCj4gPiANCj4gPiA+IFRoZSBpc29sY3B1cywg
bm9oel9mdWxsIGFuZCByY3Vfbm9jYnMgYXJlIGJvb3QtdGltZSBrZXJuZWwNCj4gPiA+IHBhcmFt
ZXRlcnMuIEkgYW0gaW4gdGhlIHByb2Nlc3Mgb2YgaW1wcm92aW5nIGR5bmFtaWMgQ1BVDQo+ID4g
PiBpc29sYXRpb24gYXQgcnVudGltZS4gUmlnaHQgbm93LCB3ZSBhcmUgYWJsZSB0byBkbw0KPiA+
ID4gaXNvbGNwdXM9ZG9tYWluIHdpdGggdGhlIGlzb2xhdGVkIGNwdXNldCBwYXJ0aXRpb24gZnVu
Y3Rpb25hbGl0eS4NCj4gPiA+IE90aGVyIGFzcGVjdHMgb2YgQ1BVIGlzb2xhdGlvbiBhcmUgYmVp
bmcgbG9va2VkIGF0IHdpdGggdGhlIGdvYWwNCj4gPiA+IG9mIHJlZHVjaW5nIHRoZSBnYXAgb2Yg
d2hhdCBvbmUgY2FuIGRvIGF0IGJvb3QgdGltZSB2ZXJzdXMgd2hhdA0KPiA+ID4gY2FuIGJlIGRv
bmUgYXQgcnVuIHRpbWUuIEl0IHdpbGwgY2VydGFpbiB0YWtlIHRpbWUgdG8gcmVhY2ggdGhhdA0K
PiA+ID4gZ29hbC4NCj4gPiA+IA0KPiA+ID4gQ2hlZXJzLA0KPiA+ID4gTG9uZ21hbg0KPiA+ID4g
DQo+ID4gDQo+ID4gVGhhbmsgeW91IFdhaW1hbiBmb3IgdGhlIHJlc3BvbnNlLiBJdCB3b3VsZCBz
ZWVtIHRoYXQgZ2V0dGluZw0KPiA+IHNpbWlsYXINCj4gPiBmdW5jdGlvbmFsaXR5IHRocm91Z2gg
Y2dyb3Vwcy9jcHVzZXRzIGlzIHRoZSBvbmx5IG9wdGlvbiBhdCB0aGUNCj4gPiBtb21lbnQuIElz
IGl0DQo+ID4gY29tcGxldGVseSBvdXQgb2YgdGhlIHF1ZXN0aW9uIHRvIHBvc3NpYmx5IHBhdGNo
IHRoZSBrZXJuZWwgdG8NCj4gPiBtb2RpZnkgdGhlc2UNCj4gPiBwYXJhbWV0ZXJzIGF0IHJ1bnRp
bWU/IE9yIHdvdWxkIHRoYXQgZW50YWlsIGEgc2lnbmlmaWNhbnQgY2hhbmdlDQo+ID4gdGhhdCBt
aWdodA0KPiA+IG5vdCBiZSBzbyB0cml2aWFsIHRvIGFjY29tcGxpc2g/IEZvciBpbnN0YW5jZSwg
dGhlIHNvbHV0aW9uDQo+ID4gd291bGRu4oCZdCBiZSBhcw0KPiA+IHNpbXBsZSBhcyBwYXRjaGlu
ZyB0aGUga2VybmVsIHRvIG1ha2UgdGhlc2Ugd3JpdGVhYmxlIGFuZCB0aGVuDQo+ID4gY2FsbGlu
ZyB0aGUNCj4gPiBzYW1lIGZ1bmN0aW9ucyB3aGljaCBydW4gYXQgYm9vdC10aW1lIHdoZW4gdGhl
c2UgcGFyYW1ldGVycyBhcmUNCj4gPiBvcmlnaW5hbGx5DQo+ID4gd3JpdHRlbj8NCj4gDQo+IEFz
IGZvciBub2h6X2Z1bGwgKHdoaWNoIGltcGxpZXMgcmN1X25vY2IpLCBpdCdzIGNlcnRhaW5seSBw
b3NzaWJsZSB0bw0KPiBtYWtlIGl0DQo+IHR1bmFibGUgYXQgcnVudGltZSB2aWEgY3B1c2V0cy4g
SWYgcGVvcGxlIHJlYWxseSB3YW50IGl0LCBJJ20gd2lsbGluZw0KPiB0byBoZWxwLg0KPiANCg0K
V2UgaGF2ZSBhIGNhc2UgZm9yIGR5bmFtaWNhbGx5IGlzb2xhdGluZyBDUFVzIGF0IHJ1biB0aW1l
Lg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL1pOTTVxb1VTQ2RCd05UdUhAY2hlbnl1
NS1tb2JsMi8NCg0KSXQgd2FzIHN1Z2dlc3RlZCBieSBWaW5jZW50IHRvIHVzZSBob3VzZSBrZWVw
aW5nIGNwdW1hc2sgZm9yIHNvbHZpbmcNCnVubmVjZXNzYXJ5IHdha2UgdXBzIG9uIGlzb2xhdGVk
IENQVXMuIENhbiB0aGlzIGhvdXNlIGtlZXBpbmcgY3B1IG1hc2sNCmFuZCB0eXBlIGJlIHVwZGF0
ZWQgYXQgcnVudGltZT8NCg0KVGhhbmtzLA0KU3Jpbml2YXMNCg0KPiBUaGFua3MuDQoNCg==
