Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DE279EC3F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241074AbjIMPNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241107AbjIMPNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:13:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9E1BD;
        Wed, 13 Sep 2023 08:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694618007; x=1726154007;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UiIAppevSOcxPjl8HUSJb99QzvDLMJMlE19koUTcWmo=;
  b=a3EIx4YqgBQB9tcSs0M5823PSw9bQHgpF22Yx9EIeVCTxyZukPjzE+0w
   +73ANQGqvs4rtFQ1/OC1j8X0p/HEMv0Kv/AwfWsR7+QrEVEyv7mYZLQsX
   4vaYS/+D727HRbXoo2q0DfuvJUr1TeO7YbWgeRPC/dl3gEB4tXJpJkfg+
   lqv89qmfussoJAtsuwivIBDETgXzuF1ZPjsj85m25Zqr5dQ4bmlZuizSC
   bBXvBPyJZ8eEAsbdxXiJ+rNK2SZRHD2spAc6nuSlBjujwTRva7CQGMc+e
   KDaJk8X9XRq0W7gaaue3FMtJzf2uo0Nsbn504OS2/yxNs/OgMjxeBNfUh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="377597538"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="377597538"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 08:13:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="1074992136"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="1074992136"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 08:13:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 08:13:21 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 08:13:21 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 08:13:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMoB8O0fgcN3fAjVQVtZ0YOVe0vCUjdhVnecwJZnJNdDdBbINe7+uPSp7yU0wv1SH7K4MqTXVXt7/+tz3oFO5dqq2t+4D+p/ecpeW8D8lh9cJlPZXNl6OJRvv6ZHAfRrKy0XmVqMxic93tkuGoVvEfV0Eug557CsrOBHd5/KAmF7YedneXJ1zpIWeyudP/4Av2uH13PYOex+CS5YSQbYxmvO7DJHBZDYLENHmdLaWDhLwamBzjJYK0TJYPYHphdBXCt4oRGqeFhBRPIW8p5Vbmo1nUBltrX2VKwo5adMAScwqjIZR1iqiGYBlykevvTOIBBhAB0+J0Mnazp3LqYGMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiIAppevSOcxPjl8HUSJb99QzvDLMJMlE19koUTcWmo=;
 b=ghowUT3HE3jUAY8Gnu/dA7bKBYnQMDeYTGamlf94mfc42NYu5rps6qvsdTkMPoeAxtEN0g94w6+zPgvKSRPDU8l6ya32VP5zlgM0Xa2D0l4GOzYC1UFan7DdFmntzGEPrKE/JLKqnH2rVtTw0NTW3HMEOfjaH03T6nFGkukJ2ij0PweTDbGqCeVvILO4HUZ69BAqLulBO5O+XoJytycMfDyErKsYlOwS2h08eXJP8RLIA1Nzx84ngDivyYsdziVH0p2HSd38MsoeeQN8ke0epNmvTJVejLopD5gucRSGX6V4zIQ6wVnm8NOK6SRw6kfe7Paak4EHKcuir2jai3w1Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SN7PR11MB6825.namprd11.prod.outlook.com (2603:10b6:806:2a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Wed, 13 Sep
 2023 15:13:15 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4%6]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 15:13:14 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Justin Stitt <justinstitt@google.com>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] EDAC/mc_sysfs: refactor deprecated strncpy
Thread-Topic: [PATCH] EDAC/mc_sysfs: refactor deprecated strncpy
Thread-Index: AQHZ5eFYpQUcS+hIBkqXjxZAqZKjl7AX9+sAgADj3TA=
Date:   Wed, 13 Sep 2023 15:13:14 +0000
Message-ID: <SJ1PR11MB6083BEE91F07BC4077FE38F5FCF0A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230913-strncpy-drivers-edac-edac_mc_sysfs-c-v1-1-d232891b05b0@google.com>
 <CAFhGd8pGikrizmQPF7qD6C4NcYqBVqECEUqb0j_4fuS3rqeeXA@mail.gmail.com>
In-Reply-To: <CAFhGd8pGikrizmQPF7qD6C4NcYqBVqECEUqb0j_4fuS3rqeeXA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SN7PR11MB6825:EE_
x-ms-office365-filtering-correlation-id: c2a39b0f-6977-4362-e36c-08dbb46bf3da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K2pCVKAvwADffckEwLyrNJUNO80/Bo+UGcvld+8jvg6SEzMr6NaowlWrgpbrwL1mvK7lURruTli2LWnpYGkj6ko/GSnCxlavZyCo2htpjMi6o2zc4gy8NWDoK3mWF5c5tke+C53goahZg1DGhGSTPTELVz/lehRNEb0TCCHGQxHaqEBG+Uh4mcIL+5XDdgfrF5HGsiCuz4czjI3oo1BdwM/9VDMx3cIKW2HsYFRhcfikT98xNJ5Kyc1VOOqdWvnJPi8OwagA8Cmj3UXFuG2My+DZkV+Wpw7gfL8/ZhuAgptFyybJi58d7tCF1hOEw1kvk8x8ATsp17QirvzVMAL1LPdkKId7SYA5cLyOF/PGODBxczJr3P/S8bHdD288UBsxWINWVY9rl4+GKLKFdxgyZLboYjxLRrRHHoAz1uyLphkFm5rVp5rEYEQNZENKKW5/RHdvlPR4m/7IEEyDBhcYZWpQoWhCBUHli7FxJISxA4M8vWHXU4pZ4s9yvHvlePHmyhXEcHbRzkh/as5Vd3Ds1pe0qcnP5mgNBveGK+OHZiFyjmyxBCFomUbUFQfeRAI4pr5/tF95o5iKluosk7vZZ9JPzTapCPcASil0hPlGxKXs4/1HiGEe6KD4IER12dj6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(366004)(136003)(346002)(186009)(1800799009)(451199024)(5660300002)(52536014)(316002)(64756008)(110136005)(66946007)(76116006)(66446008)(66476007)(54906003)(66556008)(4326008)(8676002)(8936002)(41300700001)(9686003)(2906002)(7696005)(26005)(6506007)(38070700005)(122000001)(71200400001)(38100700002)(82960400001)(478600001)(55016003)(86362001)(33656002)(83380400001)(966005)(156123004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXZ1cmdzSlRlN1hTMFhIaWsyang4RjFxNjZWc28yTDgzRXBXdUY0WFRQUHVs?=
 =?utf-8?B?amx3YWxVYTlxNHRza1RhTE05aHRmWUpaaE5LMzZObkR6TEtMUFNnUFdSUlFM?=
 =?utf-8?B?Rnd0cFp4eDRKamxXcHFISlQzdHc1bnVpRHRsaTg5V0hOR3FKcnhKTkpITFlz?=
 =?utf-8?B?N1lEb2VCWUt3MnZReVVubXNBT1h4ak12K1R2d3E1aE5rWFd2QWNIYzNnL3hO?=
 =?utf-8?B?d3NmSTU3VzQyNU01ZHVKOERFZ04rM3ZGSVQ2WWdMRU13a3FoT2VLd003RDhv?=
 =?utf-8?B?ZlZyNzVlOXZhV2FOUkVDcXNLK1JVMXhyY2xldWxDeFhPaVBrQ1ErN3BSQTBW?=
 =?utf-8?B?NFVjWXpxbnVEaW1RVFhkV0doNWw2SVhCYkgvb1hTenZpRGxXcmR4czg2OFgy?=
 =?utf-8?B?Nll1dW8yam9LdkxMT2RHRXBITlcvV212VU52TCtJUEIrY2lSbEJXVm9mWkNl?=
 =?utf-8?B?aWRFV2FMbkRlR0ZYU3BJQUR0TzVza2xBbFRiL3Z0QU8yL2FTZjY2c1oyTzFs?=
 =?utf-8?B?VlJsR0t1T240T29aWDlDam1RV0tka2ljK1lqYXoyYm9JWnlMbVVXUXdsSTVK?=
 =?utf-8?B?UFhLWitVNDBJZGtyTFE2NTgwd3FiNXdQNFZ5WVBkUlBRTlZ6aEtsQk1DQVE5?=
 =?utf-8?B?L0RPRXFRS3FGV0srMnZVNDRkd0tsZE53VDFCbXVRakhCSmtMNzUxS2V3ampt?=
 =?utf-8?B?K21FWXIvZ3pHUDlIeTFObUFBNXFwbmw5elFTbmtjeFh0Z2RrL1BYWDhuQTNL?=
 =?utf-8?B?aWFYZUdVaDAyaGpBRjlkY1orZEM0S2cxTVVGZkhsVm5LTDFtb3RPaWJKNDFC?=
 =?utf-8?B?Ti9LQ3ZvNjAwem12M2R6SWtaNmVOdUNXbFFaN29QSHdZTWs3VWVaRk90R2lJ?=
 =?utf-8?B?YXhCVUI1RmV3WVI3a2hIOTNud3M1OWc1d0locjhrMHJpTVZySEZlaWJQdktv?=
 =?utf-8?B?bEdwRUJPdDZDQjdzNXhPMHNDSWJZbEI3MjRxMFNjQ1dDWXNiOSsvNmRPRlky?=
 =?utf-8?B?MFZTcmFETjVTSlRSajBsNmFrZnc0SFJIYlByc0djcGEyaHphL2ZOZ3FNNHhx?=
 =?utf-8?B?R2NyNWE3bE5zeVhzN0ZBV1h5WFVHMGVpbnRKWlFlMHVhcU9QY1VuL0VPVzND?=
 =?utf-8?B?SHIxMHd5REpNZ1JtL2J5dGN6aXo2djJDdGtCV1NnRzNSemZwM1RhaDFFWHlI?=
 =?utf-8?B?b3dKRzRsdDNwSnFWWlM4RnlkL0VxT3NCT2oyMXFUTGt6dlNZUEJvcG5EcEp1?=
 =?utf-8?B?RVR3SjRTT2dJQy9oQ3h4eTRtWWFoVTE4c0J6cVhrUU0xMm9mR1IyYytKd2Nk?=
 =?utf-8?B?SmhuUTY3S204M3FKUzNMOXA0TFlqUjJ0MVBVU0ZVc1p6cGh6ZUwxT2pjenUv?=
 =?utf-8?B?ajlnL2N0M3RYT05nZ205MmJTaHNNMWNERDRDMnFjY3hTRG9kcnVLT1huR09P?=
 =?utf-8?B?NkVCT0xTL281a3hWWmo2UHZhYVY2V3c5MDZSLzJTVEE2NEZxNlJ0RW1HdnFG?=
 =?utf-8?B?bVhCK0xHQ2JaT0U2TGVzUXc1TERTNWh1YWd2MkZuUE11TVFxamR5emR3bVlp?=
 =?utf-8?B?S2hHcTFRK2J6UExjSlV0emZzTE5qV3NTeG9VUzRGdHFnMkRCdFNmL1U2RTBL?=
 =?utf-8?B?dmROendNQktsaHhaRlpxcUpGaTFXM2dWZXhleE1PeUJTSXJsb3o5MEw4bEZq?=
 =?utf-8?B?OW5kQmpPUDd4R0d0TjMveHZkZHlIQnliT1VYckJkUHp4Q1BnZ2FMRHFPZFdR?=
 =?utf-8?B?QzJnUW1rZDQ0MlhWQWRydnZXY0JGYVVuNlBSSVdwUkFvdXdvL1lXaHl4clRv?=
 =?utf-8?B?TmlhRWkyUEQwZlN5Z2lveWVVUE04eFF6Mk9jUXNUaWxQSlcvZWM1VVc2RnF4?=
 =?utf-8?B?SFFnRjlSRmVYYVNrTVlObGUrOU41L0J2SDlFV0hqMnN3U0dNUXMvd2ZwbTdy?=
 =?utf-8?B?M2VPbm9KOVdXTTh2d1YwcVQxczJ6emhoTk00aCt2b1c5VTdLbTZGc0d6U2RO?=
 =?utf-8?B?ejVOWUdubjR3a2Rzd3B1MTRpbEFBU3VqV1dkMjkyOGlkYTFiZ2IyeURJVi9Z?=
 =?utf-8?B?NERSdVE4dm1OWm5nUEJ2QW9qalcwempjbisxakEydnluTDVmcUk5VFh5aFNN?=
 =?utf-8?Q?HeGBXjIzIDSBkWY45Wv9UTTzh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a39b0f-6977-4362-e36c-08dbb46bf3da
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 15:13:14.8275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5zCZjIz63iyrk5RbcnbIQp7KQKPNYXeVocox3/VN9QhPcLRJLw2iezs6glS7WvRJ6x7o17J96dU0aPzO/iXtyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6825
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBgc3RybmNweWAgaXMgZGVwcmVjYXRlZCBmb3IgdXNlIG9uIE5VTC10ZXJtaW5hdGVkIGRlc3Rp
bmF0aW9uIHN0cmluZ3MgWzFdLg0KPg0KPiBXZSBzaG91bGQgcHJlZmVyIG1vcmUgcm9idXN0IGFu
ZCBsZXNzIGFtYmlndW91cyBzdHJpbmcgaW50ZXJmYWNlcy4NCj4NCj4gQSBzdWl0YWJsZSByZXBs
YWNlbWVudCBpcyBgc3Ryc2NweV9wYWRgIFsyXSBkdWUgdG8gdGhlIGZhY3QgdGhhdCBpdCBndWFy
YW50ZWVzDQo+IE5VTC10ZXJtaW5hdGlvbiBvbiB0aGUgZGVzdGluYXRpb24gYnVmZmVyIHdoaWxz
dCBtYWludGFpbmluZyB0aGUNCj4gTlVMLXBhZGRpbmcgYmVoYXZpb3IgdGhhdCBgc3RybmNweWAg
cHJvdmlkZXMuIFRoaXMgbWF5IG5vdCBiZSBzdHJpY3RseQ0KPiBuZWNlc3NhcnkgYnV0IGFzIEkg
Y291bGRuJ3QgdW5kZXJzdGFuZCB3aGF0IHRoaXMgY29kZSBkb2VzIEkgd2FudGVkIHRvDQo+IGVu
c3VyZSB0aGF0IHRoZSBmdW5jdGlvbmFsaXR5IGlzIHRoZSBzYW1lLg0KPg0KPiBMaW5rOiBodHRw
czovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9wcm9jZXNzL2RlcHJlY2F0ZWQuaHRt
bCNzdHJuY3B5LW9uLW51bC10ZXJtaW5hdGVkLXN0cmluZ3MgWzFdDQo+IExpbms6IGh0dHBzOi8v
bWFucGFnZXMuZGViaWFuLm9yZy90ZXN0aW5nL2xpbnV4LW1hbnVhbC00Ljgvc3Ryc2NweS45LmVu
Lmh0bWwgWzJdDQo+IExpbms6IGh0dHBzOi8vZ2l0aHViLmNvbS9LU1BQL2xpbnV4L2lzc3Vlcy85
MA0KPiBDYzogbGludXgtaGFyZGVuaW5nQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5
OiBKdXN0aW4gU3RpdHQgPGp1c3RpbnN0aXR0QGdvb2dsZS5jb20+DQo+IC0tLQ0KPiBOb3RlOiBi
dWlsZC10ZXN0ZWQgb25seS4NCj4gLS0tDQo+ICBkcml2ZXJzL2VkYWMvZWRhY19tY19zeXNmcy5j
IHwgMyArLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMo
LSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZWRhYy9lZGFjX21jX3N5c2ZzLmMgYi9kcml2
ZXJzL2VkYWMvZWRhY19tY19zeXNmcy5jDQo+IGluZGV4IDE1ZjYzNDUyYTliZS4uYjMwMzMwOWE2
M2NmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2VkYWMvZWRhY19tY19zeXNmcy5jDQo+ICsrKyBi
L2RyaXZlcnMvZWRhYy9lZGFjX21jX3N5c2ZzLmMNCj4gQEAgLTIyOSw4ICsyMjksNyBAQCBzdGF0
aWMgc3NpemVfdCBjaGFubmVsX2RpbW1fbGFiZWxfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LA0K
PiAgICAgICAgIGlmIChjb3B5X2NvdW50ID09IDAgfHwgY29weV9jb3VudCA+PSBzaXplb2YocmFu
ay0+ZGltbS0+bGFiZWwpKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+DQo+
IC0gICAgICAgc3RybmNweShyYW5rLT5kaW1tLT5sYWJlbCwgZGF0YSwgY29weV9jb3VudCk7DQo+
IC0gICAgICAgcmFuay0+ZGltbS0+bGFiZWxbY29weV9jb3VudF0gPSAnXDAnOw0KPiArICAgICAg
IHN0cnNjcHlfcGFkKHJhbmstPmRpbW0tPmxhYmVsLCBkYXRhLCBjb3B5X2NvdW50KTsNCg0KVGhh
dCBkb2MgcGFnZSBzYXlzIHRoZSBwcm9ibGVtIHdpdGggc3RybmNweSgpIGlzIHRoYXQgaXQgZG9l
c24ndCBndWFyYW50ZWUgdG8NCk5VTCB0ZXJtaW5hdGUgdGhlIHRhcmdldCBzdHJpbmcuIEJ1dCB0
aGlzIGNvZGUgaXMgYXdhcmUgb2YgdGhhdCBsaW1pdGF0aW9uIGFuZA0KemFwcyBhICdcMCcgYXQg
dGhlIGVuZCB0byBiZSBzdXJlLg0KDQpTbyB0aGlzIGNvZGUgZG9lc24ndCBzdWZmZXIgZnJvbSB0
aGUgcG90ZW50aWFsIHByb2JsZW1zLg0KDQpJZiBpdCBpcyBnb2luZyB0byBiZSBmaXhlZCwgdGhl
biBzb21lIGZ1cnRoZXIgYW5hbHlzaXMgb2YgdGhlIG9yaWdpbmFsIGNvZGUNCndvdWxkIGJlIHdp
c2UuIEp1c3QgcmVwbGFjaW5nIHdpdGggc3Ryc2NweV9wYWQoKSBtZWFucyB0aGUgY29kZSBwcm9i
YWJseQ0Kc3RpbGwgc3VmZmVycyBmcm9tIHRoZSAibmVlZGxlc3MgcGVyZm9ybWFuY2UgcGVuYWx0
eSIgYWxzbyBtZW50aW9uZWQgaW4NCnRoZSBkZXByZWNhdGlvbiBkb2N1bWVudC4NCg0KLVRvbnkN
Cg0K
