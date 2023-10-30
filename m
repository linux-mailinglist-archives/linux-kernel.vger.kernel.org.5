Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37B67DBF50
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 18:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjJ3Rqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 13:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjJ3Rqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 13:46:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140C3C2;
        Mon, 30 Oct 2023 10:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698688007; x=1730224007;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aYmuyXpEaCxQWwtbQeRsVBp++wJ7zLlwPlZwj58zzEY=;
  b=UcalgvBHuhr3Nvbc2AfGT3WCoamyPtokTDonr0TwnFvDIsZyVv2e/kn9
   qvwmNZD348pq0j/RKI7BYnuyCXeEbz9mXWQk+6517V8x0AM4EaVz640wJ
   ZoNdaC1Yb84NkYUNRzK1ohC0XfVmcDpuJ6Zrq9iDqzOEanK7h9wBEZrvF
   HTF1S1r+BSHGxrFrWmvsQJ8ZCm806jNDSgDumr7a52PmCrMx3R1YOMhf/
   as24bnqBQ3IN2hSZe6sY4i3ciXUn0NXY7RqJ4Kg20ox8WopbQnCBTFfY0
   KyGsXON6EthIzKnFxt1C6lbOgc2u8c9S3n6xJzhSOCnRI30nLTWAtKR7s
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="387949151"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="387949151"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 10:46:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="1007495580"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="1007495580"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 10:46:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 10:46:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 10:46:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 10:46:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 10:46:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRnf+mELcEirm9MJJ8bnbukPTuTePPjctvF2i1u9d7F+T32h66yKTi6dcrwvuw29GLboHTah5TQYcLD5dLrP6FJlRYBMYzsh1KuJjSWFArRMtQtRCeZyScu8fxobjJuH8gjuFY1ud6wfi+Z+OW7MbOngqmtgkHcNYd3vKNSuWMCWOJruIO7mRzydPsKh4UVC0OOMOnOICwOZoTqhU5XEDCc9IDkQKtBYLD20gLvMmu/YIs/fQNGileSPbZxewiL0jKpj3Qn7AF7ypHzCammCnGOwIGX9zz7MKOJKifFJb2Cd/LGMQxu9zPvoIiSY4GNBnwYz8ysd2lfqu2rhKGUnFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYmuyXpEaCxQWwtbQeRsVBp++wJ7zLlwPlZwj58zzEY=;
 b=LUBoMw7mpj87kXay5X/KVU+GJE5tSqzrkiN+1B1MJ9c7ZSiLs94TpCaQnPPSl7bBDu0uyDTwdoXwkCjA2o+7fmuiouYaoJ0fx+Pob5SmiQ24hc0YkVzsXHFmcBSMbFm+Dor14gNl7YynMlSolo8OlUIT4FYNHH/YEU8/ldsRdaxt9sIZlSywCDY5+KFi2g0DfX6GnD6mH8Qtl26YnOysn1We1/fIjyDjf+T3NzM19oj+HeHUVNw/UwGixlX625+1MAGJS9/y/K1tkv0tPxGGOGTr9yja1Bv62GEUqIdQzLX56M/CKVa15sdAmi+ihR4WTe7fscvN0Scd16WEQH+8CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by IA0PR11MB7212.namprd11.prod.outlook.com (2603:10b6:208:43e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 17:46:23 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::a9f1:be46:395c:a936]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::a9f1:be46:395c:a936%3]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 17:46:23 +0000
From:   "Wang, Weilin" <weilin.wang@intel.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        "Rogers, Ian" <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>
CC:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Taylor, Perry" <perry.taylor@intel.com>,
        "Alt, Samantha" <samantha.alt@intel.com>,
        "Biggers, Caleb" <caleb.biggers@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Yang Jihong <yangjihong1@huawei.com>
Subject: RE: [RFC PATCH v2 07/17] perf stat: Add functions to set counter
 bitmaps for hardware-grouping method
Thread-Topic: [RFC PATCH v2 07/17] perf stat: Add functions to set counter
 bitmaps for hardware-grouping method
Thread-Index: AQHZ/kEXcZuzN8b8Pky4a9KPcmPP47Bij/SAgAAkHwA=
Date:   Mon, 30 Oct 2023 17:46:23 +0000
Message-ID: <CO6PR11MB56357BB9FFED934E2ED52E36EEA1A@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20231014015202.1175377-1-weilin.wang@intel.com>
 <20231014015202.1175377-8-weilin.wang@intel.com>
 <ba847510-bdc4-4298-8d9c-10933023e712@linux.intel.com>
In-Reply-To: <ba847510-bdc4-4298-8d9c-10933023e712@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|IA0PR11MB7212:EE_
x-ms-office365-filtering-correlation-id: 0834e27d-551d-457b-6a50-08dbd9702251
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zhz+tUzJ8bHxBuFEvBkOow7vvId47ezjgtaG8WxmKp/FJs9eAT911fmxTtbsS0+Rbe8mpuAsR4FIv7U7v8L5imMWMsZ0Zny4mFDmkGBlRk6SWEpiVt9LqEfl2l044/M59PixU7oM0CvZxXTQnKlx3XYCV7vDZrpA9X8OuHwvYDx2ao7WgIcjzzN18SRUB7RNQ6XBtUtFN5eHhBM5leMYMLQ7F94+0f4tIuIM5tL3Ss92MjZ8rn3HgRe45gASMEeUVlvnbKTJ/b8U1/6rPoTz3H83O5KCDx7S/mIYTvp1SyitcLI1wD0T0TIujby0y37RuKojPfjWAq7Z7RxDijbwNmcGtlnMecLMWxNU9OJolLzMclHFIfEskOFyOqtIARz4ofSzYRazO64wSgSqRPYuFB/rVXmfUobGBdFdAyGSisibmcPHbzAjI8HSOGMEB3zaEMplpVk9OmlRCOQXNh/oaw6bn0w7jzRN72HgDs8BYeJicgiv9FhCf9vv+Wa1KiRpUHBWZGlDgnroTmd2c5iz1QZH+iEf1Ha/NOvNadhZP5MbQ5XudWHQCAEkV6CI5YaU0jWL7Kf70NV7hacneQXAs7Pf6VTjfXdXfPFldcnoFm0EWI+uazyLAfOS/biy4Dji3Fpn7NWwunIdIM/+JB7KBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38070700009)(921008)(9686003)(26005)(55016003)(38100700002)(33656002)(86362001)(122000001)(82960400001)(7416002)(4001150100001)(83380400001)(2906002)(478600001)(6506007)(7696005)(53546011)(71200400001)(8936002)(66446008)(52536014)(8676002)(66476007)(64756008)(54906003)(316002)(6636002)(5660300002)(4326008)(41300700001)(76116006)(110136005)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDBBR1Y0aXJteGxxM2N2eEJuWExxb2N6VkQ1UDYzdk4zektGcHFsbGZxSGZt?=
 =?utf-8?B?RWZqdzMwVlBQenE0eEl4WGhxZ3pJaDlGN0lPbnk5VlB6VjgyTzRHV3NjaGZS?=
 =?utf-8?B?Rm8yV01oUkRBeE9mOVVNWEw2TE1hekMwY2NldXcvYjFLYWZodVV3ZGRLT0NN?=
 =?utf-8?B?QndrU0R5amIrNVJ4S1FHMDE5U2lqQWZ2bm8vTko0elNiVzI0MndKeW5TeXRx?=
 =?utf-8?B?KzFCZTVtTkY0UzV5VCtCWHV6QXpvZ0RHMFJwUXZRUnd0VHplbjBLSnp0b3lV?=
 =?utf-8?B?d24rbzEwVnFqL0ZPb3IyTFRCT3Q4ampFTGorRmlvbmF0VjFESVkraEpHMktS?=
 =?utf-8?B?OG1sZFRrSkVPT01iNEZFRkw4WDF0OWxpaGhKbDE4RGxwRlJzMjhEL3pPemx0?=
 =?utf-8?B?NVFuQ1dKL29PL2xMSUF3SmVqamVaWGJQbGFCL29lYnltTUtua0xyWEY3MjJt?=
 =?utf-8?B?Z3k4cDJxY3NkMkJNVzlyOEFlTVBpM0s0T0ljYUdYc1NWWHl6aDhONHNzNU5F?=
 =?utf-8?B?cDZab0NJNjBXc0RnVlUydklwOUlKaUVXTzQzeTYzZnY1U2h0RGtvL2VKR1pu?=
 =?utf-8?B?YVN5NnVIcDFDcGlYUkJmcFQxcXplVVV2dVBaVjE0a3FnNEk0S1NGQk9oK08x?=
 =?utf-8?B?VTlKQWRHbncveTh2REFUaVI2cVlTTzRhcEU5UURnb0hxbW9CR3BQb0FWSVB2?=
 =?utf-8?B?aUlSSWJ3aWF2YUhpeGg3VVZZZUtVNWpoSm5ERWlVZENMS2M4MWFDbU02QkdM?=
 =?utf-8?B?ZVdzcUlJdGRoeVdac0oyZHlDL3ppK2ZnKzFINjZwTHJRVDg3OHd4QW80K1VZ?=
 =?utf-8?B?Ymg0VEJFdWd6Rk5PZElDVWRRdGVZWlNaaHhqbnVZYTZ1ODFZd1VqQ2wzOHZN?=
 =?utf-8?B?R1NIK2UzSWZtVjJOYUlUT0M1WXk5ditpYnBmMWF6a2hxTVh4WDBCV3FEYTk3?=
 =?utf-8?B?T3Z6djlqT2ZtNEwrNTM1RkRFampKOEhkOVAxWkc1ZC9wTnRCcG5oY2lMQmpN?=
 =?utf-8?B?VDhPZjIxa0pMSzBjWFA5Z3ROeVlFV2MzQUJST0VZc2ZiSkZ4ZXVrMkZpY25W?=
 =?utf-8?B?RlMxcW9FWnlNQTVGaE81aDBKdUxmazBiMnJzUkxiaDBvOU91S0tCVU1zZk1i?=
 =?utf-8?B?bzRkdEVFc1o5K3dmV2draEp1UjY0a0dVMWZQbmVJWDhqTkVuY3VRYmZ5aVV6?=
 =?utf-8?B?cE0xL09ySFljQzhRZmJyOWxhbmRBcXpMMDFzVGdYRkd6QkFsVUllbmlSa2Ry?=
 =?utf-8?B?Ny9WSWFWamZEOUI0eXlBNVh1SWVUcDdLeEF3UGJYV2JidkdTVU5SNjJCbllm?=
 =?utf-8?B?NEo5aWtET0tGZVZZZnJNQXpWNFlLamc2ZVAwRmRYVjRpRDBDYkhLSHhNVHY5?=
 =?utf-8?B?dmJVMkZKblgwQlhhNWJaZE4vaTZJeW5WMHVlSzRBS2hQa2luWVFudFpQS3h0?=
 =?utf-8?B?Ni84eXRUOUFMbjU0Z01zYmhIQktrLzg0RXQvL2QvU1Y1d2xYYVcybDhwOHdk?=
 =?utf-8?B?RUQ4SjhYNjk5Rnp2UFlOZi90Z1FEcjkrUHZRd3NZVjAreTZZYUc1TURPR0oy?=
 =?utf-8?B?K3JFOHYxZ1p1bGI4OUJyMDhhb1hDT0dMVWw4WmtLYXIvTS95OVA5aGpWVEJ2?=
 =?utf-8?B?cklVbkhYN3ppb21IQWJXNnR3M1JnVXBTTEM2a0dzUGNoc2owbVc5aDJXSnc2?=
 =?utf-8?B?N0ZkVjVHbVZlZHdLcnJEa3IyVUxSNVEyc09vUVFRZnhaazdRZmZja2ZFVkI4?=
 =?utf-8?B?MzVVMVEzRGR5ZzN0NmJValM5bzFiV3JqbFd5bzJWR1ZjNzc4RnAwL3RobnQ1?=
 =?utf-8?B?bzNnc0J3djdPbkpZU3A1eTBPblhMOXdqR1MvUHYyb3dzbU5acERRcENyNnpO?=
 =?utf-8?B?OHhXODI2MXg5Y0xZeXFjTzREZzFyZjl2SVdKaEVERFQ3OVl3ekY3Skh0V1h2?=
 =?utf-8?B?bm5SSFZKOUF0V2ZxWU9tS3pwRG9VM1ZZMlZuc2dRc0NLTlpIbFZnbVBSOW1L?=
 =?utf-8?B?T1Q1TnZDYUY4Wkw0b0dSd2lMV3NUUnp2TFhBZC9xc2dBc21lSnJXQURobkk4?=
 =?utf-8?B?ME80a1d3aThJM21kNUlOQ1FkM2ZNQUNvODhuSnlqaGFOUndpVTlrTjRXcFhx?=
 =?utf-8?Q?r5r5bAV/SFjmnYJdZANviqT+G?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5635.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0834e27d-551d-457b-6a50-08dbd9702251
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 17:46:23.8060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4QgnZkCDTL5iGFaUkTYQH/AE2hJ0GNU/wXtsj7vhjiKq3Imo++IyefnsNoNEAioi5XGwEp+3zTyzT95b5ee3fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7212
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGlhbmcsIEthbiA8a2Fu
LmxpYW5nQGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDMwLCAyMDIz
IDg6MzIgQU0NCj4gVG86IFdhbmcsIFdlaWxpbiA8d2VpbGluLndhbmdAaW50ZWwuY29tPjsgUm9n
ZXJzLCBJYW4NCj4gPGlyb2dlcnNAZ29vZ2xlLmNvbT47IFBldGVyIFppamxzdHJhIDxwZXRlcnpA
aW5mcmFkZWFkLm9yZz47IEluZ28gTW9sbmFyDQo+IDxtaW5nb0ByZWRoYXQuY29tPjsgQXJuYWxk
byBDYXJ2YWxobyBkZSBNZWxvIDxhY21lQGtlcm5lbC5vcmc+Ow0KPiBBbGV4YW5kZXIgU2hpc2hr
aW4gPGFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb20+OyBKaXJpIE9sc2ENCj4gPGpv
bHNhQGtlcm5lbC5vcmc+OyBOYW1oeXVuZyBLaW0gPG5hbWh5dW5nQGtlcm5lbC5vcmc+OyBIdW50
ZXIsIEFkcmlhbg0KPiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+IENjOiBsaW51eC1wZXJm
LXVzZXJzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgVGF5
bG9yLA0KPiBQZXJyeSA8cGVycnkudGF5bG9yQGludGVsLmNvbT47IEFsdCwgU2FtYW50aGEgPHNh
bWFudGhhLmFsdEBpbnRlbC5jb20+Ow0KPiBCaWdnZXJzLCBDYWxlYiA8Y2FsZWIuYmlnZ2Vyc0Bp
bnRlbC5jb20+OyBNYXJrIFJ1dGxhbmQNCj4gPG1hcmsucnV0bGFuZEBhcm0uY29tPjsgWWFuZyBK
aWhvbmcgPHlhbmdqaWhvbmcxQGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENI
IHYyIDA3LzE3XSBwZXJmIHN0YXQ6IEFkZCBmdW5jdGlvbnMgdG8gc2V0IGNvdW50ZXINCj4gYml0
bWFwcyBmb3IgaGFyZHdhcmUtZ3JvdXBpbmcgbWV0aG9kDQo+IA0KPiANCj4gDQo+IE9uIDIwMjMt
MTAtMTMgOTo1MSBwLm0uLCB3ZWlsaW4ud2FuZ0BpbnRlbC5jb20gd3JvdGU6DQo+ID4gRnJvbTog
V2VpbGluIFdhbmcgPHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4gPg0KPiA+IEFkZCBtZXRyaWNn
cm91cF9fZXZlbnRfaW5mbyBkYXRhIHN0cnVjdHVyZSB0byByZXByZXNlbnQgYW4gZXZlbnQgaW4g
dGhlDQo+ID4gbWV0cmljIGdyb3VwaW5nIGNvbnRleHQ7IHRoZSBsaXN0IG9mIGNvdW50ZXJzIGFu
ZCB0aGUgUE1VIG5hbWUgYW4gZXZlbnQNCj4gPiBzaG91bGQgYmUgY29sbGVjdGVkIHdpdGguDQo+
ID4NCj4gPiBBZGQgZnVuY3Rpb25zIHRvIHBhcnNlIGV2ZW50IGNvdW50ZXIgaW5mbyBmcm9tIHBt
dS1ldmVudHMgYW5kIGdlbmVyYXRlIGENCj4gPiBsaXN0IG9mIG1ldHJpY2dyb3VwX19ldmVudF9p
bmZvIGRhdGEgdG8gcHJlcGFyZSBncm91cGluZy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdl
aWxpbiBXYW5nIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIHRvb2xzL3Bl
cmYvdXRpbC9tZXRyaWNncm91cC5jIHwgMTk2DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0NCj4gPiAgdG9vbHMvcGVyZi91dGlsL21ldHJpY2dyb3VwLmggfCAgMjcgKysrKysN
Cj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMjAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS90b29scy9wZXJmL3V0aWwvbWV0cmljZ3JvdXAuYyBiL3Rv
b2xzL3BlcmYvdXRpbC9tZXRyaWNncm91cC5jDQo+ID4gaW5kZXggOGQ0ZTI5ZWIxLi42YWY4YTcz
NDEgMTAwNjQ0DQo+ID4gLS0tIGEvdG9vbHMvcGVyZi91dGlsL21ldHJpY2dyb3VwLmMNCj4gPiAr
KysgYi90b29scy9wZXJmL3V0aWwvbWV0cmljZ3JvdXAuYw0KPiA+IEBAIC0xNDMyLDYgKzE0MzIs
MTgyIEBAIHN0YXRpYyBpbnQgYnVpbGRfY29tYmluZWRfZXhwcl9jdHgoY29uc3QNCj4gc3RydWN0
IGxpc3RfaGVhZCAqbWV0cmljX2xpc3QsDQo+ID4gIAlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4N
Cj4gPiArLyoqDQo+ID4gKyAqIHNldF9jb3VudGVyX2JpdG1hcCAtIFRoZSBjb3VudGVyIGJpdCBt
YXBwaW5nOiBbOC0xNSwwLTddLCBlLmcuIHRoZSBHUDANCj4gaXMgdGhlDQo+ID4gKyAqIDh0aCBi
aXQgYW5kIEdQNyBpcyB0aGUgMXN0IGJpdCBpbiB0aGlzIDE2LWJpdHMgYml0bWFwLiBJdCBpcyBo
ZWxwZnVsIGZvcg0KPiA+ICsgKiBhc3NpZ25pbmcgR1A0LTcgYmVmb3JlIEdQMC0zIGJlY2F1c2Ug
c29tZSBldmVudHMgY2FuIGJlIGNvbGxlY3RlZA0KPiB1c2luZyBHUDAtMw0KPiA+ICsgKiBvbmx5
IG9uIHNvbWUgcGxhdGZvcm1zLg0KPiANCj4gVGhlIGJpdG1hcCBsb29rcyB3ZWlyZC4gQ2FuIHdl
IHVzZSB0aGUgbm9ybWFsIGJpdG1hcCBhbmQgYWx3YXlzIHNlYXJjaA0KPiBmcm9tIHRoZSBsYXN0
IHNldCBiaXQgdG8gZmluZCB0aGUgYXZhaWxhYmxlIGNvdW50ZXI/DQo+IA0KPg0KDQpIaSBLYW4s
DQoNClllcywgSSBqdXN0IHdhbnQgdG8gZW5zdXJlIHRvIHN0YXJ0IHVzaW5nIHRoZSBoaWdoZXN0
IGluZGV4ZWQgY291bnRlciBmaXJzdC4gDQpDb3VsZCB5b3UgcGxlYXNlIGxldCBtZSBrbm93IHdo
YXQgaXMgdGhlIGJlc3Qgd2F5IHRvIHNlYXJjaCBmcm9tIHRoZSBsYXN0IHNldCBiaXQ/DQoNClRo
YW5rcywNCldlaWxpbg0KDQoNCj4gPiArICovDQo+ID4gK3N0YXRpYyBpbnQgc2V0X2NvdW50ZXJf
Yml0bWFwKGludCBwb3MsIHVuc2lnbmVkIGxvbmcgKmJpdG1hcCkNCj4gPiArew0KPiA+ICsJaWYg
KHBvcyA+PSBOUl9DT1VOVEVSUyB8fCBwb3MgPCAwKQ0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0K
PiA+ICsJaWYgKHBvcyA8PSA3KQ0KPiA+ICsJCXBvcyA9IFRSQU5TRkVSX0ZJUlNUX0JZVEUocG9z
KTsNCj4gPiArCWVsc2UNCj4gPiArCQlwb3MgPSBUUkFOU0ZFUl9TRUNfQllURShwb3MpOw0KPiA+
ICsJKmJpdG1hcCB8PSAxdWwgPDwgcG9zOw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiAr
DQo+ID4gK3N0YXRpYyBpbnQgcGFyc2VfZml4ZWRfY291bnRlcihjb25zdCBjaGFyICpjb3VudGVy
LA0KPiA+ICsJCQkgICAgICB1bnNpZ25lZCBsb25nICpiaXRtYXAsDQo+ID4gKwkJCSAgICAgIGJv
b2wgKmZpeGVkKQ0KPiA+ICt7DQo+ID4gKwlpbnQgcmV0ID0gLUVOT0VOVDsNCj4gPiArCS8vVE9E
TzogdGhpcyBwYXR0ZXJuIGlzIGRpZmZlcmVudCBvbiBzb21lIG90aGVyIHBsYXRmb3Jtcw0KPiA+
ICsJY29uc3QgY2hhciAqcGF0dGVybiA9ICJGaXhlZCBjb3VudGVyICI7DQo+ID4gKwlpbnQgcG9z
ID0gMDsNCj4gPiArDQo+ID4gKwlpZiAoIXN0cm5jbXAoY291bnRlciwgcGF0dGVybiwgc3RybGVu
KHBhdHRlcm4pKSkgew0KPiA+ICsJCXBvcyA9IGF0b2koY291bnRlciArIHN0cmxlbihwYXR0ZXJu
KSk7DQo+ID4gKwkJcmV0ID0gc2V0X2NvdW50ZXJfYml0bWFwKHBvcywgYml0bWFwKTsNCj4gPiAr
CQlpZiAocmV0KQ0KPiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+ICsJCSpmaXhlZCA9IHRydWU7DQo+
ID4gKwkJcmV0dXJuIDA7DQo+ID4gKwl9DQo+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4g
Kw0KPiA+ICsvKioNCj4gPiArICogcGFyc2VfY291bnRlciAtIFBhcnNlIGV2ZW50IGNvdW50ZXIg
aW5mbyBmcm9tIHBtdS1ldmVudHMgYW5kIHNldCB1cA0KPiBiaXRtYXANCj4gPiArICogYWNjb3Jk
aW5nbHkuDQo+ID4gKyAqDQo+ID4gKyAqIEBjb3VudGVyOiBjb3VudGVyIGluZm8gc3RyaW5nIHRv
IGJlIHBhcnNlZC4NCj4gPiArICogQGJpdG1hcDogYml0bWFwIHRvIHNldCBiYXNlZCBvbiBjb3Vu
dGVyIGluZm8gcGFyc2VkLg0KPiA+ICsgKiBAZml4ZWQ6IGlzIHNldCB0byB0cnVlIGlmIHRoZSBl
dmVudCB1c2VzIGZpeGVkIGNvdW50ZXIuDQo+ID4gKyAqLw0KPiA+ICtzdGF0aWMgaW50IHBhcnNl
X2NvdW50ZXIoY29uc3QgY2hhciAqY291bnRlciwNCj4gPiArCQkJdW5zaWduZWQgbG9uZyAqYml0
bWFwLA0KPiA+ICsJCQlib29sICpmaXhlZCkNCj4gPiArew0KPiA+ICsJaW50IHJldCA9IDA7DQo+
ID4gKwljaGFyICpwOw0KPiA+ICsJY2hhciAqdG9rOw0KPiA+ICsJaW50IHBvcyA9IDA7DQo+ID4g
Kw0KPiA+ICsJcmV0ID0gcGFyc2VfZml4ZWRfY291bnRlcihjb3VudGVyLCBiaXRtYXAsIGZpeGVk
KTsNCj4gPiArCS8vIHJldD09MCBtZWFucyBtYXRjaGVkIHdpdGggZml4ZWQgY291bnRlcg0KPiAN
Cj4gTW92ZSB0aGUgY29tbWVudHMgdG8gdGhlIGFib3ZlIG9mIHBhcnNlX2ZpeGVkX2NvdW50ZXIo
KS4NCj4gVXNlcyAvKiovLg0KPiANCj4gPiArCWlmIChyZXQgPT0gMCkNCj4gPiArCQlyZXR1cm4g
cmV0Ow0KPiA+ICsNCj4gPiArCXAgPSBzdHJkdXAoY291bnRlcik7DQo+ID4gKwl0b2sgPSBzdHJ0
b2socCwgIiwiKTsNCj4gPiArCWlmICghdG9rKQ0KPiA+ICsJCXJldHVybiAtRU5PRU5UOw0KPiA+
ICsNCj4gPiArCXdoaWxlICh0b2spIHsNCj4gPiArCQlwb3MgPSBhdG9pKHRvayk7DQo+ID4gKwkJ
cmV0ID0gc2V0X2NvdW50ZXJfYml0bWFwKHBvcywgYml0bWFwKTsNCj4gPiArCQlpZiAocmV0KQ0K
PiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+ICsJCXRvayA9IHN0cnRvayhOVUxMLCAiLCIpOw0KPiA+
ICsJfQ0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBzdHJ1Y3Qg
bWV0cmljZ3JvdXBfX2V2ZW50X2luZm8gKmV2ZW50X2luZm9fX25ldyhjb25zdCBjaGFyDQo+ICpu
YW1lLA0KPiA+ICsJCQkJCQkgICAgICBjb25zdCBjaGFyICpwbXVfbmFtZSwNCj4gPiArCQkJCQkJ
ICAgICAgY29uc3QgY2hhciAqY291bnRlciwNCj4gPiArCQkJCQkJICAgICAgYm9vbCBmcmVlX2Nv
dW50ZXIpDQo+ID4gK3sNCj4gPiArCWludCByZXQgPSAwOw0KPiA+ICsJY2hhciAqYml0X2J1ZiA9
IG1hbGxvYyhOUl9DT1VOVEVSUyk7DQo+ID4gKwlib29sIGZpeGVkX2NvdW50ZXIgPSBmYWxzZTsN
Cj4gPiArCXN0cnVjdCBtZXRyaWNncm91cF9fZXZlbnRfaW5mbyAqZTsNCj4gPiArDQo+ID4gKwll
ID0gemFsbG9jKHNpemVvZigqZSkpOw0KPiA+ICsJaWYgKCFlKQ0KPiA+ICsJCXJldHVybiBOVUxM
Ow0KPiA+ICsJaWYgKCFwbXVfbmFtZSkNCj4gPiArCQlwbXVfbmFtZSA9ICJjb3JlIjsNCj4gPiAr
DQo+ID4gKwllLT5uYW1lID0gbmFtZTsNCj4gPiArCWUtPmZyZWVfY291bnRlciA9IGZyZWVfY291
bnRlcjsNCj4gPiArCWUtPnBtdV9uYW1lID0gc3RyZHVwKHBtdV9uYW1lKTsNCj4gPiArCWlmIChm
cmVlX2NvdW50ZXIpIHsNCj4gPiArCQlyZXQgPSBzZXRfY291bnRlcl9iaXRtYXAoMCwgZS0+Y291
bnRlcnMpOw0KPiA+ICsJCWlmIChyZXQpDQo+ID4gKwkJCXJldHVybiBOVUxMOw0KPiA+ICsJfSBl
bHNlIHsNCj4gPiArCQlyZXQgPSBwYXJzZV9jb3VudGVyKGNvdW50ZXIsIGUtPmNvdW50ZXJzLCAm
Zml4ZWRfY291bnRlcik7DQo+ID4gKwkJaWYgKHJldCkNCj4gPiArCQkJcmV0dXJuIE5VTEw7DQo+
ID4gKwkJZS0+Zml4ZWRfY291bnRlciA9IGZpeGVkX2NvdW50ZXI7DQo+ID4gKwl9DQo+ID4gKw0K
PiA+ICsJYml0bWFwX3NjbnByaW50ZihlLT5jb3VudGVycywgTlJfQ09VTlRFUlMsIGJpdF9idWYs
DQo+IE5SX0NPVU5URVJTKTsNCj4gPiArCXByX2RlYnVnKCJFdmVudCAlcyByZXF1aXJlcyBwbXUg
JXMgY291bnRlcjogJXMgYml0bWFwICVzLA0KPiBbcG11PSVzXVxuIiwNCj4gPiArCQllLT5uYW1l
LCBlLT5wbXVfbmFtZSwgY291bnRlciwgYml0X2J1ZiwgcG11X25hbWUpOw0KPiA+ICsNCj4gPiAr
CXJldHVybiBlOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdHJ1Y3QgbWV0cmljZ3JvdXBfX2FkZF9t
ZXRyaWNfZXZlbnRfZGF0YSB7DQo+ID4gKwlzdHJ1Y3QgbGlzdF9oZWFkICpsaXN0Ow0KPiA+ICsJ
LyogcHVyZSBldmVudCBuYW1lLCBleGNsdWRlIHVtYXNrIGFuZCBvdGhlciBpbmZvKi8NCj4gPiAr
CWNvbnN0IGNoYXIgKmV2ZW50X25hbWU7DQo+ID4gKwkvKiBldmVudCBuYW1lIGFuZCB1bWFzayBp
ZiBhcHBsaWNhYmxlKi8NCj4gPiArCWNvbnN0IGNoYXIgKmV2ZW50X2lkOw0KPiA+ICt9Ow0KPiA+
ICsNCj4gPiArc3RhdGljIGludCBtZXRyaWNncm91cF9fYWRkX21ldHJpY19ldmVudF9jYWxsYmFj
ayhjb25zdCBzdHJ1Y3QgcG11X2V2ZW50DQo+ICpwZSwNCj4gPiArCQkJCQkJIGNvbnN0IHN0cnVj
dA0KPiBwbXVfZXZlbnRzX3RhYmxlICp0YWJsZSBfX21heWJlX3VudXNlZCwNCj4gPiArCQkJCQkJ
IHZvaWQgKmRhdGEpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBtZXRyaWNncm91cF9fZXZlbnRfaW5m
byAqZXZlbnQ7DQo+ID4gKwlzdHJ1Y3QgbWV0cmljZ3JvdXBfX2FkZF9tZXRyaWNfZXZlbnRfZGF0
YSAqZCA9IGRhdGE7DQo+ID4gKw0KPiA+ICsJaWYgKCFzdHJjYXNlY21wKHBlLT5uYW1lLCBkLT5l
dmVudF9uYW1lKSkgew0KPiA+ICsJCWV2ZW50ID0gZXZlbnRfaW5mb19fbmV3KGQtPmV2ZW50X2lk
LCBwZS0+cG11LCBwZS0+Y291bnRlciwNCj4gLypmcmVlX2NvdW50ZXI9Ki9mYWxzZSk7DQo+ID4g
KwkJaWYgKCFldmVudCkNCj4gPiArCQkJcmV0dXJuIC1FTk9NRU07DQo+ID4gKwkJbGlzdF9hZGQo
JmV2ZW50LT5uZCwgZC0+bGlzdCk7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+
ID4gK30NCj4gPiArDQo+ID4gKy8qKg0KPiA+ICsgKiBnZXRfbWV0cmljZ3JvdXBfZXZlbnRzIC0g
RmluZCBjb3VudGVyIHJlcXVpcmVtZW50IG9mIGV2ZW50cyBmcm9tIHRoZQ0KPiA+ICsgKiBwbXVf
ZXZlbnRzIHRhYmxlDQo+ID4gKyAqIEBmdWxsX2lkOiB0aGUgZnVsbCBldmVudCBpZGVudGlmaWVy
cy4NCj4gPiArICogQHRhYmxlOiBwbXVfZXZlbnRzIHRhYmxlIHRoYXQgaXMgc2VhcmNoZWQgZm9y
IGV2ZW50IGRhdGEuDQo+ID4gKyAqIEBldmVudF9pbmZvX2xpc3Q6IHRoZSBsaXN0IHRoYXQgdGhl
IG5ldyBldmVudCBjb3VudGVyIGluZm8gYWRkZWQgdG8uDQo+ID4gKyAqLw0KPiA+ICtzdGF0aWMg
aW50IGdldF9tZXRyaWNncm91cF9ldmVudHMoY29uc3QgY2hhciAqZnVsbF9pZCwNCj4gPiArCQkJ
CSBjb25zdCBzdHJ1Y3QgcG11X2V2ZW50c190YWJsZSAqdGFibGUsDQo+ID4gKwkJCQkgc3RydWN0
IGxpc3RfaGVhZCAqZXZlbnRfaW5mb19saXN0KQ0KPiA+ICt7DQo+ID4gKwlMSVNUX0hFQUQobGlz
dCk7DQo+ID4gKwlpbnQgcmV0ID0gMDsNCj4gPiArCWNvbnN0IGNoYXIgKmlkOw0KPiA+ICsJY29u
c3QgY2hhciAqcnNlcCwgKnNlcCA9IHN0cmNocihmdWxsX2lkLCAnQCcpOw0KPiA+ICsNCj4gPiAr
CWlmIChzZXApIHsNCj4gPiArCQlyc2VwID0gc3RyY2hyKGZ1bGxfaWQsICcsJyk7DQo+ID4gKwkJ
aWQgPSBzdHJuZHVwKHNlcCArIDEsIHJzZXAgLSBzZXAgLSAxKTsNCj4gPiArCQlpZiAocmV0KQ0K
PiA+ICsJCQlnb3RvIG91dDsNCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJaWQgPSBmdWxsX2lkOw0K
PiA+ICsJfQ0KPiA+ICsJew0KPiA+ICsJCXN0cnVjdCBtZXRyaWNncm91cF9fYWRkX21ldHJpY19l
dmVudF9kYXRhIGRhdGEgPSB7DQo+ID4gKwkJCS5saXN0ID0gJmxpc3QsDQo+ID4gKwkJCS5ldmVu
dF9uYW1lID0gaWQsDQo+ID4gKwkJCS5ldmVudF9pZCA9IGZ1bGxfaWQsDQo+ID4gKwkJfTsNCj4g
PiArCQlyZXQgPSBwbXVfZXZlbnRzX3RhYmxlX2Zvcl9lYWNoX2V2ZW50KHRhYmxlLA0KPiA+ICsJ
CQkJbWV0cmljZ3JvdXBfX2FkZF9tZXRyaWNfZXZlbnRfY2FsbGJhY2ssDQo+ICZkYXRhKTsNCj4g
PiArCX0NCj4gDQo+IFBsZWFzZSByZW1vdmUgdGhlIHVzZWxlc3Mge30NCj4gDQo+IFRoYW5rcywN
Cj4gS2FuDQo+ID4gKw0KPiA+ICtvdXQ6DQo+ID4gKwlsaXN0X3NwbGljZSgmbGlzdCwgZXZlbnRf
aW5mb19saXN0KTsNCj4gPiArCXJldHVybiByZXQ7DQo+ID4gK30NCj4gPiArDQo+ID4gIC8qKg0K
PiA+ICAgKiBod19hd2FyZV9idWlsZF9ncm91cGluZyAtIEJ1aWxkIGV2ZW50IGdyb3VwaW5ncyBi
eSByZWFkaW5nIGNvdW50ZXINCj4gPiAgICogcmVxdWlyZW1lbnQgb2YgdGhlIGV2ZW50cyBhbmQg
Y291bnRlciBhdmFpbGFibGUgb24gdGhlIHN5c3RlbSBmcm9tDQo+ID4gQEAgLTE0NDUsOSArMTYy
MSwyNSBAQCBzdGF0aWMgaW50IGh3X2F3YXJlX2J1aWxkX2dyb3VwaW5nKHN0cnVjdA0KPiBleHBy
X3BhcnNlX2N0eCAqY3R4IF9fbWF5YmVfdW51c2VkLA0KPiA+ICAJCQkJICBjb25zdCBjaGFyICpt
b2RpZmllciBfX21heWJlX3VudXNlZCkNCj4gPiAgew0KPiA+ICAJaW50IHJldCA9IDA7DQo+ID4g
KwlzdHJ1Y3QgaGFzaG1hcF9lbnRyeSAqY3VyOw0KPiA+ICsJTElTVF9IRUFEKHBtdV9pbmZvX2xp
c3QpOw0KPiA+ICsJTElTVF9IRUFEKGV2ZW50X2luZm9fbGlzdCk7DQo+ID4gKwlzaXplX3QgYmt0
Ow0KPiA+ICsJY29uc3Qgc3RydWN0IHBtdV9ldmVudHNfdGFibGUgKmV0YWJsZSA9IHBtdV9ldmVu
dHNfdGFibGVfX2ZpbmQoKTsNCj4gPiArDQo+ID4gKyNkZWZpbmUgUkVUVVJOX0lGX05PTl9aRVJP
KHgpIGRvIHsgaWYgKHgpIHJldHVybiB4OyB9IHdoaWxlICgwKQ0KPiA+ICsJaGFzaG1hcF9fZm9y
X2VhY2hfZW50cnkoY3R4LT5pZHMsIGN1ciwgYmt0KSB7DQo+ID4gKwkJY29uc3QgY2hhciAqaWQg
PSBjdXItPnBrZXk7DQo+ID4gKw0KPiA+ICsJCXByX2RlYnVnKCJmb3VuZCBldmVudCAlc1xuIiwg
aWQpOw0KPiA+ICsNCj4gPiArCQlyZXQgPSBnZXRfbWV0cmljZ3JvdXBfZXZlbnRzKGlkLCBldGFi
bGUsICZldmVudF9pbmZvX2xpc3QpOw0KPiA+ICsJCWlmIChyZXQpDQo+ID4gKwkJCXJldHVybiBy
ZXQ7DQo+ID4gKwl9DQo+ID4NCj4gPiAtCXByX2RlYnVnKCJUaGlzIGlzIGEgcGxhY2Vob2xkZXJc
biIpOw0KPiA+ICAJcmV0dXJuIHJldDsNCj4gPiArI3VuZGVmIFJFVFVSTl9JRl9OT05fWkVSTw0K
PiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIHZvaWQgZ3JvdXBfc3RyX2ZyZWUoc3RydWN0IG1ldHJp
Y2dyb3VwX19ncm91cF9zdHJzICpnKQ0KPiA+IEBAIC0xNTIxLDggKzE3MTMsNiBAQCBzdGF0aWMg
aW50IGh3X2F3YXJlX3BhcnNlX2lkcyhzdHJ1Y3QgcGVyZl9wbXUNCj4gKmZha2VfcG11LA0KPiA+
ICAJKm91dF9ldmxpc3QgPSBwYXJzZWRfZXZsaXN0Ow0KPiA+ICAJcGFyc2VkX2V2bGlzdCA9IE5V
TEw7DQo+ID4gIGVycl9vdXQ6DQo+ID4gLQlwYXJzZV9ldmVudHNfZXJyb3JfX2V4aXQoJnBhcnNl
X2Vycm9yKTsNCj4gPiAtCWV2bGlzdF9fZGVsZXRlKHBhcnNlZF9ldmxpc3QpOw0KPiA+ICAJbWV0
cmljZ3JvdXBfX2ZyZWVfZ3JvdXBpbmdfc3RycygmZ3JvdXBpbmdzKTsNCj4gPiAgCXJldHVybiBy
ZXQ7DQo+ID4gIH0NCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi91dGlsL21ldHJpY2dyb3Vw
LmggYi90b29scy9wZXJmL3V0aWwvbWV0cmljZ3JvdXAuaA0KPiA+IGluZGV4IDg5ODA5ZGY4NS4u
MzcwNDU0NWM5IDEwMDY0NA0KPiA+IC0tLSBhL3Rvb2xzL3BlcmYvdXRpbC9tZXRyaWNncm91cC5o
DQo+ID4gKysrIGIvdG9vbHMvcGVyZi91dGlsL21ldHJpY2dyb3VwLmgNCj4gPiBAQCAtNSw2ICs1
LDcgQEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2xpc3QuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4
L3JidHJlZS5oPg0KPiA+ICAjaW5jbHVkZSA8c3RkYm9vbC5oPg0KPiA+ICsjaW5jbHVkZSA8bGlu
dXgvYml0bWFwLmg+DQo+ID4gICNpbmNsdWRlICJwbXUtZXZlbnRzL3BtdS1ldmVudHMuaCINCj4g
PiAgI2luY2x1ZGUgInN0cmJ1Zi5oIg0KPiA+DQo+ID4gQEAgLTY3LDYgKzY4LDMyIEBAIHN0cnVj
dCBtZXRyaWNfZXhwciB7DQo+ID4gIAlpbnQgcnVudGltZTsNCj4gPiAgfTsNCj4gPg0KPiA+ICsv
KiBNYXhpbXVtIG51bWJlciBvZiBjb3VudGVycyBwZXIgUE1VKi8NCj4gPiArI2RlZmluZSBOUl9D
T1VOVEVSUwkxNg0KPiA+ICsvKg0KPiA+ICsgKiBUcmFuc2ZlciBiaXQgcG9zaXRpb24gaW4gdGhl
IGJpdG1hcCB0byBlbnN1cmUgc3RhcnQgYXNzaWduaW5nIGNvdW50ZXIgZnJvbQ0KPiA+ICsgKiB0
aGUgbGFzdCBHUCBjb3VudGVyIHRvIHRoZSBmaXJzdC4NCj4gPiArICogYml0MTUgPC0tLT4gYml0
MA0KPiA+ICsgKiBbR1A4LUdQMTVdIFtHUDAtR1A3XQ0KPiA+ICsgKi8NCj4gPiArI2RlZmluZSBU
UkFOU0ZFUl9GSVJTVF9CWVRFKHBvcykgKDcgLSBwb3MpDQo+ID4gKyNkZWZpbmUgVFJBTlNGRVJf
U0VDX0JZVEUocG9zKSAoMjMgLSBwb3MpDQo+ID4gKw0KPiA+ICsvKioNCj4gPiArICogQW4gZXZl
bnQgdXNlZCBpbiBhIG1ldHJpYy4gVGhpcyBpbmZvIGlzIGZvciBtZXRyaWMgZ3JvdXBpbmcuDQo+
ID4gKyAqLw0KPiA+ICtzdHJ1Y3QgbWV0cmljZ3JvdXBfX2V2ZW50X2luZm8gew0KPiA+ICsJc3Ry
dWN0IGxpc3RfaGVhZCBuZDsNCj4gPiArCS8qKiBUaGUgbmFtZSBvZiB0aGUgZXZlbnQuICovDQo+
ID4gKwljb25zdCBjaGFyICpuYW1lOw0KPiA+ICsJLyoqIFRoZSBuYW1lIG9mIHRoZSBwbXUgdGhl
IGV2ZW50IGJlIGNvbGxlY3RlZCBvbi4gKi8NCj4gPiArCWNvbnN0IGNoYXIgKnBtdV9uYW1lOw0K
PiA+ICsJYm9vbCBmaXhlZF9jb3VudGVyOw0KPiA+ICsJYm9vbCBmcmVlX2NvdW50ZXI7DQo+ID4g
KwkvKiogVGhlIGNvdW50ZXJzIHRoZSBldmVudCBhbGxvd2VkIHRvIGJlIGNvbGxlY3RlZCBvbi4g
Ki8NCj4gPiArCURFQ0xBUkVfQklUTUFQKGNvdW50ZXJzLCBOUl9DT1VOVEVSUyk7DQo+ID4gK307
DQo+ID4gKw0KPiA+ICAvKioNCj4gPiAgICogRWFjaCBncm91cCBpcyBvbmUgbm9kZSBpbiB0aGUg
Z3JvdXAgc3RyaW5nIGxpc3QuDQo+ID4gICAqLw0K
