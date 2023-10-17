Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0A27CC9FA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343908AbjJQRfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbjJQRfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:35:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ED3A4;
        Tue, 17 Oct 2023 10:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697564107; x=1729100107;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/u6J8YuFnGgwmAVcYVAdiL7BSrsH2dF4a9eKTbCuswk=;
  b=mPpXa8Y0NsrHusNLiz+d2q9lIa5/kEIXuc5PT9B3fyUyEmnRFz1iXFDk
   olsbE117EoqWQxX5bTQvxc1AwWmPwa3ASwu1Tw0GbCIiTDt+2+UFL4rXK
   kiS9ILQBzM4OOQcbK+Ba+XttsBBbrCpGpLPGLIolmXM/WMhcAQj0gLP/c
   TQa1pP8BWoTCKjVKxiACZn5A5jOAZv3tss5hwebviMcWLzFcGBE02FXLv
   DfMSgx4Qdi8DzwdrlGEdgtdOKoJNB26jzpUwAoU+975oGbTcV/3w0coQo
   V1NE1g7VmCyRrh6gbvSsKcFqXLykZMloNb/5Vk8UVCwJZW8LZpynvavVG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="366101788"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="366101788"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 10:35:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="791289341"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="791289341"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 10:35:06 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 10:35:05 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 10:35:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 10:35:05 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 10:35:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzqkV2KGoY7u0jcASUJs2JGtsXpxh0SlN6djR9mSyEL0cC4ywHoGoUqv9V6vCLzF0VpWcmm2rRteaZXClIeRxmgbG3wPOFy882UZg/HNOiD4gRnVyLY/jOeWO0GV1pxwVpiYVaK/QnpaxUEdVJWZaEqo91rJm6r6iOaWSnU/AU7nMnNjhhs5rhi6GEeeShCBHqoSF6LmqeZes2KAPD73mu9hsDZDIz54CUYMApOLcJGiCo73YechMCDyCGfbNTnVcns624EATOKXwEXn0xaLG7a8O636CIxch31h1RcWx5j8L6gy+DeVdsDlVp15JZxvWNYnNAZh/My7JFrPvNS6Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/u6J8YuFnGgwmAVcYVAdiL7BSrsH2dF4a9eKTbCuswk=;
 b=Dcw8HqzOmTZ98zFUTqwyGZrn3kRJlwc684YDqX/NwTBhT650AFUJB1JovRocxTLfKCeDUYaVkF0YTK/MKRBwkUdKS1qRh9aEDis61nBzog+fmbaNf9iw+6afL8V41b63TGZw77Na8q6iJhuGVydaq/H3DVVfnJ/oe3EyONUZaMZCN24MdKcjYTtn/azw+ffFAXBXu0KQFzQ2SpPbl9mGeuCqJTnjPYBGbR8XAJJOHZiNl0rU0FB3bAOzoXA8foC3l15YHJ9Ekf1NDe2veXvZr3KCUMVo0iVtI78Y9q//+CU0xlLIJu+F8qfF+GQTidWarkrHJ2kWF1VSfljKgMHF3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA2PR11MB5148.namprd11.prod.outlook.com (2603:10b6:806:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.37; Tue, 17 Oct
 2023 17:35:03 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7316:13b0:88bc:b3c8]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7316:13b0:88bc:b3c8%4]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 17:35:03 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>
Subject: RE: [PATCH v3] x86/mce: Set PG_hwpoison page flag to avoid the
 capture kernel panic
Thread-Topic: [PATCH v3] x86/mce: Set PG_hwpoison page flag to avoid the
 capture kernel panic
Thread-Index: AQHZ/lso9WGwaznFOkSBbySsExRE6LBIvACggABKdwCAAx5hgIABCoQAgAAEGNCAAKcWgIAAPfSAgAAqxjA=
Date:   Tue, 17 Oct 2023 17:35:02 +0000
Message-ID: <SJ1PR11MB60830F499CB509A1262C745BFCD6A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231014051754.3759099-1-zhiquan1.li@intel.com>
 <SJ1PR11MB6083A23BB89F4EE0F44B2794FCD1A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <233e17ac-0ae5-4392-a5e4-ab811a155805@intel.com>
 <20231016091143.GCZSz+T1xFf5tCFi2w@fat_crate.local>
 <759ccb97-cf5a-4787-b699-27551d5d2865@intel.com>
 <SJ1PR11MB60834039F485FEBC8031398AFCD6A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20231017111817.GAZS5teT4rFkXVD2KA@fat_crate.local>
 <5398da4c-5286-4e1b-924c-6df91f932427@intel.com>
In-Reply-To: <5398da4c-5286-4e1b-924c-6df91f932427@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA2PR11MB5148:EE_
x-ms-office365-filtering-correlation-id: 05e8fe70-6c33-4ded-df5d-08dbcf376515
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B5nq2qKrb+bpKuDnFVAu5dH6MdS6q1DuXvNDn8GFY/6HzqJgjR4JOlDy40yXvO4xA2DfzUExrrz6AZnWbVII/jS4XXDjG7irS8Re8TigQRwmukchxynimBLAIMTxr1+nv8jQxsLq7XQAYFglIGP3SZ31O6DI+/NYtUbwbAOHDdD10p7EePNXTZBb4JdQ7eRW72zCCS6zoP6DcoFgvX/+dSVFovEimBLc93M+LSXyDJ2OdBGUitV8YJ79sOpzF0v+kHUjK0qqFao9l09kWUOLXZ6KR8YWC5Zq5PBP2oCRdnaisqrXXGWaB4haBC/E/dFy2davet38p+A4x6OeC8FNhYML3YeFML9SKgk2hoOciu0b/K9ovRIxoJHGZY2gBDWpNG8vDLtfLOE0VxceJlgD++WZxWIFJxaa7GFsFbTPj5H/gbrg7dewHnJAuhsyS4Dzb7yUHZTTnVwHGbQpdLd11vJcZWrBxYOzuz4P4TNSGPoTSRcf0uBbqPshR7UUQuSM25YissSQ0xMkSmZ4oVpjS+3M/LSe5x9oAtBtoF7oFrLtSltQN3sIUZYq17D2zjj96EGivdGgQg4S8mLNk1rEgDSVgrpaI/BHCwXcWuvvgIe7qQO4fWYZtOkiF7PTFfk1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(396003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(83380400001)(82960400001)(6506007)(71200400001)(7696005)(38070700005)(9686003)(38100700002)(26005)(122000001)(33656002)(478600001)(66556008)(66476007)(66446008)(316002)(64756008)(54906003)(110136005)(76116006)(8936002)(8676002)(4326008)(41300700001)(52536014)(55016003)(4744005)(2906002)(86362001)(66946007)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHBjb1hndWZXNWRmd2xzbVdPcUtuUXN4bUtNV3UySFhyNVo3ajBhbjdqZlB0?=
 =?utf-8?B?YUdZa2p6RUlXYkw0UE0zRWVsUFlySzRKcXkvZDRwVGRwb2RXZ3h0WlJaclVz?=
 =?utf-8?B?QjA4MDBzbGJwOWMrbGFNNEkxSWVvY2RScTVuZ3VhSzljYndJZWJkM25oN3dq?=
 =?utf-8?B?M1o5Y0UydlhsTTFWRlVHVUE0N3Y3c011WXMrR24zdkF0NU9aWUFoYnRsKzM3?=
 =?utf-8?B?K2QwUmtXWUpiTy85clpFcitGbmw1NWpTSjlQTHFNNUViczRlWThmcGZER3hK?=
 =?utf-8?B?d2JoWWpyL3hjMUZhY28ySXZOMGtCc3RUM290R3NwSDFHYmorVnZOeDFoQWJU?=
 =?utf-8?B?SFBlQW5xT0ZDd3BzRjdJKzl0aDVjL01hQitpK1JuNFRxSlhRcnhkUTBjUXp5?=
 =?utf-8?B?eDZEUEM2SWpyNDdwQ2JHa3NTcGFiQmJ6WUJsQ2N3SFlncUZvVlJDcWRnT3Zm?=
 =?utf-8?B?anlmZC81KzVuRmVUR2dZZXBDeFcvTVRGb2Q5eXVycnhQMjY2YUQxajZFL0FB?=
 =?utf-8?B?cmt3ZmZPanpVZWdwektmV0RqcHFycXhJaHg5RHZLRkpWTkRjNXduQkNqcTNC?=
 =?utf-8?B?UThHUm9Pb0dRc1ZHU2U1ZHV6VXdEcHkwMVoyTGNsamoyckNmWXFXRG1YUmhJ?=
 =?utf-8?B?THVjNmhsck82QTA4Z0ZXMmIvbjBWYXUwdlo4N2xXSFFDSTRrM3lCTGtQRWQ1?=
 =?utf-8?B?a3oxcUlRVFU3bmNzZWxCNWt1OHErSnZhM1VzNGhVWGpNVzJkcHl1UDZ1Mk0x?=
 =?utf-8?B?SDVRbERqYzg4ekhGTG1DaDYvU0N4QlVlZVpyZXdLSHRSUTF1dzRKSzhNU2NT?=
 =?utf-8?B?WExkVEpHRk1BcnlzVDJRZm5CQk1ZRitSTXpxR2I1SUZON2tiNDNtdUJyWm00?=
 =?utf-8?B?ZjB2T0plc1l3bW11MGRsOUVJVU93WEUrUFRjUlQrdzJBRU9zRm1sQW5RUXFs?=
 =?utf-8?B?TUlnTDhyNDUycHhVeWp3dlJPNWhzYmVaeVRlUTNDcTU1QURoQlU3ODlQSlB4?=
 =?utf-8?B?Wm1CZ1o4L2J3R3daU3hSdkpmN2VtMDc3b243YlcyZnlVTkYvL0IrRGorbWRY?=
 =?utf-8?B?cGZVWlFKREU3MDJlcGRDRjMrbE1YVFZDdDN5dEJpMGVHN0Z2RGxGa1MvSHNo?=
 =?utf-8?B?OHQxcE1UUUlpZUJUcjNTYk1pZ1RjUEYzOEZHSjZrYVZmZ2I1allqb2c4YWpl?=
 =?utf-8?B?Z2g2ZXkwd3FtdWtCaE92am9VeTZEOElDRFcyWXNJN25ndW1ITHJnY1FMWGkz?=
 =?utf-8?B?K0dqSllkSXhUV25YVExWa1RJYnhvOHFlTUx1NFZpcEl4MWh4VzEzRERjWWZJ?=
 =?utf-8?B?RDJ0ZHRrNXVreitWMHNJbzVlOU1DUCs3ZzVnekZXUjZILzBrN3o0YTY4YlNQ?=
 =?utf-8?B?Y0pCSzhZckxBUDFDb0JhWms3clA3dlV4cDhuOXJYbnM5ZFhlMncwT082L1dz?=
 =?utf-8?B?dVladnd6SXlQU2JITjZic3VUKzFGRmhLYTVWMXQ1dkJDenlUdnQ1Rjdob3Bi?=
 =?utf-8?B?TG1zVzNlM3NNQ2p5UU9DY25sSCtwNmNWeC8zZHZCYWRWdWc4SXprY1BMYkV1?=
 =?utf-8?B?aTlPNm9VSVE0WnVZZjVEcnIrbjFDc25Vc1BKZ0M1dWNubTlXMjI4eHBmaG9J?=
 =?utf-8?B?VGhYR1pKNFVRaklxbFBGaE9HczYwb2JzRDR4UzRQdUFObzdyRCtGTS83UTgx?=
 =?utf-8?B?TlZpTXJyRC9jYXJ4WFpNQUs0WjRWTlc4VTJlQTh0M0NGWTY4SFBmVDVSd3p4?=
 =?utf-8?B?M2psSmRBeWYwcW5LdGNLQXdqRWQ2K2c5ZSt1cG9wRFdTckpzSlhSVWlWL0Y1?=
 =?utf-8?B?dEh3eER5a0hpOUk1eno5MFlUZUM3dGhVeTludnNlbEpQSkk0ZG9OOXVySFdh?=
 =?utf-8?B?dGF1c1piejh6MnRQTTNvMUVlamxzbHpEMXlTdGYramZ2RHZFdVpBaEFmY0lU?=
 =?utf-8?B?WFBhbmF5TG8rODBkUHd0QXhKdmhpQnJxVi9TQzN4empWdDBNK2gxcFRkelVz?=
 =?utf-8?B?dTV4Mm5kMFJSdEhRUlFsNDlnblRyM0V1NzBYaHB3U1BUdmUrdjRKaUlDRkVx?=
 =?utf-8?B?eEpCcDZ3S3AvdGpSWkRtYlJMcjI4aGhqZEZOcENKVkVucVJrbXF1enBqT3Vz?=
 =?utf-8?Q?/DD9cYCi25VZ5GFKoFStYVOT+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e8fe70-6c33-4ded-df5d-08dbcf376515
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 17:35:02.9043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T2S/Q7Uo+g57+nkr81oV/B42hg+HHoGrqwsEy5zHCdlQlXKNmFEwL150KKoDfSAKYEXZ+c0lYzWWXnSLIJRozw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5148
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBUb255LCB5b3VyIGNvbW1pdCBtZXNzYWdlIG1hZGUgbWUgcmVhbGl6ZSBob3cgdmVyYm9zZSBt
eSBjb21taXQgbWVzc2FnZQ0KPiBpcy4gTWF5IEkgc2ltcGxpZnkgdGhlIHdob2xlIGNvbW1pdCBt
ZXNzYWdlIGFzIGZvbGxvd2luZyBmb3IgbmV4dCB2ZXJzaW9uPw0KPg0KPiAtLS1zdGFydC0tLQ0K
PiBNZW1vcnkgZXJyb3JzIGRvbid0IGhhcHBlbiB2ZXJ5IG9mdGVuLCBlc3BlY2lhbGx5IHRoZSBz
ZXZlcml0eSBpcyBmYXRhbC4NCj4gIEhvd2V2ZXIsIGluIGxhcmdlLXNjYWxlIHNjZW5hcmlvcywg
c3VjaCBhcyBkYXRhIGNlbnRlcnMsIGl0IG1pZ2h0IHN0aWxsDQo+IGhhcHBlbi4gIFdoZW4gdGhl
cmUgaXMgYSBmYXRhbCBtYWNoaW5lIGNoZWNrIExpbnV4IGNhbGxzIG1jZV9wYW5pYygpDQo+IHdp
dGhvdXQgY2hlY2tpbmcgdG8gc2VlIGlmIGJhZCBkYXRhIGF0IHNvbWUgbWVtb3J5IGFkZHJlc3MN
Cj4gd2FzIHJlcG9ydGVkIGluIHRoZSBtYWNoaW5lIGNoZWNrIGJhbmtzLg0KPg0KPiBJZiBrZXhl
YyBpcyBlbmFibGVkLCBjaGVjayBmb3IgbWVtb3J5IGVycm9ycyBhbmQgbWFyayB0aGUgcGFnZSBh
cw0KPiBwb2lzb25lZCBzbyB0aGF0IHRoZSBrZXhlYydlZCBrZXJuZWwgY2FuIGF2b2lkIGFjY2Vz
c2luZyB0aGUgcGFnZS4NCj4gLS0tZW5kLS0tDQo+DQo+IEl0IGFscmVhZHkgY292ZXJzIHRoZSBz
Y2VuYXJpbywgcm9vdCBjYXVzZSBhbmQgc29sdXRpb24sIGFuZCBmb2N1c2VzIG9uDQo+IGtlcm5l
bC4gIE5vIG5lZWQgdG8gdGFsayBzb21ldGhpbmcgZWxzZS4NCg0KWWVzLCB5b3UgY2FuIHVzZSB0
aGF0LiBCZWluZyBjb25jaXNlIChidXQga2VlcGluZyB0aGUgaW1wb3J0YW50IGRldGFpbHMpDQpp
cyB0aGUgYXJ0IG9mIGEgZ29vZCBjb21taXQgbWVzc2FnZS4NCg0KLVRvbnkNCg==
