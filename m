Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B27758D43
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjGSFjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjGSFjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:39:44 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCE8D2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 22:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689745182; x=1721281182;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xWDtPVaPYWyG3hmkIlJgPttDQ8Upc7lDtlzg+MJs5wo=;
  b=FzsAphZ+aRZBXRiPP5iB+HpKHc8GGQILA+l5WtQyLoUDoz4Z0SyIMHk3
   mlXWttH0BXc9YNJu2Tg9GapcplVM6ejpRvOWaxSJpSItjfRnAKso9mECG
   uRej0RhNzqpHSNi6iSrJ/Ey4ui1p572sWrezdIKf8FKsje6fjnHIu0B0k
   wgEy1Gi+3mnYYqiwDgPjeiQJHobjgiJsRbspk8Ij5o/PloZH3wYRPLzbh
   Hp735J1fK1Y9MmTD/a6xwykxFvorquG5ZZo4VHyfV0ah8AjulBtEaZZkJ
   HISoLxXD05nPy7RN4bBh9ZVXxiyYgrL5WYK6NvP1PG9A9cURrlQ8KXaou
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="432559108"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="432559108"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 22:39:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="847934983"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="847934983"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 18 Jul 2023 22:39:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 22:39:40 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 22:39:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 22:39:40 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 22:39:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2VffTQDZklV8RrnhLCSM+97a8Figlaiwj/3w5vkwz+yKW1g5DeXb+kVyAC+ux2pP0daRswCyrbvRBNoBkpDoQkxUcu6POOFKaso31N3qKS22fP+Jgi+zT+egqltxztg5VSXprbbiEc5bM1/lC6zpfm+bg3J9VcDtKnr/c8e28ovY1CUEpQpes1sOoUaCFXmcG27vsbAplwkIHrg/4rgiMEdEQn2Fglbt7nba/fZOKN+rOEyrmmTRKn7SrRWNF5sqCAajjIrkLkmg9pE4sHM/rhjXfs9uKNfHEttgcm3qUExmhd8zQIYULDzJxh30f4m+DJqPq9k5mcMmJN6a5pueA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWDtPVaPYWyG3hmkIlJgPttDQ8Upc7lDtlzg+MJs5wo=;
 b=gSjzwVq2mZHUzVC8QoAr6jZull5x3SL3+mjTQ93S8G6pPSXLnhIDJ+Z6O5MJJwaOCUv4X1T1ddPDzk2Tx7zIh8/B3G+RLl5DBZem/kDvuQ/2JLvpNu98bYPYiVD3arrl4w1YSJGQSQjtxzieH2k+d8f2M0Z2D5r/TdjUZ3C/Ls4YVLreTf3vamzVJkmWULS6yo5jF/Av0kYQR9/OlkoXFb5lkUvLjfk+VQNXJWfFLE8Ivk6sm8kEBDehPcvaSOKVawS5PJj5sZIf+dtTDKZ4+ty2Kj75/+xnXWitqbiMg3TaDijRhUjuLibMJ/tiE0LU237dtfF+SYZg/jMi5B8miA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7106.namprd11.prod.outlook.com (2603:10b6:930:52::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 05:39:31 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::137b:ec82:a88c:8159]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::137b:ec82:a88c:8159%4]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 05:39:30 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Robin Murphy" <robin.murphy@arm.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH v10 5/7] iommu/vt-d: Make prq draining code generic
Thread-Topic: [PATCH v10 5/7] iommu/vt-d: Make prq draining code generic
Thread-Index: AQHZtN37ZjGAjXNxukKTOXN/kBSnIq+3UoFwgAFKNACAAAVf0IAAIXwAgAfYX4A=
Date:   Wed, 19 Jul 2023 05:39:30 +0000
Message-ID: <BN9PR11MB5276CE65DBB24EF838825B628C39A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230712163355.3177511-1-jacob.jun.pan@linux.intel.com>
 <20230712163355.3177511-6-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB52761F5CDE22E5C3C10E7E728C37A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <9875863a-eba5-c8fa-a39b-7d3300e3b5ca@linux.intel.com>
 <BN9PR11MB52763423F2A18E927065C8EA8C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <29fa2860-cbf2-04c8-4d16-138668ffea25@linux.intel.com>
In-Reply-To: <29fa2860-cbf2-04c8-4d16-138668ffea25@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7106:EE_
x-ms-office365-filtering-correlation-id: d9e9d355-450d-4f7e-4d4b-08db881a8645
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kzvMKwzSQFDJTvtjNGf/hJld5AmRH6IImmUPXDSW/SxT+pW+vOE6baqLX8uvqr4f3hlu5/q35alVQPTH6cEFtRqH530YdkOPS5oLTC3aNXBzQ+7VhQlXU3a/AG5BGtLSYbumfgfXQrtVAFbbzFerxo0wtuQ7XtBlQPMtQYPZ56VVnRbOOzAt0HQH9K76AgAbP6CbKQjhkVGTjk5b+Rfc4ihO6j1N2p5Hi+nBVyftvmbyQwXrF38PR6GLSzwmj/Vf309Y7o6kPlaLpD2yW8oprq28cq1SwgMjgg7USLox6/Z4Qq17oNyq8iElpeX9P4ZjLhZ5HkUAewe1anZOBEXi4j9DJhma1MesFv37K1FdD/dMbq+hYu8V02yCSrCze9D4hJbtINeeOOsB1kIfaTq9dx7GWixKupJjlkm5/bJKMaUGHHv6dlTYi1mtoKu4b7ODl99eUGYSGak/nqpZ/nc6nS314zqs4nDAFAGzXk8GiPePL5ej8P3ffKGfymdBM8ECmjMKG3GntxQQKJG0N49L8AfExHU0OGjfoeADncFNKN7jqMU6ErMyboZeJGLuidca13Ou7l5KFXU+txWTrt2u7lADf7+T8H5OZqG9bAsjxSudjX2TCXKzhNEUH9FyEEGDrfQMakkVkMecDlJFUt69fQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199021)(71200400001)(478600001)(7696005)(83380400001)(54906003)(110136005)(33656002)(86362001)(38070700005)(55016003)(2906002)(186003)(53546011)(76116006)(6506007)(9686003)(38100700002)(122000001)(66476007)(82960400001)(66946007)(4326008)(66556008)(66446008)(64756008)(8936002)(41300700001)(8676002)(5660300002)(52536014)(316002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlhPbFkyVnoxMExHdkdOSmlnOXlFTFVxV1VFS0VhT00rbnJFbDNnbzRrbFlH?=
 =?utf-8?B?MlJVdVhEY3Uwa3kyOEVjaWxxMmR1dTZFdUtTb3JmeDFTak40ZGdtUE8rUEEz?=
 =?utf-8?B?SWVrU2dvUlFrNmFJRzIrSDZ4MmRJaE5LdWxlckZkTHJYOWdpY0E4ZElnb2px?=
 =?utf-8?B?VjAxczJKZS9laUVlR2RPR2FKZ3hHb0JzanVWcllIOEhDdHF6eERWNEZ3a05x?=
 =?utf-8?B?RlVIMTB4ZmhOYmY1cytaN0Z3MUlSUlEzOURjMWZqNTNOSVZpVUdweVVqRHAv?=
 =?utf-8?B?dm5TYmR0Wmg4UGd5U0NlUlRuNUNPdWVGaURtb2k5S3BiRmdlLzJKVDQ0M29Q?=
 =?utf-8?B?NXZlN2V3RmdSTldRcjEreGs4NnRGRi9ia3doTW5SQzJqU0ozRDlOdWxqdnBH?=
 =?utf-8?B?WmlYZiszOExyQmNtTmMvVUlkaDZRRWhjZGVSU2lPUWhNTGt6eGtnV2FTbWVx?=
 =?utf-8?B?RUxkbDFna0ZGU0VKT2dSc0gyWmlXL2Y0N0g0cGQ4dlliSlMxdWJWV0FiMzB0?=
 =?utf-8?B?SW9vRTRIRE1TUE5oY0pWeEk0aW55ZktiU2wxdUs5aG11dmJ1YjVuTXRGUHRu?=
 =?utf-8?B?enFVUDBBTEN5VEJCN3FzVzcxekFxYjlyTktPRmpJblhlTUJ5UHVNUWcrVllm?=
 =?utf-8?B?QVlvRWFLdWkyaXE0eVBHbHE2bDdPVGpkZ0M1czIrWW5xSmFIaVpWOHZxVmQr?=
 =?utf-8?B?ekErVlc5ODIweStYZTF2OEZiSmZ3YzVGWTRTYnpHRnlFOENHSnhYU3lWM1Nz?=
 =?utf-8?B?R0UrK0J4cVlBNno2QzhLbHFUcFlGZmNqdjZxcmVLZWpaY09rT3IxOTZUMURO?=
 =?utf-8?B?ZVdNbksyTzVmeTl5KytHTCtpRGNkQzRPbFNsQ1NaL1lrQVRnbUxCZzVNQkYv?=
 =?utf-8?B?R2FIQlg2dEtreHB5UW5qK2FoMHlhaThJaU5jRnJ4eHdBWUhiMkVRQ3p4cGVB?=
 =?utf-8?B?R1NiekkraVFRVjEweExyZ0lLbG9aTHl3ZDdwNHZneDZPNXRmVXhlTmRyVkpN?=
 =?utf-8?B?MEFBRmJjSVlnR3BvMlNLcUJkZ29GelpCZzRJUThtKzN6R2ZXcEFUdk9EY1Mw?=
 =?utf-8?B?RnQrRlY0VDk5VEZuYWFVRnVkQkhGdU5PT1NUNW9OT1pHelgwWFRtNkhCeDlS?=
 =?utf-8?B?VFlFVzZVTm9Fa1RYYzdDcUlMV1FzYVcrVDByY3RCenhYUXUvajRlRWpKTmhy?=
 =?utf-8?B?RUFFYkduanNoVzdRQWloV2dRSE40TktLZkQ2ZnRVZWVjN2dpUkdnd1JBU3Va?=
 =?utf-8?B?SW9nWXJNM29hdmhSaVFXWGxYcUxrTFBTMWtwNWNqN1dQbXBPYUdYcEsrcXlH?=
 =?utf-8?B?TnVVY3ZtUldiUFdUMDF6bTFRQXRSUHRycGVaYTM0QlNxbXBRcWh3VWNUYWN1?=
 =?utf-8?B?cVAwT2g3SWFKUTBZWmlKd3YyN3FhbTg4dkxveG5yVEpzTklDT3ZGQVlFRW9h?=
 =?utf-8?B?KzQ4SmJERjBFNi85bWdlTXJFOGI3eXYyL010bXRjMlFtQmlLeW5yUk51TUxk?=
 =?utf-8?B?TktGVXloOGVMUjUwbG1ObVBlYXo2clFodFd5Z25EKzBaV2VFNEw3aTlVYlYv?=
 =?utf-8?B?U0V1QmpJUGNWeEMrL3RVWkpjSy9YVHNwU3JtajJVb05TQ3B1R3NCVXN5d2FH?=
 =?utf-8?B?QjBkMDV4ZEtsUW4rT2F1TG55ZnBxUnFMK1U0VHZ6cUxPZ2JjWEdEYVJKZkpP?=
 =?utf-8?B?c0s2Q0lzWFFPQUcralQ4ZkQ4Z1owZHBFSmtmanJYUU01cmNvd2R4MXRJZDMw?=
 =?utf-8?B?MGF2WnlHc0c5RTRmNjRCSUYrQWtGNVFJamJTQTc0SE80bWJtamRwSXd0bDBF?=
 =?utf-8?B?Zm5yM2dSVkh2Nnh0WllMUjN1Y0dZVDE1L2lkbERoa2NMMCt0MEV6emRZSWF3?=
 =?utf-8?B?T2p1RzBsZW1VK2FYQU5CQUEvd3pZWW56VTBJUisyM1dNZXBkbU5BUXRUZzA0?=
 =?utf-8?B?N242Slk5UmZaTmdrc1QzbWM0cS81L0t3V3FQU0xIRTdVcU1FYjB1ZW9GdjRy?=
 =?utf-8?B?blBWMXpzV2djUUw2RFYxbTVDQUxHYlRwMXJOT2hiNnlNblVqSDRwMFV0S1hN?=
 =?utf-8?B?Qko2bXJGSFpHcXFoQ0IxR3g1QWtjU21wd2kvdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e9d355-450d-4f7e-4d4b-08db881a8645
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 05:39:30.5689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aRoA63xW6+BGf7gp4NNgZTXmI/DrtoHwU44rN3TP95DbnLqVtPTg1Pb8uD27QgcZ/zPL5BvkiT7RmVlAEV11kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7106
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIEp1bHkgMTQsIDIwMjMgMTo0NyBQTQ0KPiANCj4gT24gMjAyMy83LzE0IDExOjQ5LCBUaWFu
LCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogQmFvbHUgTHUgPGJhb2x1Lmx1QGxpbnV4LmludGVs
LmNvbT4NCj4gPj4gU2VudDogRnJpZGF5LCBKdWx5IDE0LCAyMDIzIDExOjI4IEFNDQo+ID4+DQo+
ID4+IE9uIDIwMjMvNy8xMyAxNTo0OSwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+Pj4gRnJvbTog
SmFjb2IgUGFuIDxqYWNvYi5qdW4ucGFuQGxpbnV4LmludGVsLmNvbT4NCj4gPj4+PiBTZW50OiBU
aHVyc2RheSwgSnVseSAxMywgMjAyMyAxMjozNCBBTQ0KPiA+Pj4+DQo+ID4+Pj4gLQkvKiBEb21h
aW4gdHlwZSBzcGVjaWZpYyBjbGVhbnVwOiAqLw0KPiA+Pj4+ICAgIAlkb21haW4gPSBpb21tdV9n
ZXRfZG9tYWluX2Zvcl9kZXZfcGFzaWQoZGV2LCBwYXNpZCwgMCk7DQo+ID4+Pj4gLQlpZiAoZG9t
YWluKSB7DQo+ID4+Pj4gLQkJc3dpdGNoIChkb21haW4tPnR5cGUpIHsNCj4gPj4+PiAtCQljYXNl
IElPTU1VX0RPTUFJTl9TVkE6DQo+ID4+Pj4gLQkJCWludGVsX3N2bV9yZW1vdmVfZGV2X3Bhc2lk
KGRldiwgcGFzaWQpOw0KPiA+Pj4+IC0JCQlicmVhazsNCj4gPj4+PiAtCQlkZWZhdWx0Og0KPiA+
Pj4+IC0JCQkvKiBzaG91bGQgbmV2ZXIgcmVhY2ggaGVyZSAqLw0KPiA+Pj4+IC0JCQlXQVJOX09O
KDEpOw0KPiA+Pj4+IC0JCQlicmVhazsNCj4gPj4+PiAtCQl9DQo+ID4+Pj4gKwlpZiAoIWRvbWFp
bikNCj4gPj4+PiArCQlnb3RvIG91dF90ZWFyX2Rvd247DQo+ID4+Pg0KPiA+Pj4gV0FSTl9PTigp
DQo+ID4+DQo+ID4+IFdoeT8NCj4gPj4NCj4gPj4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IHJl
bXZlX2RldmljZV9wYXNpZCBjb3VsZCBiZSBjYWxsIGluIGFueSBjb250ZXh0DQo+ID4+IGluY2x1
ZGluZyBubyBkb21haW4gYXR0YWNoZWQuDQo+ID4+DQo+ID4NCj4gPiBvaCBJJ20gbm90IGF3YXJl
IG9mIHRoYXQuIENhbiB5b3UgZWxhYm9yYXRlIHRoZSB1c2FnZSB3aGljaCB1c2VzIGEgcGFzaWQN
Cj4gPiB3L28gZG9tYWluPyBwYXNpZCBuZWVkcyB0byBwb2ludCB0byBhIHBhZ2UgdGFibGUuIFBy
ZXN1bWFibHkgZXZlcnkNCj4gPiBwYWdlIHRhYmxlIHNob3VsZCBiZSB3cmFwcGVkIGJ5IGEgaW9t
bXUgZG9tYWluLi4uDQo+IA0KPiBBIGNhc2UgSSBjYW4gdGhpbmsgb2YgaXMgZXJyb3IgcmV3aW5k
aW5nLiBBIGRvbWFpbiBpcyBiZWluZyBhdHRhY2hlZCB0bw0KPiBtdWx0aXBsZSBwYXNpZHMuIFdo
ZW4gb25lIG9mIHRoZW0gaXMgZmFpbGVkLCByZW1vdmVfZGV2aWNlX3Bhc2lkIHNob3VsZA0KPiBi
ZSBjYWxsZWQgb24gYWxsIHBhc2lkcyBzbyB0aGF0IHRoZXkgYXJlIHBhcmtlZCBhdCBhIGRldGVy
bWluYW50IHN0YXRlLg0KDQpDYW4geW91IGVsYWJvcmF0ZSB3aGF0IGlzIHRoZSBhc3NvY2lhdGlv
biBhbW9uZyB0aG9zZSBwYXNpZCdzIHNvIGZhaWxpbmcNCm9uZSB3b3VsZCBsZWFkIHRvIGZhaWxp
bmcgYWxsPw0KDQpKdXN0IGxpa2UgYSBkb21haW4gY2FuIGJlIGF0dGFjaGVkIHRvIG11bHRpcGxl
IGRldmljZXMuIEkgZG9uJ3QgdGhpbmsgdGhlcmUNCmlzIGFuIHVud2luZGluZyBwb2xpY3kgZm9y
Y2luZyB0byBkZXRhY2ggYWxsIGRldmljZXMganVzdCBiZWNhdXNlIHRoZXJlIGlzDQphIGZhaWx1
cmUgYXR0YWNoaW5nIHRoZSBkb21haW4gdG8gYSBuZXcgb25lLg0KDQo+IA0KPiBPbiB0aGUgb3Ro
ZXIgaGFuZCwgSSBkb24ndCB3YW50IHRoZSByZW1vdmVfZGV2aWNlX3Bhc2lkIHRvIGJlIHRoZQ0K
PiBjb3VudGVycGFydCBvZiBhdHRhY2hfZGV2X3Bhc2lkLiByZW1vdmVfZGV2aWNlX3Bhc2lkIHNp
bXBseSBkZW5vdGVzOg0KPiANCj4gLSBUaGUgcGFzaWQgd2lsbCBiZSBwYXJrZWQgaW4gYmxvY2tp
bmcgc3RhdGU7DQo+IC0gSWYgYW55IGRvbWFpbiB0aGF0IGhhcyBiZWVuIGF0dGFjaGVkIHRvIHRo
aXMgcGFzaWQsIHN0b3AgcmVmZXJlbmNlIHRvDQo+ICAgIGl0IGFueSBtb3JlLiBPdGhlcndpc2Us
IHRoZXJlIG1pZ2h0IGJlIHVzZS1hZnRlci1mcmVlIGlzc3Vlcy4NCj4gDQo+IEhlbmNlLCByZW1v
dmVfZGV2aWNlX3Bhc2lkIHNob3VsZCBuZXZlciBmYWlsLg0KPiANCg0KSXQgc2hvdWxkIG5ldmVy
IGZhaWwuIEJ1dCBjb3VsZCB3YXJuIGlmIHRoZXJlIGlzIGEgY29uZGl0aW9uIHdoaWNoIHNob3Vs
ZG4ndA0KYmUgaGl0LiDwn5iKDQo=
