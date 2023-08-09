Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2E07756A4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjHIJrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjHIJrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:47:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFBAED
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 02:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691574438; x=1723110438;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fu9TCgCTOfLnnic400NI72XFr0gW5lKUzf5uTZbE0Bc=;
  b=WL8iUp4veS3MXAKX0OISoF7pDgge1dMecbqyUjYe4etAF1dt8h88DdlU
   Oq4USDZazS6NWHmqCHgxwMhjAr/XMv6ZR+ViroPZmypHhOLWiyMFZhvzV
   tlAXS018gpTXy0xWX+u38KSuNobFVILK6a6PwEIY7UIFST+cyvrLYQSLS
   Bm2zxYMoL1BFHCUXP4zx2Ll7hV1rCw8NMYRCyw9/kiwK5GwQ+1iWlA9On
   ShKo2b55DYVqy5TEOVHKX6XpQNsjSa7qydiITAJjOupQJwCWB7NLa5t43
   BcIHwtvlswmb8ySvvFxOJohP8AY0bfZHJzyWl5uVeF0Tir74MwIoZsVSJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="369980479"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="369980479"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 02:47:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="821784625"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="821784625"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Aug 2023 02:47:18 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 02:47:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 02:47:17 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 02:47:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEAg0iONGch48T39Md7DE8uADRxBxpZ5/06Er2frZyZNZnPca4kKzui0/mAUCyKKFCObF6/pkMxznTz0C2tqjR/kUb6UfYogOI4YLX43HpH88oJFKf93KvI2oWJPKV4crZ37hQoThrPswwZk+gpoAyzFUELr4v5JRvUJObEBrbhb/0DViPuVQy9+0iot5RI9z/CwHzm2FYWFVwCL+uXJB3L+VuPY87j1MjEr17kcV7Y7gKhN5ZjewwCeUrep9UfEQoFdUW2wdIOIXEebQ+parsSdF2zWJPciUO9TaDAhi9AYAbMF5OpgSNF2ISNn5TS/ga1wwW+oe2J03IYbeADIPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fu9TCgCTOfLnnic400NI72XFr0gW5lKUzf5uTZbE0Bc=;
 b=TF9YI9O2mr9WB8jre+m7kW+XonUtoZAhFukIQTI3Dhbv2rex36opJ9x4nEVeFVOGTKQuXO4eZK+0byaUWIKIK8MXgLWicbPFyc5C+9BO9NMWkbPHFwVxz5b4s5LI8RpZeatMP7QLjzwL/3fYTCWePoqaqrVByx6bLeRnxxEqvooDCjDuibxRxtuA5/yMb4fOKqBn5KPt7BA/cBX8kHd66vV6oJopbZBwWalMcSYxupjvgc57HReM3NmNy5porC82cEQu3xp4AHvCChf+DMwySYukb4gJa2FeKOo4hMTXatWAW4eQKM/IEcWp9DSiqI1s2gI8++voN+4sVaclh4iMng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB8272.namprd11.prod.outlook.com (2603:10b6:a03:47d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Wed, 9 Aug
 2023 09:47:15 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 09:47:15 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Zhang, Tina" <tina.zhang@intel.com>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/5] iommu: Add mm_get_pasid() helper function
Thread-Topic: [PATCH 1/5] iommu: Add mm_get_pasid() helper function
Thread-Index: AQHZyczwFZzHzes600Wmj/N3sxtrna/gfxKAgAE5d9A=
Date:   Wed, 9 Aug 2023 09:47:15 +0000
Message-ID: <BN9PR11MB527654AF38084B07EC7734468C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <20230808074944.7825-2-tina.zhang@intel.com> <ZNJY/9pwRxIkFEjD@ziepe.ca>
In-Reply-To: <ZNJY/9pwRxIkFEjD@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB8272:EE_
x-ms-office365-filtering-correlation-id: b3a03dd5-49eb-4c61-cba0-08db98bd9d37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uvn8/WzsUenoGGd+m9BdtmYzfAfcuFcT6hOwTkjlZ7E9YEtLjQoE8q4/aJL35K+GZDCik3DCDhd/riy51vh1RjQWD6yCNTfBh71Q5Z0s+fT3JnTO9ZvWQIVeeu/MoxjGkxq0j+/Ncxn4Kon7CjXvF5Is8jmO0dKaLMTQRPKuCPvENJnciKWj2fvltsEk9+8V9t6oTCxJV/KDCfSlqCm0rSiFNUSjoNHq4ZsHr/U4TdO49VB379fDgMuyFE1NnPhwJEBG/HjEucF5VWyPLNmbb+NMoBa3Wg77AYwpqSoKzHH5lwiLjc5/eqq87upJ/1bQRQcKj8/2J/JkHHctiYbk83yJi4NQQbqm6sgZ3WUBlBTynaeBi+lROZlZEQocVyxpaPiHmd+VzeVhcpdOCn5cZ8tk9BOHuaJlx0sEsLAKx8Z2mH8iczrCGE73Ujbhdory/VxyjcpSNi15g8IUnGdRsPaGqO+XVWZu1y3tWx7FxlbI24ae2Ns0+5+bd/hs/KKVGf5NfPtlyjcx0WMopIWKy8UOsTnwOC1j2/sc27dfoAzzHgbS9obApuTq1ex97AP3d03xV+W4es2nbHo3E+YsEXpOGDxtAB35hZJ2Z+P3BVm53bGxF1bd2ie6RgLJQvrs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199021)(1800799006)(186006)(71200400001)(55016003)(7696005)(8936002)(26005)(33656002)(110136005)(478600001)(9686003)(82960400001)(122000001)(86362001)(54906003)(6506007)(6636002)(316002)(4744005)(52536014)(8676002)(38100700002)(4326008)(41300700001)(5660300002)(2906002)(66946007)(66556008)(66446008)(76116006)(64756008)(66476007)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkZmNkNKbWxVOHBTUEl2RFB1N09zWHpka1Iza01EOHpPMTZxYUFzREphQkZ0?=
 =?utf-8?B?U25zcGpLQ2luYmdoYU9sdTBrckNGdlpKajd2cFBMbitORVBVb0xNM0lPamdD?=
 =?utf-8?B?L2lqeE81My9jU3FSYVAzWW1UTGZrUnd0NFptMXkzUXFwMmg3aTE0TlVaSHZX?=
 =?utf-8?B?OHAxaEdpMWVnQ1NtNmVocHE5cWp1NXYvdWVEc0V4NzQ2RGhmU21KRWpEQk1j?=
 =?utf-8?B?TmpaK1E1QWh3U2RUY0wwbHoyYjAweDYxRzdVRXU0djFuQ2FPM1JIQklDb3Z6?=
 =?utf-8?B?WWY1SW5VSGJoTnFDd1JUbXdjQ3VkMWllVzBhejlJVXlmZkxtN0k2cFgyOSth?=
 =?utf-8?B?UVFVZUIrRXR4bkVRVlNhNkdiNFZ6bC85YUk1anhCWE84TjE5eGdlMFFXM081?=
 =?utf-8?B?TDNUMTV0WlhIdkZQeStoK2NnMXFOMXd1RlIreHVhRk9vRGhvcXd1Sk9NYzhn?=
 =?utf-8?B?YXFpQm9rNnBSL3llRWV2K3BKQ0JQdmZZWjcvV3N3RmNtck9jVzJGUGI3SmlG?=
 =?utf-8?B?MFN6aGVBSEpYQllmWjVtRjhyeUp3bmJ0RWhzTUl4Nk1hc0VRSUNOSnVYcTlK?=
 =?utf-8?B?cVJQQ3BXejd5eERUMEgxZzhRS2tTUFpYaFArS1FBcERSNnJ5SWh3cXZSVzZp?=
 =?utf-8?B?d3IwZHg2SWs4bkp0b1g2d01PRWJSSUpjaDhxS2xOdlcvS1dRY29vOEpNazFF?=
 =?utf-8?B?czZZMXZ5aGtnS1lXVkpTeFU0Nk1GdWMxMWpmdUdhQjJGL01FYXdmYXVsTVJO?=
 =?utf-8?B?dy96NEY0WmFCMTAwUmFZWGJ4UVR6UEFRMENYUjhCVzF3VW5oSnhNZi9teVlw?=
 =?utf-8?B?Sjd5YkVpbE81TGNxU1hpRWg5RHZqbDlzM09SaUdnOGQ3RGNFU3o1blM3bnZW?=
 =?utf-8?B?K2JKcUlvWlFCQmE2c1RZNDdscWtzcThFWlhVWngvUlY0YzFzUmprSFRPQmxD?=
 =?utf-8?B?d3N5TENiOVRUNk9PVUNqdTVHMmNvV0FYOSsxekppeHhZRUkyRWRJaWxsTlpM?=
 =?utf-8?B?QWlZS3dvVEVaUFZXSkpJQ1ZKQ3JLZ1UvMGdJVnJxbGg3ck1pSFZIejlXSVJv?=
 =?utf-8?B?d2EwL3JqZUwrQm9NSmNmRXBhOTVhYnJyRlhDOHJvU1g5SXZ3b1NQV2RSWTVX?=
 =?utf-8?B?NW5aQ2UyOHRRZmpDaytOYWNSUW9nVDAzdHQwV3dNWmJYRU1sSmlTd1ZrUlJn?=
 =?utf-8?B?NDJMUzI4enBzK2tEK0ZydXRjcFhNM1Y4UVhMelEyUFhQbkFqT0M4Yi90ZC9y?=
 =?utf-8?B?Y2U0RUJxSmhUeVhkS1ZHYzJMUkVmYVpCaFBjQWdzdXMvYzNFMnZFbkxxakVQ?=
 =?utf-8?B?MUtQb2t5R3QzbHkvL0FOYVdSSjRLQnRsOEVUNmQ0QzQ3dSsya2NBWi9zVEJT?=
 =?utf-8?B?ek1IWXpEZVBzRlhMVmllN0ZocE1vbVNWdVRtYmlWYzlWQXNhc1lHQW5BQ01v?=
 =?utf-8?B?YVhHczlCczRta2NCZ3orTDRQTnpMbUZ3NUkwazNJUGVjN3RkcUtLWDh4SVVP?=
 =?utf-8?B?YlZZUDZrNXVLYnZMaDljMVdVcnZuQXlDdkVUblQ4RE1DKzdMWDZUdmFKL1lO?=
 =?utf-8?B?YmVhcnJwYTlxTWxQYnd0UkZJOGlKWVdRUExZeXM5c2xBWGp3enJ0TWswUllr?=
 =?utf-8?B?K3FISWpPQjJqdUt5WlV3VmFhbWQrS2xQYmFyMUVzY3pSbzFPbWpWWkZUVnVv?=
 =?utf-8?B?bVJoaWpLdGVaTktwb016VW1LUWkrbU0yY0xmTmVJVzcwODBjcFdXSUhSbGtN?=
 =?utf-8?B?UW1scWRrbjFXa3Uxek1EVHhuV1I4ZHdJWG9ubnF5TEJ2ZEFlZUdINktrSVBk?=
 =?utf-8?B?V0FkVnpDMldGaGRjQzdMNjVaZ0NUTG9naWZCNHVhMk96SXBpdU1uOWZhWDVU?=
 =?utf-8?B?N1ZIV0diMXVmZDF1TFJIdUZzSjZSdUUxVzJadktGL0JMTmNCZ1dWbWo3VThw?=
 =?utf-8?B?VmhrUk9PTTBaNFNsaTFLekVrZUo4WWRGRUllSXRXaWhOZGFVVVZlL2JxZU93?=
 =?utf-8?B?RXRxbzJlcTZDbkZMbHpFbml4M2M2cTIrWnRJWWxxaEJuQ0E3UTNwcXZIK1o0?=
 =?utf-8?B?YkJXR1hLbkZNY01iQXJrQmFHMmVxbjI3czRGSW1WZyt2akxZOFdRVE9aWDJm?=
 =?utf-8?Q?kSAKbfXeVrbJGCXdx9msbbyyf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a03dd5-49eb-4c61-cba0-08db98bd9d37
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 09:47:15.6518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mp1HTfgZbGql8mXSucLvLVusLKJ41SbpJNwokAsirQ9gfKj9kNyL8kDNlo9j7kmiyKq8XdQe2ON55SpTiWnctw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8272
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT4NCj4gU2VudDogVHVlc2RheSwg
QXVndXN0IDgsIDIwMjMgMTE6MDIgUE0NCj4gDQo+IE9uIFR1ZSwgQXVnIDA4LCAyMDIzIGF0IDAz
OjQ5OjQwUE0gKzA4MDAsIFRpbmEgWmhhbmcgd3JvdGU6DQo+ID4gbW1fZ2V0X3Bhc2lkKCkgaXMg
Zm9yIGdldHRpbmcgbW0gcGFzaWQgdmFsdWUuDQo+ID4NCj4gPiBUaGUgbW90aXZhdGlvbiBpcyB0
byByZXBsYWNlIG1tLT5wYXNpZCB3aXRoIGFuIGlvbW11IHByaXZhdGUgZGF0YQ0KPiA+IHN0cnVj
dHVyZSB0aGF0IGlzIGludHJvZHVjZWQgaW4gYSBsYXRlciBwYXRjaC4NCj4gDQo+IE1heWJlIHdl
IHNob3VsZCBzdGFydCBvdXQgYnkgY2FsbGluZyBpdCB3aGF0IGl0IGFjdHVhbGx5IGlzOg0KPiAN
Cj4gJ21tX2dldF9lbnFjbWRfcGFzaWQoKScNCj4gDQo+IFdlIGNhbid0IGFjdHVhbGx5IGhhdmUg
bXVsdGlwbGUgU1ZBIGRvbWFpbnMgd2l0aCBkaWZmZXJlbnQgUEFTSURzDQo+IHVudGlsIHRoZSBw
bGFjZXMgd3JvbmdseSBjYWxsaW5nIHRoaXMgYXJlIHJlbW92ZWQgOlwNCj4gDQoNCml0J3Mga2lu
ZCBvZiBlZ2ctY2hpY2tlbiBwcm9ibGVtLiBtbV9nZXRfcGFzaWQoKSBpcyB1c2VkIGJ5IGFsbCBT
VkENCnNjZW5hcmlvcyBiZXlvbmQgZW5xY21kIHRoZW4gY2FsbGluZyBpdCBtbV9nZXRfZW5xY21k
X3Bhc2lkKCkNCmFsc28gc291bmRzIHdlaXJkIGZvciBub24tZW5xY21kIGNhc2UuDQoNCnVubGVz
cyB5b3Ugd2VyZSBzdWdnZXN0aW5nIHRvIGp1c3QgY3JlYXRlIGEgbmV3IHdyYXBwZXIgZm9yIHRo
aXMNCnNwZWNpZmljIGVucWNtZCBwYXRoICh0cnlfZml4dXBfZW5xY21kX2dwKCkpIHRoZW4gSSdt
IGZpbmUuIPCfmIoNCg==
