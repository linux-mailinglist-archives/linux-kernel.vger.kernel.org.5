Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC0F755F04
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjGQJNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGQJNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:13:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D52E9;
        Mon, 17 Jul 2023 02:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689585197; x=1721121197;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8VSuMRaQH3oi2GYCVlhuYoncuCl4ULSg/5HnJMnsv4k=;
  b=iA6YuHmTBd5qgis9tqCfbE87eiaSvN7/ewR6Avmb+NqpzAAw4v4B/YV2
   Sl/Fjkxp/sMNkvazrAiiKjK8AXjdZFLCTQkdplnU5X8dwArcZ3XGwcbVC
   op0QkRo8xIsECXE7X9zLG3A74qRjplRQlE/1rD15L+usByacfzyuaB8/v
   QJosI39UupWTtRkcavdhseumjfallq7v+hCgeb7GOZruybTSgF22mVh+W
   OU5uTA/3IGwE/hR+Akw5/nrMovWYxM/TpPdkdB0ZYC51mFrN7jmfSfNMb
   nEIDYBaFsXn7VZ8MIgefp86v0t7sFZZBQ3uvyZENF4gfOI+MgxYN0ZHLB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="346188830"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="346188830"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 02:13:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="897149675"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="897149675"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 17 Jul 2023 02:13:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 02:13:12 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 17 Jul 2023 02:13:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 02:13:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jweqkBl4O0XOoc28bNL3yqqhZK8miKHyqU9muYyujRCvi9CSxF4eN9jR+Gf+HBUwE2EXXTUSfeZ5POFL+d4LKXu9ni/2nhz/821LCHWWSSp5n+BWBD+J4BCedbgcjM1Zap5qFzydOgzbu7x2qS0sDpvXp9cRpfchdcBHGjWy01wPmaF8XPCDf4fhfAYQqpc/X0WMFtEhAW+KiLfz90sE2zf67tadFE4g3dO7AeroGjUALx97scwq8T9fhNf0q2efjIsQB5DUw6xNXw2InUSslyujCPXTfytKkgySdwU6KHz0P5hy/i0gSP+HisHTfRMkItYazVyFL28g8dqgb5SAkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VSuMRaQH3oi2GYCVlhuYoncuCl4ULSg/5HnJMnsv4k=;
 b=AETvSGdFVWZJc3c9C1zxwP+jigT0KG0fd4ali9EPI/qmzP8SYN53XhVs7ITD0/es9yaZ2SOPxm7txV9CY4u0cW5mY6OcdLdB1T/PXPi7aZtiEimPUQvLijvGqenDMvw565DQX1aW7om++2tjGEMF/pfwV4+QcRktJXNBRRTbYp44kyf5kRu68NZeUm5zfdwCSmbwe43DI5zr+Oe0eoBXDuFO+qR9qh59m7sweVNDT7V0Vo9a4Q0wBPKolMzOaZSzFtDgo3Bqf1xDgSWrYCBVwIK/OCg6eFHSYUEOCR9yKTLUtKN6TQEXT2cNbKpg8ykxNaj8FK0U/XpdQ3BDKZCpDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by MW6PR11MB8391.namprd11.prod.outlook.com (2603:10b6:303:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Mon, 17 Jul
 2023 09:13:09 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::2bc0:5e18:b0e6:6477]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::2bc0:5e18:b0e6:6477%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 09:13:08 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>,
        "David.Laight@aculab.com" <David.Laight@aculab.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lkp <lkp@intel.com>
Subject: Re: [PATCH] powercap: intel_rapl_tpmi: Fix a sparse warning
Thread-Topic: [PATCH] powercap: intel_rapl_tpmi: Fix a sparse warning
Thread-Index: AQHZrjTUdRBqHuqNhkCBNaxLsH1JTa+06qCAgARopICAABJWgIAEW8cA
Date:   Mon, 17 Jul 2023 09:13:08 +0000
Message-ID: <8eb14700c23828be1c0086ad004dfa1840926818.camel@intel.com>
References: <20230704050238.712223-1-rui.zhang@intel.com>
         <CAJZ5v0gZz1RCqp=Do0RTOCwPvWW9E_SQSyFjuRVuBkR9jxCJjw@mail.gmail.com>
         <a6d032df2b664950a63518c83a7db3f3@AcuMS.aculab.com>
         <CAJZ5v0hu2Gimbxv+RSQVRyLXOPSCNSzQDdneS8ig4zn63VkUKA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hu2Gimbxv+RSQVRyLXOPSCNSzQDdneS8ig4zn63VkUKA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|MW6PR11MB8391:EE_
x-ms-office365-filtering-correlation-id: 297fe6fa-74f1-4aa1-45f1-08db86a60964
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wfPODnlwZmsA41y2IPGtTau4baARLqYAzMKkE8iWJIJIgpSEEyce3D4JApu24B+eTzg8iuc/dLKlOegBjpNIrwtUq26CrWmdO2z7QkreSd573MH40Yy1Ct4CTloOsKocgJe9256HgXiRFa7TiHNJ4hrj0Znuh936dJDiMSfRrR9FYQsw7NAq8GUf5YWtDZ3AI+8m0ueiR/DDoumCuWLLj5qM0gXdf5Tu4Y7GES4BE/9oRJFqY+q1lmOfZ/tO1QUJsrH6w9BRGyFSFQTzsLSGgfhNBIAnPBDuXesYprr2/OTziRxwq0EL++GBq+0Ip092efVWB6mfCJaZiqhqGtJgnt/WmcVtxrULApupSG64bVSKigBwduRRknPlK9HRed3glQ52tnCBfLE0t4IynWf/y1dWc2MhzfObpqC1fUs4NDUEDBxNMtBbT6x38oe7YzntmMInZfS+dkbhOlCz/YYRMo0kkQgRBrDlCxZzm5OBmP3W2U2ym8nqtq+alLfnGRxbXm7zKqmWaQGDHaR9q/nEGh6YaGx/rP/KmAudHq8JzQLBI12gswcQ+TBf2HqPnjmTix72BwHCkWmBEOnMU0g8dQZfGDmvLLEfs7oPxNWsmP4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199021)(2616005)(71200400001)(966005)(478600001)(6512007)(82960400001)(6486002)(86362001)(26005)(107886003)(6506007)(36756003)(53546011)(38070700005)(316002)(66556008)(8676002)(41300700001)(91956017)(4326008)(54906003)(110136005)(122000001)(5660300002)(2906002)(38100700002)(66446008)(66476007)(66946007)(76116006)(186003)(64756008)(8936002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eU9TaVJ2ZGRhdk1YUFhNaURvL3NtK0xwR1hRMUhIblpBdUlRaC9sV1RzRFVX?=
 =?utf-8?B?TXUweXpMaytNU29EL2tWb0FWMzBzTzQ4ZzBWT21Yd28vbVlJdGNtNGd6UEZ5?=
 =?utf-8?B?WW9CMDJDWE5kdjg2cW9IV1BFRjJKL2N5M05NWTZnR0U0blE5dDdpTDlxRGNv?=
 =?utf-8?B?bTJyeEI1T29ZSTRNTlk2dHFpUTFnNVppL0xBVkRBRk9WaVZVdEpPdzVxU0VY?=
 =?utf-8?B?bFZhaC90TllyTWQrYUFLMWdUVm5QbzdDc3NBbmJwendCZUM1Y05CV1JLc3g0?=
 =?utf-8?B?UDR3V1JHZ2pKS2x4OHk1WC80bVpPVkFXeWI4bTZyTlptQ3k4eUhWU05rWm04?=
 =?utf-8?B?YTh1blFLa0dxbGNMUGNINmF4TmJJN2g2dEhUYjBHL0IxTC80dDBoYTd1cFAw?=
 =?utf-8?B?YitXeFVhVGVBWW05VFhuSU4xRnV5OUJXQm5JNWJUb1BlYklwb1BieldBVDRR?=
 =?utf-8?B?M05tdmVLcDNsZXA5ZlkrZnl0RTN0TFo3VW13NDMyL1dHOWtHY3lQOU5Xb1d1?=
 =?utf-8?B?NHUrL0J2eHVodmhwY2JVRFg2VktDSlhERE56Q3ZnbzhzRy9BbWxlSldjU3c4?=
 =?utf-8?B?bEVObSs1Sk1oeTA4bmxIbXpoZE53R3J5YTFTU0RKWlNSWkg4OVVTK3dXdld3?=
 =?utf-8?B?dHJCTDdIUjVMWWxTK3k0Vk1NYTc3cnczYTBsNGZQamVuVHJIbWpOUXh3WEtW?=
 =?utf-8?B?R2FzQk1DOUVMc0NDQzJjalpOSzdvN1paZVE4bTN0OVdBVFovTXQvU0lqR3FG?=
 =?utf-8?B?RmFDb3F6V0s3U25ST0FhdERISzFjL2lEOFlhUVQxQk51TjNOa0lWU0R1d0J0?=
 =?utf-8?B?L1BvYy9NNFpFU2MyenI4VEpvNDBnZWM1SnpiRkhLZzFjc0xHRzR0UmlHMkRu?=
 =?utf-8?B?aUZ2Y2V6QjlOTXlXOFNmUkdnRzBvMEM2U2Fyc01BeDVIVTU0ZS9mcHpNTG5L?=
 =?utf-8?B?YTc2dUlFajBtd2dWbU15V1grWkpYWGVPS01UZWI1em13ekFLNDBsNUJ0eU1o?=
 =?utf-8?B?WE9pazQ1VXBXWldZVWQrNXJyWTd5OCswWDNlOW14MFlQNzhDVVd0NmVJWjRz?=
 =?utf-8?B?ODBNaVZSekZEcTZKWE91SG9mcThRZE9MMStZU3lieVdqTThoYnE1dGVVNmFt?=
 =?utf-8?B?VUlaL2Z0aGxsSkpKNVlMYjJmRytsVHU4WEdpYllGaEtXNDdSV3FwZVZwMjdn?=
 =?utf-8?B?YlZKRnV2b1NPa1VCUm81TnlMMlR0R29IWFNPMVpXeTh2NHZOS0RNTi9lTDF2?=
 =?utf-8?B?cStrU2hyYjVaL0xVWURpdkhINE9LbjJuWU0wYkdXNkxKZnBuc2QzTU9DaHVO?=
 =?utf-8?B?S2hzanVoMWVkYWVCYzBpTURKNENZWmhkbUxwOUY4dFlEdGNpSWxtUEpENVIv?=
 =?utf-8?B?Skk0RDg2azRxM0hneVZSNnJScjJrcjJZNmZoWGN3aHRRcmtNRmFOeTU2R09u?=
 =?utf-8?B?TVFnK0JhN21JZzVkeVlmMmx6S3AyWTlLN0ZXN3NMb0Q4ZU1kNjgrZVR4Vy9I?=
 =?utf-8?B?cE1FLzlZZ2xNK3dNbWJPZVVTRFlJUFZISGh0eUZTKzFZcm9JNnBUd3hZNjVz?=
 =?utf-8?B?djdMeC9NeGpDNWU1aDYxY2JuMDV0Q0hGM0xvbldvM05FMHJLWi9xUSswa3dE?=
 =?utf-8?B?S1lNQmlBWk9yZlhPZFRseHdFdTNGZkMrSTBsWU5wMk9DSnNaZGZ3NCt4M3dU?=
 =?utf-8?B?KzdPTEpXd3IySE5YT3A3Q2FRcldOaUsyVzduQXlNTkorTDQ0a3ZmVWlDelBI?=
 =?utf-8?B?T0NhaEpnNkM1bHJOR3ZuOERaSEhFV1h3SWVtdU15T3Fic3laWUM4NGNNUXhV?=
 =?utf-8?B?MXNRZEFvblNnSUorY0NMWlBjVTVjVGJjYi8rVmZ6ajdpdjJPOTlhS0NJa25V?=
 =?utf-8?B?ZXZ0UmNZZllSc05pdzJHM0RaL2pnd2FFbWVLM25Eay9yWjBYVVlkNHMyMk1J?=
 =?utf-8?B?RUFNQmFzdXJYSUFLS3Q4UzN0ZStzb1FqR2N2enBBRDk4eUJaWTJyTnBiMzhH?=
 =?utf-8?B?eXlVWTJFYnVUdUxvdU83Z1liTkhlWkVMR3RSM2pHTW1ka0JoTk9aQlA3TmF1?=
 =?utf-8?B?UXAxcVpUclBNRTE0blEySWlEN0dYcFFrbkxrV1NuUDNOb0VMalVZSU5QRUZv?=
 =?utf-8?Q?XnLe+4d8SKyXMLGFF3ew8OJh9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5DF2680806C7947A142351DC76F45C0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297fe6fa-74f1-4aa1-45f1-08db86a60964
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 09:13:08.3056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9926eaPNMPanqJfAGhiGRZfLhEs/iRjQWLDC2ykv9dd08GaEjP6hwILThqat/WPbyHEgwn3tnIv2MJ0Ux2/Feg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8391
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

SGksIERhdmlkLA0KDQpUaGFua3MgZm9yIHBvaW50aW5nIHRoaXMgb3V0LCBhZnRlciBkaWdnaW5n
IGludG8gdGhlIHByb2JsZW0gZnVydGhlciwNCkknbSBjb25mdXNlZCBhYm91dCBob3cgdG8gYWRk
cmVzcyBhbGwgdGhlIHNwYXJzZSB3YXJuaW5ncy4NCg0KSW4gdGhlIFJBUEwgZnJhbWV3b3JrLCB1
NjQgcmVnc1tSQVBMX0RPTUFJTl9NQVhdW1JBUExfRE9NQUlOX1JFR19NQVhdDQppcyB1c2VkIHRv
IHNhdmUgdGhlIFJBUEwgcmVnaXN0ZXIgYWRkcmVzc2VzLCBiZWNhdXNlIHRoZSByZWdpc3RlciBj
YW4NCmVpdGhlciBiZSBhIE1NSU8gcmVnaXN0ZXIgb3IgTVNSLg0KDQpXaXRoIHNwYXJzZSBlbmFi
bGVkLCB0aGlzIGJlY29tZXMgYSBwcm9ibGVtIGZvciBNTUlPIHJlZ2lzdGVycyBiZWNhdXNlDQp3
ZSB3aWxsIGdldCBhIHdhcm5pbmcgYW55d2F5IHdoZW4gc2F2aW5nIGFuIF9faW9tZW0gYWRkcmVz
cyB0byB1NjQNCnJlZ3NbXVtdLCByaWdodD8NCg0KVGhpcyBwcm9ibGVtIGlzIG5vdCBuZXcuIFRo
ZSBzYW1lIHdhcm5pbmcgaXMgYWxzbyB0aGVyZSB3aGVuIGNvbXBpbGluZw0KZHJpdmVycy90aGVy
bWFsL2ludGVsL2ludDM0MHhfdGhlcm1hbC9wcm9jZXNzb3JfdGhlcm1hbF9yYXBsLmMsIHdoaWNo
DQphbHNvIHVzZXMgTU1JTyBSQVBMIHJlZ2lzdGVyLg0KDQpBbnkgaWRlYSBob3cgdG8gZml4IHRo
aXM/DQoNCnRoYW5rcywNCnJ1aQ0KDQpPbiBGcmksIDIwMjMtMDctMTQgYXQgMTY6MzkgKzAyMDAs
IFJhZmFlbCBKLiBXeXNvY2tpIHdyb3RlOg0KPiBPbiBGcmksIEp1bCAxNCwgMjAyMyBhdCAzOjM0
4oCvUE0gRGF2aWQgTGFpZ2h0DQo+IDxEYXZpZC5MYWlnaHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+
ID4gDQo+ID4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kNCj4gPiA+IFNlbnQ6IDExIEp1bHkgMjAy
MyAxOToxNA0KPiA+IC4uLg0KPiA+ID4gT24gVHVlLCBKdWwgNCwgMjAyMyBhdCA3OjAy4oCvQU0g
WmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+IA0K
PiA+ID4gPiBGaXggYSBzcGFyc2Ugd2FybmluZyBpbiBpbnRlbF9yYXBsX3RwbWkgZHJpdmVyLg0K
PiA+ID4gPiANCj4gPiA+ID4gLi4vZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsX3RwbWkuYzox
NDE6NDE6IHNwYXJzZTogd2FybmluZzoNCj4gPiA+ID4gaW5jb3JyZWN0IHR5cGUgaW4gaW5pdGlh
bGl6ZXINCj4gPiA+IChkaWZmZXJlbnQgYWRkcmVzcyBzcGFjZXMpDQo+ID4gPiA+IC4uL2RyaXZl
cnMvcG93ZXJjYXAvaW50ZWxfcmFwbF90cG1pLmM6MTQxOjQxOiBzcGFyc2U6wqDCoMKgDQo+ID4g
PiA+IGV4cGVjdGVkIHVuc2lnbmVkIGxvbmcgbG9uZyBbdXNlcnR5cGVdDQo+ID4gPiAqdHBtaV9y
YXBsX3JlZ3MNCj4gPiA+ID4gLi4vZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsX3RwbWkuYzox
NDE6NDE6IHNwYXJzZTrCoMKgwqAgZ290DQo+ID4gPiA+IHZvaWQgW25vZGVyZWZdIF9faW9tZW0g
Kg0KPiA+ID4gPiANCj4gPiA+ID4gRml4ZXM6IDllZWY3ZjlkYTkyOCAoInBvd2VyY2FwOiBpbnRl
bF9yYXBsOiBJbnRyb2R1Y2UgUkFQTCBUUE1JDQo+ID4gPiA+IGludGVyZmFjZSBkcml2ZXIiKQ0K
PiA+ID4gPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+
ID4gPiA+IENsb3NlczoNCj4gPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvb2Uta2J1aWxk
LWFsbC8yMDIzMDcwMzE0MDUuZHkzZHJ1dXktbGtwQGludGVsLmNvbS8NCj4gPiA+ID4gU2lnbmVk
LW9mZi1ieTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KPiA+ID4gPiAtLS0NCj4g
PiA+ID4gwqBkcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxfdHBtaS5jIHwgMiArLQ0KPiA+ID4g
PiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4g
PiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF90cG1p
LmMNCj4gPiA+ID4gYi9kcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxfdHBtaS5jDQo+ID4gPiA+
IGluZGV4IDRmNGYxM2RlZDIyNS4uMDVmNjY0YTA5NmFiIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9k
cml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxfdHBtaS5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMv
cG93ZXJjYXAvaW50ZWxfcmFwbF90cG1pLmMNCj4gPiA+ID4gQEAgLTEzOCw3ICsxMzgsNyBAQCBz
dGF0aWMgaW50IHBhcnNlX29uZV9kb21haW4oc3RydWN0DQo+ID4gPiA+IHRwbWlfcmFwbF9wYWNr
YWdlICp0cnAsIHUzMiBvZmZzZXQpDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIGVudW0gdHBtaV9y
YXBsX3JlZ2lzdGVyIHJlZ19pbmRleDsNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgZW51bSByYXBs
X2RvbWFpbl9yZWdfaWQgcmVnX2lkOw0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBpbnQgdHBtaV9k
b21haW5fc2l6ZSwgdHBtaV9kb21haW5fZmxhZ3M7DQo+ID4gPiA+IC3CoMKgwqDCoMKgwqAgdTY0
ICp0cG1pX3JhcGxfcmVncyA9IHRycC0+YmFzZSArIG9mZnNldDsNCj4gPiA+ID4gK8KgwqDCoMKg
wqDCoCB1NjQgKnRwbWlfcmFwbF9yZWdzID0gKHU2NCAqKSh0cnAtPmJhc2UgKyBvZmZzZXQpOw0K
PiA+ID4gPiDCoMKgwqDCoMKgwqDCoCB1NjQgdHBtaV9kb21haW5faGVhZGVyID0gcmVhZHEoKHZv
aWQgX19pb21lbQ0KPiA+ID4gPiAqKXRwbWlfcmFwbF9yZWdzKTsNCj4gPiANCj4gPiBJc24ndCB0
aGUgY29ycmVjdCBmaXggdG8gYWRkIF9faW9tZW0gdG8gdGhlIGRlZmluaXRpb24gb2YNCj4gPiB0
cG1pX3JhcGlfcmVncyBhbmQgYWxzbyByZW1vdmUgdGhlIGNhc3QgZnJvbSB0aGUgZm9sbG93aW5n
DQo+ID4gcmVhZHEoKSBsaW5lPw0KPiANCj4gR29vZCBwb2ludC4NCj4gDQo+IFJ1aSwgY2FuIHlv
dSB0YWtlIGFub3RoZXIgbG9vayBhdCB0aGlzLCBwbGVhc2U/DQoNCg==
