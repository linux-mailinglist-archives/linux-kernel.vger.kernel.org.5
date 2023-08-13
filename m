Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A1B77A775
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjHMP2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjHMP2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:28:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07851BD5;
        Sun, 13 Aug 2023 08:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691940464; x=1723476464;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m4jWBsy84dU6PpFNmwMovZAUhi8Ox2Bcy3wlBZCZ6YU=;
  b=davGhaN7+DjlD0G9IiMKEkiwEzU9+fjOhTq+R9W5UXJDb5d3qjSgHo54
   jLBPyHPL1qBdyFHP9ljQXO+Lohj8As0t3cJCkMZYRI/PAx8wStkIl/FmD
   vG7wjjsbnidB8RUS9TMHNSw7NYWZ+D11FGXSHigjk/5Y3DJ48VkuA3MLw
   OVTGJvGbrdOrVw7BI+4L+3F0jEVJeDIuiw6u+cnNMMMNTuohhH842BGOO
   o8gmHH83FgIH2JZHaUlsDgLj5wGkKvWIpJIIgFpj+GXogiX/Ae5HhI/VD
   //TH8fOZq65WULSm/Amn2iBAIngY1uO+rwOs8f7w86e2ID760fV6e+wGS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="369376760"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="369376760"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2023 08:27:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="856813556"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="856813556"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 13 Aug 2023 08:27:40 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 13 Aug 2023 08:27:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 13 Aug 2023 08:27:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 13 Aug 2023 08:27:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arUPeQ9D+wwFTLcXOKlT5dQF7eQ3Acxm0PXIA6mx1SinU7YsAy/GXOJ2rr9NRpONrQAts4peAM6RTMQpgH2YKaG+o9WAvNAEuVjN7EOMHUB1VVoh6ic3/CkwvSLyYu0smaKIzFYFJpIamU0fvtMhjv1FdytDSrbjU/Yy8FrTZRn8wlZcYx5pkVDGxzRAMkOwEcat549oj1zWkKYtjLy/HQD3mDZjIfS3IccKrig9efj4IxdRHShlLwyJD5fYvfvzfJm6UEOWbj8dCaF6/0XlbkuKGWGqCmzUpamwzuVR8bBpyBkQxlreVOwekyhjS+gPORqc+H9zROHHnH04WkeJeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4jWBsy84dU6PpFNmwMovZAUhi8Ox2Bcy3wlBZCZ6YU=;
 b=l6L4bVEiJPDHmQ1pteZrktA+WBlJ35cIhbGh/0Ee5qt7ZY9RsZGZcKdYLLgiGJO+JoSAtc/A0keiw2K7s+3oOFVqz2ORXm4tGE0iZJntVYXT7jJ8VWR6c2tPLqv5Ye9++d+hITmFLPG5Hvc4glcY1ChhRjjgWWpJohwIP+5DL829qkd7oLIIVmybl83fY2vhPS4C1yNftkvELQnobeg5+8w/JH7O8LlaaPoZr0LOEIPKzhUY0ERu2vnWg2PSa9HUmhRBQ4NDFPmb6nrmG6293i4ldiuDBuIPO7uOSKc0/fjiZNB3A8hMXMpSmSUJsbgzvrArW/qv6ftrhYkF20r8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by DM4PR11MB6285.namprd11.prod.outlook.com (2603:10b6:8:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Sun, 13 Aug
 2023 15:27:38 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::c733:b6c6:fe0d:d4c4]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::c733:b6c6:fe0d:d4c4%7]) with mapi id 15.20.6678.022; Sun, 13 Aug 2023
 15:27:38 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "duminjie@vivo.com" <duminjie@vivo.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: Re: [PATCH v1] drivers/net: intel: iwlwifi: fix two parameters check
 in iwl_mei_dbgfs_register()
Thread-Topic: [PATCH v1] drivers/net: intel: iwlwifi: fix two parameters check
 in iwl_mei_dbgfs_register()
Thread-Index: AQHZtMLRVoJ87y2jl0aO71GWgfE8CK/oi9oA
Date:   Sun, 13 Aug 2023 15:27:38 +0000
Message-ID: <7860d8cbac1eb699de033210c8256afaa8f7b35b.camel@intel.com>
References: <20230712131407.16462-1-duminjie@vivo.com>
In-Reply-To: <20230712131407.16462-1-duminjie@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|DM4PR11MB6285:EE_
x-ms-office365-filtering-correlation-id: e61a2064-56a7-476f-6ffc-08db9c11d394
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PGby3HbjNBi2WSep8KsmJyqUIRnWbJjwgMImDeqliyVlDxcb3SppHJYAeRplNI2xgBcA7Prog285hWAGzRmnuZESFUkO6s+fk9j4bMstJDIZPpFsG6WQXM2zzCpT80M8avq72unBRLQldJzK5k1Pdw0m+GJr7/0jvNfm30fROG+yfUPphnhbvMaEL+vZormbhsx5GIm61fdHzASkbkOpr38zXzLke45ELlNrQ8HKRXpbq+iMjJujXgqapZnjEDDM89E4nl0VjBcIvEl4c6KZ7VYToI7LdmSSNoM1j0T+a9PKaSKFJcIG2eEdBXhb6Q4typ5bXGYbPFXGND6c94UQ3D/dK8yb2DykjC6b8daelqyrJ0uOZdkBvKwxWUhAOlzUX8ax6/hukPXp69IthBkZQCSRlnbvJjokH6x8OybuAI73YSNnfRMkFFhZW6kdo/2hpIswjOmh0QXIZDsphZwA64yn95GA4DG7sSNE6SkNXqKMMFYwrdCeKxnU0PxGMFqP45FteEtxDAM1Q2nYavveTZZ9QHm0rI0iCpVIqDhcEBrnkiArsQ3okJJfLl2q6Mdzj1U0zkTIAqyt1GBy5R3YPfwa0V8jFM3z6yocCxX/acNPBxd7j0dNpFGY2cBlMv5P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(136003)(396003)(366004)(1800799006)(186006)(451199021)(71200400001)(6506007)(6486002)(6512007)(478600001)(83380400001)(2616005)(26005)(2906002)(4744005)(64756008)(41300700001)(66556008)(66446008)(316002)(110136005)(66946007)(76116006)(91956017)(66476007)(5660300002)(4326008)(8936002)(8676002)(86362001)(38070700005)(38100700002)(36756003)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzA5WGtjMXBRU1ZJdGFKbXdpL29mUEdPYTB1RmZTMG93VzIrYTlTUHJWM002?=
 =?utf-8?B?UUNCZGhlM1l1L1FQakoybjJRVE0yVnZabnFmMnV4VFFSM0tXRnkyOEQ4d1hx?=
 =?utf-8?B?NWc1dGtsS1Mvd0tUS04rUE9sU05WUU9PM0Y2Z3ZiVFJ0NTBpTWJtdUFUb3M1?=
 =?utf-8?B?VEd6a3VENmVtb2U4R3UrTEhLUWVudHplWXVTblpHUWpjWHdVd1pQTHhwN2ZH?=
 =?utf-8?B?OHVtdFhjTHBRUnFwdExFR2ZQbjRsVFVjYkFFQm1PQWpvc3ROeWorTXAxV3FD?=
 =?utf-8?B?eHFsL2xPd0NqT25uSWZiTXo3SUlkc2QzKy9GanBHMk5ZekpJV2pORWhmVEJk?=
 =?utf-8?B?MHkrUWx3aTVSSWZqZGJFa0hTMUtqZkcvMEp4Wk11cnV4NEJscmhzdFphb2pK?=
 =?utf-8?B?b21TSjdhMW5vb3gzZjd2ZTc0dnNDY0NnZzFvek5CQXQxd0RLOEhwYVNXTzdW?=
 =?utf-8?B?eGtjVVFENDZjVDE2MThqYTJvekVDUURHUjFCWEo5ZUI2dWFQQ1Q2LzQyeGhy?=
 =?utf-8?B?SFhuVEVBQWt6SzByUTFIOHl3cFJIdGRHU1dZNlpIMWRaY3A1UFBQQnZvWkR1?=
 =?utf-8?B?dzBRc3o4WEdlN21vRStLVlFvL2o4Z3ptUlFsQWxwUVIxbVhJT29leVU4VlNo?=
 =?utf-8?B?WXBEMmRrWXZmcjN3TGNjUXdZenhkNkJJTExtNFhoSnFlTmtJWTB1UjRtUHdn?=
 =?utf-8?B?bTBhakVWZ3AvOXJLUVFYUy9Vays5QWphYWRGVkR6aUk4enV1ZjhUT25SRXFX?=
 =?utf-8?B?SkdsTXdmYmM4VGdwaDFkR1FCV0xPczZQTUpGR0gzckxCMUNZQituTTB1T3oz?=
 =?utf-8?B?QmgyRFVoTGR1V2tXcUNNeVdvY3NBcWtYdzcyZVpTSEdieWtTQ1hjM2djaXl0?=
 =?utf-8?B?Mk5yaEZ6SGtUb1BSR3Bkb0w0N1JWQ3BLMjFKZEpnQXpROGppTTJiZVZtNk4y?=
 =?utf-8?B?Tm95QUVCakJLMUFSR0lCNWJvVjF6UWlXckN0TlBpSDhkdDlDeExhOHlXaW9V?=
 =?utf-8?B?WnlabVVpbEVpRkxXVjc3T1cybEZ6MzdKaEpGM29va0NYcEdRNitGKzJtbC83?=
 =?utf-8?B?WXljM0UxaDdnK2U5ZXRRWEwvcVBSbE96ejhnT3IzMllpZ0JIYm5yYWVyR3d3?=
 =?utf-8?B?K2ZHdzQxS1BKd01Ud0RZZGhWZUZLS0NCemJoSDdwMlArb3FCNHdZbW0yVzhX?=
 =?utf-8?B?Y0dJZlhOTmdvUWxKQkZ4S0d2bTZwUXlDRnZLVTAxd1ZIb1ZyRjVlRFVqK3dQ?=
 =?utf-8?B?UlBoVUJPZ3pRdDY4WXQzNHN3bUFiWG9LS0NrU3ZsN0hpa0dWZ1lIUk9HcmxT?=
 =?utf-8?B?VExYdjRSa3hTc29YUnJuSWd6bkVWcEMwRHV2NVZCbmtWOXowZGdkeFZncExy?=
 =?utf-8?B?cTNKcjB4OUdTWDYxQnVIcHdqVjhVRVZWM1dhVmtPeVBtbHlETlhpRERZaG1U?=
 =?utf-8?B?K29hR1FhQml5UVpNZG15alpWUStqQkE2WFRZcThZUjZuSmRERlBCRXpGUlh4?=
 =?utf-8?B?NW5qb0tmS3huTmRiZmxCYVNra2xZTmVianZpbURXT1QweGhNNnVBUk1Vdk5s?=
 =?utf-8?B?b2ViNTN2OTJKazNQS1NUU285b2ExM2VaYnlVbFRzMVdFVE1mZUJKSjZUaVMy?=
 =?utf-8?B?eFZSanQvTHlPWHRSQk1zMnBjSWV1SzhZRGpDeW1IalduNFd0TVBTZkZCYXFP?=
 =?utf-8?B?MEJhWXNwUzI0MjdUOEx3MDZSOElhWFNQa0dQazVMdm03a0xGdEt5Y0ZzcXdU?=
 =?utf-8?B?TElHOW9YdUQ3ZFB0dGtCVGtsYXg3MGhGYU9iZDZOWFRMaEtGaVJ0VFVFVkhV?=
 =?utf-8?B?UnlNV2UzRHN5RUxxc1BDSXpnNmc0UE1qT1MyeHlpMG5RV2QyWXhIZmxVa0tY?=
 =?utf-8?B?NXdWNFZibms1NHg4eHJWOElXR01ESVNRajJGeHdRcVg4VVFpdGF6cm45eURQ?=
 =?utf-8?B?aE40MUVuaDJkbjhhdzlOVmZhN0NZSVIzZHh6SUZ5YnM3Um03b2VZOEI2ekxz?=
 =?utf-8?B?bk5iQUVNRC9FQjY3OXBvNjV2RGNlU00vZnpMUkN5SFEzbDQ2NU93a084MklD?=
 =?utf-8?B?NXNwQ0h6SlRwYkpXNGlGSHVzMTNtaE1rbkpZNWYyNUpiWEdBZDloYmdxdnFP?=
 =?utf-8?B?Vm5FOFZURFBTTkhEWWFKelk3a0ZHMWcvVGZGUDIzL1lBazc3UWJFQlluWlpF?=
 =?utf-8?Q?+Zjy7+xsJdcEA4MonUu4hx0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6C8FC0582643B4EB7C92ADF4E68A6FD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e61a2064-56a7-476f-6ffc-08db9c11d394
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2023 15:27:38.0949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DscFFd6BaRaxD+K6ghHwU7JXX/q4AH1xYgroi4LRW+pY/doDdE8BcPZbvhhNS4CWWqq36eMWL93ljk9N25Bz1YdP65oPn8DweT2FMTC7/Ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6285
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

SGksDQoNCk9uIFdlZCwgMjAyMy0wNy0xMiBhdCAyMToxNCArMDgwMCwgTWluamllIER1IHdyb3Rl
Og0KPiBNYWtlIElTX0VSUigpIGp1ZGdlIHRoZSBkZWJ1Z2ZzX2NyZWF0ZV9kaXIoKSBmdW5jdGlv
biByZXR1cm4NCj4gaW4gaXdsX21laV9kYmdmc19yZWdpc3RlcigpLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogTWluamllIER1IDxkdW1pbmppZUB2aXZvLmNvbT4NCj4gLS0tDQo+IMKgZHJpdmVycy9u
ZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tZWkvbWFpbi5jIHwgMiArLQ0KPiDCoDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWVpL21haW4uYyBiL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWVpL21haW4uYw0KPiBpbmRleCA1NDQ0NWYzOWYu
LmU1ZDIwM2E2MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9tZWkvbWFpbi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvbWVpL21haW4uYw0KPiBAQCAtMTg4OCw3ICsxODg4LDcgQEAgc3RhdGljIHZvaWQgaXdsX21l
aV9kYmdmc19yZWdpc3RlcihzdHJ1Y3QgaXdsX21laSAqbWVpKQ0KPiDCoHsNCj4gwqDCoMKgwqDC
oMKgwqDCoG1laS0+ZGJnZnNfZGlyID0gZGVidWdmc19jcmVhdGVfZGlyKEtCVUlMRF9NT0ROQU1F
LCBOVUxMKTsNCj4gwqANCj4gLcKgwqDCoMKgwqDCoMKgaWYgKCFtZWktPmRiZ2ZzX2RpcikNCj4g
K8KgwqDCoMKgwqDCoMKgaWYgKElTX0VSUihtZWktPmRiZ2ZzX2RpcikpDQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuOw0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgZGVi
dWdmc19jcmVhdGVfdWxvbmcoInN0YXR1cyIsIFNfSVJVU1IsDQoNClRoZSB0aXRsZSBzaG91bGQg
YmU6DQoNCndpZmk6IGl3bHdpZmk6IG1laTogLi4uDQoNCkFsc28sIHdoeSB0d28gcGFyYW1ldGVy
cz8gSXQgb25seSBmaXhlcyBkYmdmc19kaXI/DQo=
