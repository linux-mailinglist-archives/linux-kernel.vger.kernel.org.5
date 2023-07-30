Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900E67684EF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 13:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjG3LKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 07:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjG3LKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 07:10:43 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0B110FF
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 04:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690715442; x=1722251442;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/UZEFD5Q5s+sCcrSu3x3Qmee3YQ2Rd58OPsaXTgWV8A=;
  b=HfN9cdwJAW2iMiKNDGigLfgliIW+fZJpZNWEdeCSUrfQPR41Bf7tEgev
   TTy/js7lHhvYuo907V0J/v++DEKUBkdEC6P/oX+3U1ml50VuTihCSzvfA
   nvaozEniZBkuj4d7NiQSBuB6brqcCjfDdt8D0ezrhmbaLTC3i1p/vto8Q
   u8l1EAJwHpTnNBW58oKBwZ3Vis3LhlvEYKr8yjOi2fAp8Oyv0rbYeDuTG
   vC4pVdsDuZDPpHiP3i4imDxdEI10npZN/2LhOo3WBYrwDvdSUDzVrqypT
   2fMJi+dJyXgrrK18NAQAzmEcqtBBf+NtKd1CjdJ5V8alxvk0B7pCaZbaC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="455202405"
X-IronPort-AV: E=Sophos;i="6.01,242,1684825200"; 
   d="scan'208";a="455202405"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2023 04:10:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="901790745"
X-IronPort-AV: E=Sophos;i="6.01,242,1684825200"; 
   d="scan'208";a="901790745"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 30 Jul 2023 04:10:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 30 Jul 2023 04:10:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 30 Jul 2023 04:10:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 30 Jul 2023 04:10:40 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 30 Jul 2023 04:10:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iX6tGvGnsVBHO0zAlw6UH+N8cewvBM/QMJqmh7N5DpRODb5P69PYd+9s194/SXpgTdycAT5+ymHalaUIYOgW7i+16JrxQosBlCr1TyDs71BX5IlSLOwahTmotDSSAShn1QfBe0h2ilX8L2YqTIwbPYJ9razge5iB5L2YzUj2LSIXCMO4iGKmxmZgTslf4ifudgSrUdlFfkCLpBRMPi4RTrXAThV41HawLlTeoVjA5hgzq6Nbzqa1E+EeiZTvCDYgCFpMjEu+ffXJs9Zi6uSikraao/cxttULyPRZmuIfrfUu07mCuJIaojsvXiEN1pHfvFg6ETXVwv4Uz9p0huqhaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UZEFD5Q5s+sCcrSu3x3Qmee3YQ2Rd58OPsaXTgWV8A=;
 b=V47/hcNCSZ5xDK/ury9llobRiOaMUbxSAwb87nGFLTPl7zmjgjJd0aP4TIYdFOnTMXJXkUlfFlaYA1Nj6xBzRpJkA3Wy+D4kk+x27U9gwr8pQks5x0qABPDlHUjzSWh0qHuc1Jf4ud76WCkLb3zR4dqPn+9reoGvuZ/HJnxqgi+bFAJmJhJSnzloeEVpU0K3r2vg/cWawsMcSg3q9wpm1k0BaqbrPM1NVDRO7YFURVsmwHx/hQwiuoQpE5hwB7H3x/CBSpkSgv2MXz09ETOjGah2PqN8LhXKNbNkxBLopUG9sekv7j5shJ4AdcMMqJNEBAK4npo2aTpp34LraTCfzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by PH7PR11MB8479.namprd11.prod.outlook.com (2603:10b6:510:30c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Sun, 30 Jul
 2023 11:10:38 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::f8a8:855c:2d19:9ac1]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::f8a8:855c:2d19:9ac1%7]) with mapi id 15.20.6631.042; Sun, 30 Jul 2023
 11:10:38 +0000
From:   "Usyskin, Alexander" <alexander.usyskin@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>
Subject: RE: [PATCH] mtd: fix use-after-free in mtd release
Thread-Topic: [PATCH] mtd: fix use-after-free in mtd release
Thread-Index: AQHZwJtISddYv7J3rUGIhkR1woyPZ6/NuDAAgAACR4CAAAqxgIAACoiAgARbWXA=
Date:   Sun, 30 Jul 2023 11:10:38 +0000
Message-ID: <CY5PR11MB63660B9CE604C0CFF2E088DAED04A@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20230727145758.3880967-1-alexander.usyskin@intel.com>
        <ZMKJRNDoQV8p0DH4@smile.fi.intel.com>   <20230727172013.7c85c05d@xps-13>
        <ZMKUJbl7kFOfgKGg@smile.fi.intel.com> <20230727183611.37d01f51@xps-13>
In-Reply-To: <20230727183611.37d01f51@xps-13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|PH7PR11MB8479:EE_
x-ms-office365-filtering-correlation-id: c3dbafb8-4238-4381-2c59-08db90ed9ada
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vamHM3bo8weEyBzW7QWvxd50Heth/qQ5Jvamxp7K1oEvJ+AFPA6fKjGHPnIXAUryAipcJHRHdBJGZ7rStNLS+0YRw4wl442pxABS9h+y8yg4Q+GxQWRwWc15MlwAiZgRl/anLR6vQkmtqW4W96BAnmEw0i8BdAuf0afHUOIA2fLTdb7rtZ7+8bPY+00RbLIUcy3WQ2H34DiJKYoXNX/wE3lERowa8PLS45v+W8TD7uj4DunTVWSsVLqFzQMQeabhP3rlwS5pmVKpgLEtE/5af832OLOqeld+xHO8LKz5Zfpd+1SETdpWcPae2PEkjoVNIk7dd6FAOO2WqUe1kCc5TvbIGcxSOYWArNqIqZDnFTLPRVx6Ypj4lQ/adfamQOKvq/Q4witLc9PJcUfgkv8YWe46ncxOEaSQyIzoFo9yQgob04+oFhF/dkJhYoJJOw44WTIQ+7u5gnGN761EFFMpIUdKqoez9/jRRmwTUk+fw1kvYo1N+8LhKCGF7ZGtBOptgxSHfTiIw04wIdwLLispUAeAD5qIxRl1HJy5PTY1XAe+n9sXdWvTrQEyvm52p6usZQTURqrBFwdiQ3664IOEoi/+T37l9PUObTcPBuZJVyIKyMD8PuNjYGdHzzFUKfBZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199021)(38100700002)(82960400001)(122000001)(55016003)(86362001)(38070700005)(33656002)(9686003)(478600001)(71200400001)(7696005)(186003)(6506007)(8676002)(8936002)(5660300002)(52536014)(76116006)(4326008)(66946007)(66556008)(66476007)(2906002)(66446008)(64756008)(54906003)(110136005)(41300700001)(316002)(66574015)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a29WYnpRSkFpVDR4MEFLMk1pQW0rNEZxL0FzN0d4YWdqNFJpMVpFZXBWb1B0?=
 =?utf-8?B?UTJnMk9NRzJSNFNjYnJTbWw4cVNJbVBpWGxXZEtWZ0lLekpZRk5qcVJRRW1K?=
 =?utf-8?B?dlI1VDVsdVRKRG9jUVRYamdxTEZpSWp5V29veGsxRHdoNW9mNzBkcHZTclhj?=
 =?utf-8?B?TnY1ZFY2UlVRU2pNNjVmLzIwNW5ERUNtQW5LSDEzQ29IZTBHa1NsZjlnWDI2?=
 =?utf-8?B?QVJyeGJZcEdxUVhoblBmVDY3TFV6Y0UrTDhNTm9SNk1CL0NJOFRMUkswQ2RQ?=
 =?utf-8?B?WTlsTFg1RFFmS2szaHRyd1IwbnA3NjRuSmdva1o1WklIVjhNR0NrTnRiK0Jj?=
 =?utf-8?B?d3dzeFBOUU5wRitPYTMwYlIvMUs4OVVzeUFzNnQvQzVLa211S3A1eDh4UWtX?=
 =?utf-8?B?N0Y0elZYVUdRWFM3M29FcHJDT0xZd1piL2kyWDBTT2NoUVg4bXFRc3hwZVJW?=
 =?utf-8?B?QTc3VWNYaEFNTCs3NGtFcHFNZllaMFBKWkhXcXpheEozT3JGRm1XemxwVTdn?=
 =?utf-8?B?Vmt0K25DSm1UNGJVSnZ6RkVWNkRJUElCbEc2OWJuSDJ1VTFWcjUyMysySlMz?=
 =?utf-8?B?dnpQL2ZKSUFaeTlWRU1ReFlrYnlJZ1AwRFhQZmttZUtaeEx3Z3pTUUZuZ2lS?=
 =?utf-8?B?MTlaZFZQZzkzd3JUZmYzR1lRdG83eVdOZCtKY2czU0M2cnM3NjZISzRLRWJJ?=
 =?utf-8?B?aENTMGMzWmJqbHJHaGFJaXgxL2tTTDZqeHRKdk5SN1E3bWI2SnJSVGY5c2Y4?=
 =?utf-8?B?VHFiUWNXZFpXYy90cWlrYlhTZTJGbno1RDJYZEh1a1ZISTc0bEs1SGM0dER5?=
 =?utf-8?B?bkgvRGFtcWViODFWL0ZaazNEQnk5bklWM2hEV0twMllBQmxZdC9VNUhPam0x?=
 =?utf-8?B?V2J1bnY3RGRNQTBkR1VXNERrWkIyMHhlQzdRRlhRZUttV1BRVi9remhUSWNB?=
 =?utf-8?B?S2RyYzlBUzdUaWFDNWlIL3p0OWdHOHZwK0pKdExuWmdrTzNVMEkrNHYvZGFv?=
 =?utf-8?B?L2dCM1JTdnVZcWJRMzA1bXQ3MGJzTXNwcmJiQkcxQ083NmJ2SWo4azlxaFFT?=
 =?utf-8?B?cXZmTVc5RW5xS0V2azVwM0NDdmg3OU04Z28vcXJueHI5WjZXWVk4eWVOSEJ1?=
 =?utf-8?B?TTNkS1E1eEhMRXFJYVpITmdCWk1BMTBRekl4N28vYlMrOXNLK1Bhb255ZXR6?=
 =?utf-8?B?UVJlTVhueU00SytjMXRCUUY4QnRqeTZ2U2N1bnRwWDRldjBIZkRlTHpTck45?=
 =?utf-8?B?NzQ4UHZkdUVRUWdCSGYzczZHOWE2YVZxSXhDTEtNZmRyYXVhYlFjam9NVkxx?=
 =?utf-8?B?SGtKUDJieWdmZDgvUUhMWkE5M1EyNXA4L054ekdmazVOMkFIanI4RUE0eWhh?=
 =?utf-8?B?eGRVTVpzaFhDbStvOVVFS0drLzNVQjNoZStGVTVuYi9xWWFIdithd0NkaEE4?=
 =?utf-8?B?NFYxSThmTG9Jekx2U3E4bzFqWmQ1dDJxTlpLYnZJUFdUb002Y21uang4UWlQ?=
 =?utf-8?B?NHFGR2NGeWkzOHQ4TE9MVG9hVVNhVjREaEtaK2EzcG0zR1NwN2dqUmlqTVFn?=
 =?utf-8?B?UTF3Z0FMVG9kQTkzLzhiN0I2TnBLcmpLcjBMd0o4OENnczl6anhPYXJFWldn?=
 =?utf-8?B?NWJCeklmSWplLzMwMTBoNE03Z0FjK01SWkZ2YUY5ZnZIZno3MERUS2hVWk5Y?=
 =?utf-8?B?N283NGFrREh4Zk95dmdSeldydDFPZmNVN0lRcGVWaEsyNXZWY2wvdHBGSVUr?=
 =?utf-8?B?MXl6U2hvSURJZGpnTElJRmhzQ3BmT2M5TnEyUkNZcnhzU0h6S0pWa2xWS0hN?=
 =?utf-8?B?VTVWdzd5aFFndTkwNmJsOGk5bEpPU1BHUGt4NWFsVzg4cW9ZUStBcFliUld3?=
 =?utf-8?B?ajhFUWRzRmpFMkRPVWFTZGxZY3EzUWtoUnNiYzdhZU5ick1Gd1FIRDM0bjBX?=
 =?utf-8?B?QjNNdlUra2Q1OERZdUVwdXhRemR1ZDAwWHQ2cmpackVWZnhwby9WRkNYNHR3?=
 =?utf-8?B?Qk0xeWJVbWRpb1RkWVVoWmFqN2d2TENmVnIyWDlHb3hrOHhncCtvYndtNDJa?=
 =?utf-8?B?OTVjdjJHUnJBNEZvZmNUbjJ3RGRLNFozejM3cjR1bmRHcVY1cW1OMFhocmwx?=
 =?utf-8?Q?g4rc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3dbafb8-4238-4381-2c59-08db90ed9ada
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2023 11:10:38.2326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xanafXsOJWUKXfGnlwUpklfhRskkXdoCh5exOXDSTR44WChqbyz26WTDpLNdxjf2LzZ5tR44Dt/MsIAy8IuP7o1jh0Mhi5KhNKQjH86W25s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8479
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

PiANCj4gSGkgQW5keSwNCj4gDQo+IGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbSB3
cm90ZSBvbiBUaHUsIDI3IEp1bCAyMDIzIDE4OjU4OjI5DQo+ICswMzAwOg0KPiANCj4gPiBPbiBU
aHUsIEp1bCAyNywgMjAyMyBhdCAwNToyMDoxM1BNICswMjAwLCBNaXF1ZWwgUmF5bmFsIHdyb3Rl
Og0KPiA+ID4gYW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tIHdyb3RlIG9uIFRodSwg
MjcgSnVsIDIwMjMgMTg6MTI6MDQNCj4gPiA+ICswMzAwOg0KPiA+ID4gPiBPbiBUaHUsIEp1bCAy
NywgMjAyMyBhdCAwNTo1Nzo1OFBNICswMzAwLCBBbGV4YW5kZXIgVXN5c2tpbiB3cm90ZToNCj4g
Pg0KPiA+IC4uLg0KPiA+DQo+ID4gPiA+ID4gRml4ZXM6IDE5YmZhOWViZWJiNSAoIm10ZDogdXNl
IHJlZmNvdW50IHRvIHByZXZlbnQgY29ycnVwdGlvbiIpDQo+ID4gPiA+DQo+ID4gPiA+IENsb3Nl
czogPw0KPiA+ID4NCj4gPiA+IERpZCBJIG1pc3MgYSByZWNlbnQgdXBkYXRlIG9uIHRoZSB1c2Ug
b2YgRml4ZXM/DQo+ID4NCj4gPiBUaGV5IGFyZSBvcnRob2dvbmFsIHRvIGVhY2ggb3RoZXIuIEFj
dHVhbGx5IENsb3NlcyBnb2VzIGNsb3NlciB3aXRoDQo+ID4gUmVwb3J0ZWQtYnkuDQo+ID4NCj4g
PiBJIGJlbGlldmUgYm90aCBvZiB0aGVtIG5lZWRzIHRvIGJlIGFkZGVkIChieSBJIG1pZ2h0IG1p
c3Mgc29tZXRoaW5nKS4NCj4gPg0KPiA+ID4gSSB0aG91Z2h0IENsb3NlcyB3YXMNCj4gPiA+IHN1
cHBvc2VkIHRvIHBvaW50IGF0IGEgYnVnIHJlcG9ydCB3aGlsZSBGaXhlcyB3b3VsZCBwb2ludCB0
byB0aGUgZmF1bHR5DQo+ID4gPiBjb21taXQuDQo+ID4NCj4gPiBDb3JyZWN0Lg0KPiA+DQo+ID4g
PiBSaWdodCBub3cgSSBmZWVsIGxpa2UgRml4ZXMgaXMgdGhlIHJpZ2h0IHRhZywNCj4gPg0KPiA+
IE5vYm9keSBvYmplY3RzIHRoYXQgKHNlZSBhYm92ZSkuDQo+ID4NCj4gPiA+IGJ1dCBpZiB5b3Ug
aGF2ZSBhIHNvdXJjZSBleHBsYWluaW5nIHdoeSB3ZSBzaG91bGQgbm90IGxvbmdlciBkbyBpdCBs
aWtlDQo+ID4gPiBJIGFtIHVzZWQgdG8sIEkgd291bGQgYXBwcmVjaWF0ZSBhIGxpbmsuDQo+ID4N
Cj4gPiBTaW5jZSB5b3Uga25vdyBhYm91dCBDbG9zZXMgYWxyZWFkeSwgSSB0aGluayB0aGVyZSBp
cyBub3RoaW5nIHRvIGFkZC4NCj4gDQo+IEFoIHNvcnJ5IEkgbWlzdW5kZXJzdG9vZCB5b3VyIGZp
cnN0IGUtbWFpbC4gSSB0aG91Z2h0IHlvdSB3ZXJlDQo+IHN1Z2dlc3RpbmcgdG8gcmVwbGFjZSBG
aXhlcyBieSBDbG9zZXMuIFNvcnJ5IGZvciB0aGUgbWlzdW5kZXJzdGFuZGluZyA6KQ0KPiANCj4g
VGhhbmtzLA0KPiBNaXF1w6hsDQoNCk1pcXVlbCwgaXMgdGhpcyBwYXRjaCBoZWxwcyB3aXRoIHlv
dXIgb3JpZ2luYWwgcHJvYmxlbSBvZiBkZXZpY2VzIG5vdCBmcmVlZD8NCg0KWmhhbmcsIGlzIHRo
aXMgcGF0Y2ggaGVscHMgd2l0aCB5b3VyIHByb2JsZW0gd2l0aCBLQXNhbj8NCg0KLS0gDQpUaGFu
a3MsDQpTYXNoYQ0KDQoNCg0K
