Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB447810829
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 03:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378448AbjLMCVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 21:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378434AbjLMCVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 21:21:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6C011F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702434021; x=1733970021;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=clXWK84a4TGJmD8A00ncFrtV2enRf3Cs/PFyDRcFPYc=;
  b=Ji1eWF0UFSfIg4M6yT7BDOUdJz/wYoWqY1vpweP7qou3+Ks0Z+rZ1cMI
   ayULnGFFgCnAEsx3jzdAitZRQiOZTs4NTu8mBEiJP8kff1zL+xv52RUNE
   N3ri5zkkoVmr0DNmzAmpjC1G5fl4OdGnSvo45W24UBxKW4YP/DDrQqp17
   pG0zYCz78MxyEIFJ3wCoxETv8Dtdr9LmkWAM3zs6qO7pPNzkz1oYleIhv
   J5fkGwbf1cUfD/iRfzX/PoWclGbZGJCy6yM3UcQo3kMlwbTETo6fjs5nv
   0n737CfKwQiRmEU8riS547C7/y4dESO/O0N///K7byYmOzYATFOPCbPz5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="461377060"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="461377060"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 18:20:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="723467220"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="723467220"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 18:20:19 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 18:20:18 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 18:20:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 18:20:18 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 18:20:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aF6O5akNoCgK3SB4o8ScD34ZrwQ1wr/76bous1+xgmC/RV/xe8E5q8MpH52dkqL4XvrlnKYfGflZXsmX3ILPqp9pfx2oykNxis776XC2cHoIvHSKKwYE9bIeVmh/TOUYGdh1JoJeo+Bs6V06+xKQGjz9FLpaFo2ktMav6t6YvW+fbAZZ6DGZtCO8tavdZ1EI06bbizo4fgjuAzy+kpBMUB29sIHqGyropxhUSQXYIkgbXecMKA4tw6+ZhZALewJ0vdegRmmS8+c8ANO39vQgP0COpxWLcEM7vNTCFG1lbjFzydzJPlXvI8VdJAciFKeYOiHAY2gLrlBLmnNP0HWFpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clXWK84a4TGJmD8A00ncFrtV2enRf3Cs/PFyDRcFPYc=;
 b=lD+8bbvoQIQYR8l2In7aQSk2B9z7AybBBOuNBvIVFm0Ad4HGHkj5CGASWcN4MAdPCpsIUWkzDu79uG9/T9XzorbjcLQ8+kcdyha/0NysjJLMlRBEpKp9pGeNjp0i1BR2Bi0pCwlAvz9rL5QooqjG5jcRkg2cbTwL7Sw4Oy4V1bBjddbqpUe5chE6CjIkKIK3SC1n7UKW+Bw9G9Mle+RmwxuJifdFkOCR3rA2m1hCk63hc3SxuZV4Lc26JG0GEbH7HcRPM8EyJ2zgqXfUgso5XDe4xXTxEeVO5eGC5oKkhwLR9SRVSD121RhV8ie5cR2z4ACOSgoErWa8TNROeTzn7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CYXPR11MB8732.namprd11.prod.outlook.com (2603:10b6:930:d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 02:20:11 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 02:20:11 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/6] iommu/vt-d: Remove 1:1 mappings from identity
 domain
Thread-Topic: [PATCH v2 4/6] iommu/vt-d: Remove 1:1 mappings from identity
 domain
Thread-Index: AQHaJxojfGMimdGl20KFwsu2wXzMo7CfGuwggAA/2YCABB9PUIABvnIAgAFOBFA=
Date:   Wed, 13 Dec 2023 02:20:10 +0000
Message-ID: <BN9PR11MB5276614392E99F75B6A592C68C8DA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231205012203.244584-1-baolu.lu@linux.intel.com>
 <20231205012203.244584-5-baolu.lu@linux.intel.com>
 <BN9PR11MB52761FF9AB496B422596DDDF8C8AA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <1161d8aa-9fcc-4e9e-a7d3-c461fee19a54@linux.intel.com>
 <BN9PR11MB5276AC40C423A0BAAE9F40A98C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <bef0f903-3665-492f-8999-fe759be5fed4@linux.intel.com>
In-Reply-To: <bef0f903-3665-492f-8999-fe759be5fed4@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CYXPR11MB8732:EE_
x-ms-office365-filtering-correlation-id: bfceada8-f2ff-4907-abed-08dbfb820881
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f9mbQKB2AIwx3fUGKT/Is1rzM744jFYvWZuSz+ysxG0xj424eAQ1e6e2CuBtzzGu8U3ti4gkt/dHuTuuYEEDQl0jM9V8FY7mJC4QfXsn4xEubH0lLmge7BphDs/f9oaNkpM9k7sfsMNvVVnOVCU95FT3uoGhf/JIf/5KpVYlNV2sqKSH3VZDk4idGF7aFmc59R+Es+5A/EgocMncMi+GeSjINtUr8wTRB/i4CmdOdFuI3/35FvMbEkHfFxB7ZMjEJfUPgt77pQU6kkMGAOfaLN0Evc/9JpjyY3IjSobjRTOq/ju9oO6I7dMKxltAjZ0RT9KUS4jqchOWKxS/1uv/t8MlUR1COeQiH0osDgawTq285E54nXa1REssEewvJFH+UApFSPCzlkuWwS+chRe2DUq8KSkgSu80Io23kcjXU25B/zcR80LRUbOUuYwli9iohmGDsfVhDNotdiVhQKnMm0S/8KMa2ye/6Daoj8jGkAaB6XZPY8iLBqUrm6ULSZ+AZ5h2qJAX/el/9s4vMA87jSzZAwtgzLC+7ep2/7P3dH9g/q5vzyeKavL855QSMWvFEXqPDEOa1qTwWhTQE72oHghCQ0KRdUmkppTJ7uk7ZjFRmgiGvECvwLgQh/hmnvpd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(33656002)(86362001)(38070700009)(55016003)(64756008)(66446008)(110136005)(7696005)(478600001)(41300700001)(54906003)(76116006)(66556008)(66476007)(71200400001)(66946007)(6506007)(82960400001)(26005)(38100700002)(9686003)(122000001)(2906002)(316002)(5660300002)(8676002)(52536014)(4326008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTdFTkQ3TkN4UUtXcDBrYjEzQUwyWUdWQnYycmxjVThZaWJrU1NFSG9zRWlZ?=
 =?utf-8?B?L2dGYWUzMCtQNTJqYzlwRDh2UnJsLzFTcGNFUnFqMjhsdCtSMEI4ejFvMTdP?=
 =?utf-8?B?VmhaSGRqVFJKMTJHNTlnNEJTK0IrU2tnbVMwVUc3L0dGUDFmNU1IMUNmYWtw?=
 =?utf-8?B?bVhkdENSSDdJNno0Ykc0SUxMSUVodzJJRHN0YXJKMDNTN2FpL2xGWEttZEhS?=
 =?utf-8?B?U012SWNGNHJ1d2JxTnNVZEJEWjVWTFhjSHppSityV1poZnFtY1FwU2JEZkJt?=
 =?utf-8?B?cmo0T3I2SHp3TG84TzlySHh2cFd1OEgwNTJ0VEtmUzEzclJUTDRCVTl1a3V0?=
 =?utf-8?B?Rlo4YWxNdWJNc0VqajJDTDNNYUdLdEZCR1J2Uzh3ZllTS25tNDlhVmwzc3kx?=
 =?utf-8?B?Y2FxN2xjanZiSlBnWlgxblQyT2tFQWlMdkxkMTBQSFlZZ3AvVXFlblM3V0pm?=
 =?utf-8?B?U0xGY3kxUzNxR3NLQ1JTVzNJMGNpVmJBWmx4d3UrcE90MDhKbmhZQjVWcjEr?=
 =?utf-8?B?eGtuelRZc0trYmU1aXg1eXE2cjJzN3BzN2VFTnVzVTRIVVRGWlZhaWtHK0U3?=
 =?utf-8?B?c0MvKzB0eGdwdmNHRTNWU2RmVDdqVnFRV24xYjhHNGtrdXNGMmUxOFMxRDk1?=
 =?utf-8?B?cjNyVGpYR3IvamhDUTYyeHdrMlE0TjdELzlnNlYvb0VCZVlsZ2FEcUd4Q3U5?=
 =?utf-8?B?cFVBbDZQYk1NUjEvZ3dTRlBLZWs3SktnRm1GQ1pDSU1NbFQwNUF1bGk1aWhv?=
 =?utf-8?B?cS9vcGhFcWRYb2cvdDYvcnoxMXNDOG9WcFF0eXdzSGNBbG1QV0ZaUThkTER3?=
 =?utf-8?B?NmtRV0dmNHo0aDdTWWVIUVpmMnFBY2F0YXQvRmwwQnZjMWZXMjNyRkJRRTZN?=
 =?utf-8?B?d2RnQjR6cndiRDI2aHlLTkVRUUlrVndNTzF6RzluNkZtSEFDcm9aQzdGNVcx?=
 =?utf-8?B?VkpObzA0SUlwVytVcnJuT05VUzNzd2VwUFdLV1lvQzYvV3cwakRzMjk2NEg4?=
 =?utf-8?B?dWduL21zcU5tZy8ycFlWdk5FblN4OU5ObGRKV3JPZ1YxNUJ6cTdWekpQWlZF?=
 =?utf-8?B?RkJhYzE3RmpuNEp3ZFJWL213K25nMVNhRnhjbmUxdi9UOU1wczF2WE5ha0t5?=
 =?utf-8?B?bEtZL1BqcVpoMWpQemZ4S2NiTzRxUzZxZ3VNUzU3U243ekVmOU05cGJ4eVkw?=
 =?utf-8?B?RThrNGV0cUdITjlXVXhhMFJvZnR2SzhqNEZ0ait1TVcyN3BObE9GNGJTV1Vp?=
 =?utf-8?B?TTlZcFUzSkVNWm5NcEp3dzQyb3ZnZ1FwdWtiakZTQUtWUDlScTJHM3J6Sjdn?=
 =?utf-8?B?RG1yekNCc1hhTFVlbUFpbys3Snp3SkNDdTdwYlcySUFnUVZQbzZLNy9QT3du?=
 =?utf-8?B?Y1lHWitsNkJCS1ZwWE5UV1dzZ1Ayc1NRVUFDRXlESjgvZUxtUWROcldzRW44?=
 =?utf-8?B?eFlOS29ibkJtbEpqSU5SUWdnZ01wQ0ovVW1CREhBTnljVTF0L1U5bWh5TGto?=
 =?utf-8?B?ajVxdENoL28veDg5eDJWTHJWYlJwT3kxTUdhN0p2MG5mRzltUTMzSmEvSjB6?=
 =?utf-8?B?NjArOC9MRHFiKzBVcUxKajF2RW1BSy9TeW5ESXB3K08rSVNDdHhhNk0xY2FO?=
 =?utf-8?B?L1laNGlzR3R5NWR1Ky9DQXFGckhDZEZwa2xtYXgrd25FYkVSNWg5WmFyamZY?=
 =?utf-8?B?TTFZZEdtMDVxOENhK3FGZ0k3YU0zdkdVcThick5pcmNtbSttQzI1V0g4QXM0?=
 =?utf-8?B?ZkxtUUVCaXNmM0FHdnh5bnhNVDAxL0kxUnhkL1pwRmlaMEtHQUhYYnVDMld5?=
 =?utf-8?B?cDF5N21rQkY3TVRDd1Y2OW5NaHJFenBLTUNoL3RaZkg0V1ZubUV2S0lhWW5Z?=
 =?utf-8?B?YVBjQis3QVI3bVl3WkhpZFB4VjN0dU9MUHBzUENhVlJwQ1EybVpmRjZaMVZC?=
 =?utf-8?B?amxJSi9rL3NzQW9Vc0cwSGl1R0tXb2psOXI4V2NrdFc4YXM1eFVLRjBHZ2NU?=
 =?utf-8?B?UGxQRXJiR1B5THgvcmh2NXlCSTh6bFFrVzJYbVJFNW1IQ1hoYVlyUEQ4RXBF?=
 =?utf-8?B?MkJ0RVVaUG1Oa2o0dVNUZTdVLzFWWHl2OG1UNUZuR0pnL1o3bVIzS3hyS3ZM?=
 =?utf-8?Q?kQmYspEa63V0Q1LdjRA2/dwq1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfceada8-f2ff-4907-abed-08dbfb820881
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 02:20:10.9710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tNJqtWc89/gDwLRMH2IFykINziemdpuZq07oiwuh9tQNiZibEf4jM9cblI8MTsGbQVP6jKAe+6s8hkcC0hTuMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8732
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

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBEZWNlbWJlciAxMiwgMjAyMyAyOjIxIFBNDQo+ID4NCj4gPiBGb3IgR0ZYIGl0J3MgYSB3
b3JrYXJvdW5kIGFkZGVkIHNpbmNlIGRheSBvbmUuIHRoZXJlIGlzIGV2ZW4gc3RpbGwNCj4gPiBh
biBvcHRpb24gQ09ORklHX0lOVEVMX0lPTU1VX0JST0tFTl9HRlhfV0EgYXZhaWxhYmxlLiBCdXQN
Cj4gPiBub3cgaXRzIG1lYW5pbmcgaXMgcmVhbGx5IGRpc2FibGluZyBJT01NVSBpbnN0ZWFkIG9m
IHVzaW5nIGlkZW50aXR5Lg0KPiA+DQo+ID4gc291bmRzIGxpa2UgSURFTlRNQVBfR0ZYIGNhbiBi
ZSBmdWxseSByZW1vdmVkIG5vdzoNCj4gPg0KPiA+ICNpZmRlZiBDT05GSUdfSU5URUxfSU9NTVVf
QlJPS0VOX0dGWF9XQQ0KPiA+IAlkbWFyX21hcF9nZnggPSAwOw0KPiA+ICNlbmRpZg0KPiANCj4g
V2Ugc2hvdWxkIGFscmVhZHkgcmVtb3ZlIHRoZSB3b3JrYXJvdW5kIGZvciB0aGUgMi42IGtlcm5l
bC4gOi0pDQoNCkkgZG9uJ3Qga25vdyB3aGF0IGhhcHBlbmVkIHRvIGlnbm9yZSB0aGF0IHRlbXBv
cmFyeSBvcHRpb24uDQoNCj4gDQo+IEl0J3MgZGVmYXVsdCAibiIuIFRoZXJlZm9yZSwgaWYgYW55
IGdmeCBkcml2ZXIgc3RpbGwgbmVlZHMgdGhpcw0KPiB3b3JrYXJvdW5kLCB0aGVyZSBzaG91bGQg
YWxyZWFkeSBiZSBhIGJ1ZyByZXBvcnQuDQoNCkl0IGRlcGVuZHMgb24gaG93IGl0IGlzIHNldCBp
biBkaXN0cm9zLg0KDQo+IA0KPiA+DQo+ID4gCWlmICghZG1hcl9tYXBfZ2Z4KQ0KPiA+IAkJaW9t
bXVfaWRlbnRpdHlfbWFwcGluZyB8PSBJREVOVE1BUF9HRlg7DQo+IA0KPiBTbyB3aXRoIGFib3Zl
IGNsZWFuZWQgdXAsIHdlIGhhdmUgbm8gbmVlZCB0byB3b3JyeSBhYm91dCBkcml2ZXJzIHRoYXQN
Cj4gYXJlIG5vdCBjYXBhYmxlIG9mIGhhbmRsaW5nIHJlbWFwcGVkIGRtYSBhZGRyZXNzIGFueSBt
b3JlLg0KPiANCj4gRGlkIEkgbWlzcyBhbnl0aGluZz8NCg0KSSBwcmVmZXIgdG8gcmVtb3Zpbmcg
SURFTlRNQVBfR0ZYIGluIHRoaXMgc2VyaWVzIGFuZCBwdXQgYSBjb21tZW50DQpleHBsYWluaW5n
IHdoeSBBemFsaWEgZGV2aWNlIGhhcyBubyBwcm9ibGVtLg0KDQpUaGVuIHNlbmQgYSBzZXBhcmF0
ZSBwYXRjaCB0byByZW1vdmUgdGhlIEdGWCB3b3JrYXJvdW5kIG9wdGlvbi4NCklmIHRoZXJlIGlz
IGFueSB2YWxpZCB1c2FnZSBzdGlsbCByZWx5aW5nIG9uIHRoYXQsIGl0J3MgZWFzeSB0byByZXZl
cnQuDQoNCg==
