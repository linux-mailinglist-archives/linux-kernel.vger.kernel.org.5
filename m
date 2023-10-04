Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603617B9899
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 01:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240255AbjJDXO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 19:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjJDXO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 19:14:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06935CE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 16:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696461264; x=1727997264;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=l3jgoaqyUSWYqJgHh/gUnvUcC6ZVt5ZNPpUGsMSp5TM=;
  b=gJKQ8F1lhUz6sdMDHpv5ZiENNvsGKUa12EIhHznDmkY+cLLZsm3LzF0S
   t8UtLZhz4EF037p42RUDMXP4wz4VQHfbnxfK4pi0uonZucC8wKiLjRnfR
   P3vD+BGP0PUI8KRV5Jl6kvqQZLGLQ60LUpDIWWmqoMY+KI1I9qJk5R99X
   vaVpCkNCkuy36sK9uE5Fhb32ZsIe7bXbnHiBj03IaDfM4WT1DYIYmy7jT
   g1RjEPbxFV94sfY9SdxfI29A1raPMPvqfpmTTPYuhjdKpyP6diRUJuC8B
   N7Sn5/4ZwYjDcb84E9TQ5z/d+7cHTgNnBpCpWeJJ1euypCU1ZoKvadLZu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="373681756"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="373681756"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 16:14:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="842124629"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="842124629"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2023 16:14:19 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 16:14:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 4 Oct 2023 16:14:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 4 Oct 2023 16:14:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZISwRS4yUyJ+S8w7691Sn28IB77FDOGmsHSB9xq09o8s5Gk1JCGeykhpOpjDRBqXcVZTzStsMNiAldbxTlPB9RlZOjM1DF+mxy3D6TIZD4kpNlkUmP4ZQQ2np3xGRjmO+2vYoIuHr3ZvYAHY0+b0LDfy3edp+n5Nn5KAhvlKUFkWcGiScTF0UqhK1Xn0NNbd9swbioqb0Xslt6SQ9mFnPYo5Q70lRrTNp+hqfIdIEQWp12ksnVFyDA2pJCjYVk/WgKvWPLdzLG0py9m07tGyPdE9aitoU5Vo4kiv//jBiJ+5CycYBwTet6YbkgxRzaS2mwG29Me06rI+i+0glM7CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3jgoaqyUSWYqJgHh/gUnvUcC6ZVt5ZNPpUGsMSp5TM=;
 b=KTkIVH/qbFMiZvIzcIYQ33Mpq1EKcL7S85z4HVU4roBdUujXC3aoNtvb585oE8SDYR+ioURjb6aa3aiBQ8zzZs5Ko6wXFpRDTewgZtvrlnc75o7x4L5PiRBfY00nybCFB33V8OuxwYr216sYzcUtlsc24Kt9c6A14/WPjhQwGPdXPW3smFUkOyIWc/cdeedPnuJppOjeponO59mFczdWliV+3vw16shIks2PIrGF4BI+BeLvRcvZirANqinox+LWH1ER48nMjLurgFk06M3Z/kXR9jDZeVy3+qi5fcKds41jOTZzVTLSkOJqT3tQsDGucyKJ1o5DzbnwNSrv9jqxbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by DM4PR11MB6094.namprd11.prod.outlook.com (2603:10b6:8:ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 4 Oct
 2023 23:14:10 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::1a1e:c953:cc6c:439]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::1a1e:c953:cc6c:439%5]) with mapi id 15.20.6792.020; Wed, 4 Oct 2023
 23:14:10 +0000
From:   "Colberg, Peter" <peter.colberg@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        "lee@kernel.org" <lee@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rix, Tom" <trix@redhat.com>,
        "russell.h.weight@intel.com" <russell.h.weight@intel.com>
CC:     "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH 3/3] mfd: intel-m10-bmc: Change contact for ABI docs
Thread-Topic: [PATCH 3/3] mfd: intel-m10-bmc: Change contact for ABI docs
Thread-Index: AQHZ8iuEUroGGuJgHkKPBVNcSxabrLA6TJoA
Date:   Wed, 4 Oct 2023 23:14:10 +0000
Message-ID: <658350c27c042e570fdddb21396b859484a47f17.camel@intel.com>
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
x-ms-office365-filtering-correlation-id: e99ea16f-a0fb-4f13-ccc5-08dbc52f9d91
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9YtwIggMQG/zhn1ycQjuk1/uKAE3HFgoZPtjRovKNUHLisKBZ0yBXYO3QehM3kcUBxZthW+BlJmo/rxo62mJO2SNqyknC2dZm705KZhOKNO8s5ohb9XRH6SXbkCT1C+/Nh2awSGXXVoDDb0q6z5AXMEuRtXzYMLdl/D74s2MaLrZCYOuWlMQKVhm6bP+Sko1g2SKm+qy2jELfngImoQZiY3s/3cmsGKkeAoVYaCyLHhv8RpqZAPHleF5TvdVTUiIwJthbjlgilAcnmZfVJ6GMQ9GY09DGGOZIfCdr3oj3ffw+/9p/fb8/Yyu179wNJHFnEYe8HooUXihVWRUkxT8fONv+lwRTQaiMZvbt+YhiKKlxIpjM/ksCc8eM52+6uF05C+73w8AI7UzBIiSxZJ7wFWSXx7DSSUJSJsBEviMJtDuopSbtX60AhF3BygLSByOFDnQJbTnm5ZDesRgUfbpPPosn2kbLUuKjnRMwIeEZMiaSGzd30Lxl3ds+dGl/JR6d0ONNd40rTO4KLPAykeQGesY8fUS1bheniWX9Zx8D8poVv4EviwVDMdADK6neRjSXzAJYcO4RE37f5wFoYuD2tO24CkSG3jtTrMjr/velt9Ni392VHro+NAWdPL39zOc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(86362001)(8676002)(5660300002)(8936002)(4326008)(2906002)(478600001)(26005)(36756003)(82960400001)(122000001)(6512007)(2616005)(38100700002)(38070700005)(83380400001)(6486002)(6506007)(71200400001)(316002)(6636002)(110136005)(91956017)(66946007)(76116006)(41300700001)(66556008)(66476007)(66446008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akFSWUNCcGx5ZFg2NnZ6aXZER3NOK25pRW50YUFFTXRORTVWSFdIRmxlYnRH?=
 =?utf-8?B?bU1Wai8rTStKeDV5aXlndEk5Vm1DSnR3VjJncmp2NnA1OUhsMy9ldWNMcU93?=
 =?utf-8?B?d2NsOWxRa1l1eDd1bnlvRkxZSUFBbWF3Rkc3NkxLcEJQN1BDMU5zMkNmdUFz?=
 =?utf-8?B?ZlZJL0licXFRTjFWZ09OSkhDbEI2T2VZOUlCQWJpenFWdU51aWNLTzk2OGd5?=
 =?utf-8?B?UHI3RHlIc1lyMXZCdjc2TENtendBamRBTkdwT2lPTmpSeFNHS3h6QUNqR3JS?=
 =?utf-8?B?eHJocXpMcGRpOXpxTEtyZUg2aDZHN1NYTUFSSndoOWxITHhhVDFYRkxMRXVL?=
 =?utf-8?B?K2FiUG9jTmN2Rzdwc2xaZUpFM0wyTVVCWFU0QzhxUUtFMElBOTc4TVM3QWlI?=
 =?utf-8?B?VjhXRGx6dDJCNkNOVkRNa1FmUml4UHdFOEFkSE1XakZxeVpnMytsQ0dLcGdU?=
 =?utf-8?B?WHllcisrMXVlcFFBUjF3Y1FRRkFWN3V0UHlTVloyL1NpWEF5aTFjNUFkUklv?=
 =?utf-8?B?UDMxMHhGNlYzRTc4WkJFdXdSNVVVd1F3TG9NVDdrNnk0S09CeEM3RSsrTlZB?=
 =?utf-8?B?WDhMckI0TkJzOUkyQ2JzdVZnbUcvNUtiWlRWVkx5aGlnR3YwY3JFRnRXdGVu?=
 =?utf-8?B?aDdzbWFweEw3RGw3ZWtCbnR2UDFsQjJSOEViZUtZdFlyNjZhSDg5QW84NlZ5?=
 =?utf-8?B?cTRva1RsQWgrWVVrREJ3L1hiUTRDUU1BeCs0VnRrTFNMK056WS92NC80Yzc5?=
 =?utf-8?B?RmtZMm5GQmtLM2kxZVJmckM2dmJ2RGZ4Y00yemo3MlFiVjZZdHZjbnN0YnRG?=
 =?utf-8?B?TFhnY0pxUHppMzhMaVRtSUxYWnpjVC9vcGR3eWgwZHp6SlZqWXc0MVFYRUhB?=
 =?utf-8?B?UWZ5Z1o5RTRtZHR6UjYwdEpydkdIQmRUdm9ZdmlhYnh2MTl3a3VxQlIvYUN0?=
 =?utf-8?B?QnVsYUNGWDBFUDJCYlk2TjlkbkNuREc2cHVhYWMrcXUyenBkcFQ4S0gzOUVT?=
 =?utf-8?B?Y3owbkRHK0ZEVmRhc0dqUG43cE9veVVSMzc0ODBSYkE2TjBYUHZVV08rMzFy?=
 =?utf-8?B?T3UrNENlRURLRVJsS3J1bU0yOFNHSFduT0xseUVMbFpZMUxGeEp4SnJOeER3?=
 =?utf-8?B?UGMzazhLZnNENVpmZzFpYm5UeDNIcDd2eDhFVXR3aXdmbHhNR08wQ09qM1Iy?=
 =?utf-8?B?RlpyVHBjNmtBOUdTMWpNMGoySHBJZ1J0ZmJueU15VGVRc3hOUEpLdUNRZHM1?=
 =?utf-8?B?Z0l5dnhKWHpueWRTUlFmdHdOOVd2Qk9iUDZrM1BqdEdoMU1JeGc3cEZ2TEVQ?=
 =?utf-8?B?Q0FPUzRBSytORWFvOEdweGtzYmkwRUxLWW1KSDRJVHdiWmp4WFJ5b1ErOE4w?=
 =?utf-8?B?N251TFZnYkV6M0hwT2MrT3BISUVZVVNDQ1hqYVJKUENMc3ZXUjQrN29YQ3Fr?=
 =?utf-8?B?bXNXS1hEQ0dNWXB2SVZuVTlMUG1TTzZTMTR0SnF2azNFSTlPRGxsaFF5c3Ji?=
 =?utf-8?B?VksyTnZ2VEJnY213cHBHdmVrbG1XTmZmVnRUT0t6Y0pwbWM3R1hHV1A3TTh3?=
 =?utf-8?B?anp4S1Vocm5MV2h5SURGMkpZUUVTa3FvSUxQaERHL25COHo1WGJhNk9zMDgr?=
 =?utf-8?B?cnNRN3JrWVhZdEJsRzRjWUt5TDN5SlY3cTU4aE56U243THI5N0M3cVBQOExk?=
 =?utf-8?B?bFlrZ2dlUnJzbExWdnZVbUs4Q0xPR2toNEk1U1cwRWhoRXI0VzI2TS9DOFNx?=
 =?utf-8?B?MzB2Z3J6NGs2cmtJMTRoK2h1SXFoekpQdGZHbXNpdllkcTNiQ1VjL1VMK1dt?=
 =?utf-8?B?T2JzelhLYjdkaS8wVm5ZRUo2dnU4SFlUQWVYQ1RnTFZIMXBoQkZWUVlVL2do?=
 =?utf-8?B?UnA5SkJCVmEra2xLTlZuejFNM2FhajBBRjZjeTExcTZZelduUjg5N3JQL0Fp?=
 =?utf-8?B?V044SWxYMndoSjcwQ3R1ZlM3NlgycmRmZ085a3d2aXRUUDRVKzU4OE1WcUN2?=
 =?utf-8?B?UGRta2xaQ1hLMVRsS1gwQkhvK2lTWDI0SGRxQU5ncVFGTFloZnJkbTIyRTdm?=
 =?utf-8?B?ZkFFNGM4N1JIbGhCZUdjbHVwQkNRaFAxams3RUlaZGhNT05TVkRtVGsxVC94?=
 =?utf-8?B?WE96TzNNdHMyQllWaFRWSGFzU1pLUXRNb3hQSENNRHFrdkc3UlhuakUwdmRE?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A83C27C94D98E44B1E6E090B0433340@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e99ea16f-a0fb-4f13-ccc5-08dbc52f9d91
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 23:14:10.0533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eJsITUjHm2pOYymusN/wzKf9y6G7jD6JD2lPO+DJyXQkms/WPHLkI1FDJhpRVd1iCD7ju9n8btanWHZe6RCcsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6094
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
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
aHQgPHJ1c3NlbGwuaC53ZWlnaHRAaW50ZWwuY29tPg0KDQpTaWduZWQtb2ZmLWJ5OiBQZXRlciBD
b2xiZXJnIDxwZXRlci5jb2xiZXJnQGludGVsLmNvbT4NCg0KPiAtLS0NCj4gIERvY3VtZW50YXRp
b24vQUJJL3Rlc3Rpbmcvc3lzZnMtZHJpdmVyLWludGVsLW0xMC1ibWMgfCA0ICsrLS0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1kcml2ZXItaW50ZWwtbTEw
LWJtYyBiL0RvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtZHJpdmVyLWludGVsLW0xMC1i
bWMNCj4gaW5kZXggYThhYjU4MDM1Yzk1Li5jMTIzMTZkZmQ5NzMgMTAwNjQ0DQo+IC0tLSBhL0Rv
Y3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtZHJpdmVyLWludGVsLW0xMC1ibWMNCj4gKysr
IGIvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1kcml2ZXItaW50ZWwtbTEwLWJtYw0K
PiBAQCAtMTcsNyArMTcsNyBAQCBEZXNjcmlwdGlvbjoJUmVhZCBvbmx5LiBSZXR1cm5zIHRoZSBm
aXJtd2FyZSB2ZXJzaW9uIG9mIEludGVsIE1BWDEwDQo+ICBXaGF0OgkJL3N5cy9idXMvLi4uL2Ry
aXZlcnMvaW50ZWwtbTEwLWJtYy8uLi4vbWFjX2FkZHJlc3MNCj4gIERhdGU6CQlKYW51YXJ5IDIw
MjENCj4gIEtlcm5lbFZlcnNpb246ICA1LjEyDQo+IC1Db250YWN0OglSdXNzIFdlaWdodCA8cnVz
c2VsbC5oLndlaWdodEBpbnRlbC5jb20+DQo+ICtDb250YWN0OglQZXRlciBDb2xiZXJnIDxwZXRl
ci5jb2xiZXJnQGludGVsLmNvbT4NCj4gIERlc2NyaXB0aW9uOglSZWFkIG9ubHkuIFJldHVybnMg
dGhlIGZpcnN0IE1BQyBhZGRyZXNzIGluIGEgYmxvY2sNCj4gIAkJb2Ygc2VxdWVudGlhbCBNQUMg
YWRkcmVzc2VzIGFzc2lnbmVkIHRvIHRoZSBib2FyZA0KPiAgCQl0aGF0IGlzIG1hbmFnZWQgYnkg
dGhlIEludGVsIE1BWDEwIEJNQy4gSXQgaXMgc3RvcmVkIGluDQo+IEBAIC0yOCw3ICsyOCw3IEBA
IERlc2NyaXB0aW9uOglSZWFkIG9ubHkuIFJldHVybnMgdGhlIGZpcnN0IE1BQyBhZGRyZXNzIGlu
IGEgYmxvY2sNCj4gIFdoYXQ6CQkvc3lzL2J1cy8uLi4vZHJpdmVycy9pbnRlbC1tMTAtYm1jLy4u
Li9tYWNfY291bnQNCj4gIERhdGU6CQlKYW51YXJ5IDIwMjENCj4gIEtlcm5lbFZlcnNpb246ICA1
LjEyDQo+IC1Db250YWN0OglSdXNzIFdlaWdodCA8cnVzc2VsbC5oLndlaWdodEBpbnRlbC5jb20+
DQo+ICtDb250YWN0OglQZXRlciBDb2xiZXJnIDxwZXRlci5jb2xiZXJnQGludGVsLmNvbT4NCj4g
IERlc2NyaXB0aW9uOglSZWFkIG9ubHkuIFJldHVybnMgdGhlIG51bWJlciBvZiBzZXF1ZW50aWFs
IE1BQw0KPiAgCQlhZGRyZXNzZXMgYXNzaWduZWQgdG8gdGhlIGJvYXJkIG1hbmFnZWQgYnkgdGhl
IEludGVsDQo+ICAJCU1BWDEwIEJNQy4gVGhpcyB2YWx1ZSBpcyBzdG9yZWQgaW4gRkxBU0ggYW5k
IGlzIG1pcnJvcmVkDQoNCg==
