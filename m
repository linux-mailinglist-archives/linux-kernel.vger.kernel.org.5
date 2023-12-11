Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D9E80C030
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 04:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjLKD6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 22:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLKD6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 22:58:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21508ED
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 19:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702267124; x=1733803124;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VLBqNO4P3GHJOzDpD9QhiFYC0CUTMLTTHTAwCDfN1OA=;
  b=ZolLT6D9I3bCNZePHVSuACA7zMjcJxZZlOfpGovBh2zu5pVqBKh2WNRM
   XOmhepFUCoH+VdSZrSO1O5l8Vll6hHLuhW2LvPqMw4QlZ4zzH5x5bXds8
   ypibUC6vOH5r5iUMaGYwjForxgCnAK+W7gWbV/zchckKwim8NjymQNC/g
   XQ5493dYwxlKTpUByfGTnSaiOImS3hoyQ8MalRxueW1DinIgcmDTuP/SM
   W8nOH4++95WIb8FE57xnoRr5wXpZs8SquH04Mnp6AkgYKniEniSLgRIC6
   UTIaU4Sqyh9DrcL3yUYCM6m6twR267exwRVvRTHCnNXYjWFg88ZMIo99P
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="7948116"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="7948116"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 19:58:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="801845707"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="801845707"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2023 19:58:43 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 19:58:43 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 10 Dec 2023 19:58:43 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 10 Dec 2023 19:58:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ld6EFkjxBoPNu70bFjml82K/UWzCr1WphtDOmh8O4DhFXwSQl3w0DuM9YD9GNU+sYH24lutGT2QjiYpS6eeK3nPV2wSX5XLl4qP/tDpcEd4m1goPaeMW8BnHvOs2FAyZdO7vq0WI9pKuaWRzuiF93Yr6S+ZibJaTU8eCpXGDkQJB6YTMWCfe2MdCm7vgLo7oyqz+VvHuoe95Tk5/gnyMHVDkVo4PXI4ahtVoekwjbAi9iDBlo5pFkxAzSDzzu9QaC+enyuqznny52yn99B9UR3hptA4cwFqNGs3+YQyb99SAzdhLjstsmCFjJGcRRUXJ+3ec0sZOeMBWHb1OD4Cn+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLBqNO4P3GHJOzDpD9QhiFYC0CUTMLTTHTAwCDfN1OA=;
 b=FdsK+fn2rAGJsSzfx3EUz/AvHf3U+8F+cmAd29gSK4RBN4T/jPLq2wn1FGQwYhUvf3FaQ0SsFB3HjRQLmZUYb7zWkGqt+VESN/Pii5HnuzWYbr6JxwudnVBTxLAxXILe6E3t98GI0yQn7yyFUGIROonMOSvLMBpfV2gJSxR0PsA7cMb4g5YK9F+VRO7zf/e4Q+eK2OM2gnpUG8H0rOt0o+ttTewQnoAfaAXzlNINb8Tgn0OHwgLa+tZqwzhIJzHbOkJjHQjcAlYZixvsmbUB84KsFaQSgcsWZtSORwtBZf65nD2dCBbEJkiRW863WOBE+Pal+MKRgj1KKBMCDJdEpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB5897.namprd11.prod.outlook.com (2603:10b6:806:228::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.29; Mon, 11 Dec
 2023 03:58:41 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 03:58:41 +0000
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
Thread-Index: AQHaJxojfGMimdGl20KFwsu2wXzMo7CfGuwggAA/2YCABB9PUA==
Date:   Mon, 11 Dec 2023 03:58:41 +0000
Message-ID: <BN9PR11MB5276AC40C423A0BAAE9F40A98C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231205012203.244584-1-baolu.lu@linux.intel.com>
 <20231205012203.244584-5-baolu.lu@linux.intel.com>
 <BN9PR11MB52761FF9AB496B422596DDDF8C8AA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <1161d8aa-9fcc-4e9e-a7d3-c461fee19a54@linux.intel.com>
In-Reply-To: <1161d8aa-9fcc-4e9e-a7d3-c461fee19a54@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB5897:EE_
x-ms-office365-filtering-correlation-id: 9702bc6e-ff05-45b1-23dd-08dbf9fd7672
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 34AE+nku7QUonleAl3ECVHwOrbC2SbD0sw01tcDenrqY7BbgsDESODVViCbqdbeolTScJEhSwL6POwTG3ELuiI/N6+Lfc+KeTvN3bVRCuAEv1XP+B4IQwrHIQ8Ma7eNlRypmzAyT+3wcc6lt2D7Hp3flnDLWbNWkxuAh62jm5/nkwtwyHMh71gg88DCWC+tDJGCAed4jL3LGwumoWlbq8SgCX9HdvIiWq87h4541cjGhopapJ6bUZT+YjMzfPiu6f4/xQ9JamVUKjutZJ6tTu14Nz5JxPFo9W/31YSCimqODO/efhz07efE4IPaUnE7iIVpfzPi3ZqY/9yCPXax8jqUwPldkjj35zIR85tS9+tJ/YsGm9k59D5PhCmF0O/X5p0SHHabB7IcLbZPYwwu/drTqXVXjh1b7u8sMbUA+MJiVNP333kw8byaUIZ+y7bZLVtoas/LF8zoXyCTOw1+sUSoG1uRv4TTVO/bqki+nAEZelzRwCtHIvYifRFlK0GmjdFA603DX27/UVa/KAHDwr/G8plAu7m4DjxnoG1zGALsLAlJQCTIBHE+c3tMnVCStVe0fPd9ZtAT+FfKBttidhERutZb2GCna6G1D8XBHecTViLUd4VrG9SDNGsnSZC80KQa2QRQVAOEOtapg3LJPfe/oH8y0DWjUpoAVSTA03w4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(9686003)(26005)(71200400001)(7696005)(6506007)(478600001)(53546011)(83380400001)(2906002)(76116006)(5660300002)(110136005)(66946007)(66556008)(66476007)(54906003)(64756008)(66446008)(8676002)(4326008)(8936002)(316002)(41300700001)(52536014)(122000001)(38100700002)(38070700009)(86362001)(82960400001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzVQcU80M1I1VURPZFFQNmxmVXZLS0gxTzE4a3l5SnMySUhKaktVZXRvM2NK?=
 =?utf-8?B?S2gxekQ3QUxEUFZnM0VaZFVvN1ZJQ1BiZlY3MWtXSkd0dXF2aG5QS3NTd1RQ?=
 =?utf-8?B?a0JMMmFKbkFGOWFkc2ZCQWJ4ZS9acTdINXc4K3Jzb01UZHNnRWNSTkdPQ0VH?=
 =?utf-8?B?RmRPWEtMd241ZWxlMm0xSUppaGhQSWdoSmU0M3RSeFRpNThGRVFmNWxndDF4?=
 =?utf-8?B?TlRPZ29pcmtSN1FXOWZ6Q2FlbU0ybGFsZng3M05qcWt0VEZCYlZ1YWNQeHhx?=
 =?utf-8?B?YWlFT1F0Y1ZrbkhGeHRRTFp1UkRpVHNDck9nUVg1eGtKdFlkaGRhQys1NEg1?=
 =?utf-8?B?dERUcHMyR09YSkhlV1pucVIycmVxZVNOcE1MUTBlQ0JweTJTZFVoOGk2cVc1?=
 =?utf-8?B?OVhIMmVZTy9LU3JISjRMaUlpcXJzR3I3UTBTK2tnWEx0bzRPMzhXU3BpTHNp?=
 =?utf-8?B?dnlqeWR1V1JZY01neGkzeHZjbDJHZGROZHNBVE5SVk0wbis2OHJFNXlVMWFq?=
 =?utf-8?B?U21IKzdtTWxpc2NUWSt0UUZia0haaXJOUlZiR3lCTlF1NksrbXZra1BoUi8x?=
 =?utf-8?B?K2tnUldzODh5cGV3QU1TT0Q3Sy9vdGI5aTJzTm9BaVRMdGdtSUdTSVRrQ0Fm?=
 =?utf-8?B?RDdLWnhpcDlGMWhFQzdWZHlyWThLNVVvUWlKdHBUS0pwY2ExamkrZldYVzFF?=
 =?utf-8?B?Vk9ra3d0ZGpkT0dzbmRYNHkrSTNtOWkvSkZ3S1AvZkpmeXkrV0V1WXJoU1V5?=
 =?utf-8?B?c1hoY05FOGFzejExcVFIMGFoU0o3Mm5yQlBiaHN2aTVwaFhka2JlTTh1UzlB?=
 =?utf-8?B?Z05IZE05RmZ0ZzFCcSt2Z1FiSnFJeENqaUhpLzAwOE5xYk9CaVF2dzhGOXA0?=
 =?utf-8?B?TVlPSTVpUk9wbG1tYWErRUoyQ0IvZEUxM1Fqdi8wY3Z2K2ZwVnc4TnRZdi9N?=
 =?utf-8?B?SkZXYVd0VGJaQTBGdGdOejBBSVV1bnZJcEs1SUJJR1E5NVZZdEJYS25lZFBj?=
 =?utf-8?B?aU1FNUd0MGtEa3lVdEU1OHg1NXY2MCtmL0RudHBqOU1CTURQZ0VtSU82MTJC?=
 =?utf-8?B?WGd5LzNGWDdBbEZkcllMNzZxcjJDZDdnS1p3VlVFNml1NUg3SGY3dGZpSzNN?=
 =?utf-8?B?RkxvbWpQQTNmRmZ2WXRMS1FDU0ZLSDlDQXZZSVBNWDMwYVpnUTBGcExjQzlI?=
 =?utf-8?B?Y1ZsQ1hwTmJhZVlpMDlPbmZEK0JXc2VGeHB6aFdzdjFMeTAxR0VxVmhvZHpP?=
 =?utf-8?B?VUsxcUlXVVZXSW1qZmlTdnB3aG5wbUlZdWtoZGpURUdpcEtqSzBFT0l4RWpl?=
 =?utf-8?B?Rm5ibzcxN1drSTAzKzlBbnZESFlOQ3V5ODBuUS9uL014U0MvOTVZcmR1Ty8z?=
 =?utf-8?B?aEE4UlY0Nk4wNklIY3ZqQkxCcTFKT3lCV2UrVUhFb29TbnVoQWpVMzNYdFJI?=
 =?utf-8?B?TnRkZnFCZTdUaXVpZnhUMW1qZzNBRU03RVZHckVIYVdlZWtoSktKM1lMTVBv?=
 =?utf-8?B?bVloOGNURUlha3hxNmpVRUFWdFR3dFFkdWFTSkx6OEtMMGlaZHVWdTNwNWh2?=
 =?utf-8?B?ZEZRbkwybjhsd0dqcUhBN1YrOXFxNHdPZEZCa1IwMG5Gb0dIdlJBTmd2cFRw?=
 =?utf-8?B?RFJxdDI2a1o2WVdoUjlPU09rL2c5RW42ZHFLeDBjdW5rLzl5Q1grUG5GZWt6?=
 =?utf-8?B?a1dqQmFWWFVPODRjUmFNZStFTUcxN3gxZlA3d0pZVUVnTS9ORTM0ZGlTUldv?=
 =?utf-8?B?MmxiV1NzV1FJbFNrajVrb1Fka2htclZQR0NyK01DTERieERrTEFIM0xlREpM?=
 =?utf-8?B?UXl4Q1BxK0hjZnd2cm15cVhYN1VqQU9hbGorVElOcHBNMlZodi9pampyWDdO?=
 =?utf-8?B?RGxGeXJDdWVqNzNDVTFaRFYrUWdoL1hxYmRGbElIblZZMmRBOC8yRmIwL2Fk?=
 =?utf-8?B?K3pXVFkrY2JFK0RQZVI1ZjcrS2xQU2RXRHhNTUloc2ZWNS9hVUk2WE82dFNv?=
 =?utf-8?B?czl4VXZkWkFvUFlqc1ZYVUttdGdsYWJKMkFQZHNwMm5iZEFDZ0RZNTl4R1Iz?=
 =?utf-8?B?WEpIY2ZhaUxJUG5SeDBwTWZDRU9uU01Mbm9pMXNUMVJ5ZVhrdHhpRFY0T2tU?=
 =?utf-8?Q?HaWSyMo3eKHXAdksa+nP8CyMX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9702bc6e-ff05-45b1-23dd-08dbf9fd7672
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 03:58:41.2256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0AYdOF67wvjtVV1bcEZOIvTdRGN99kVv7AaRsJtv6vdqpUDop7M/2TY65pfFmZ57uGDORcNzR+487b2wueiabQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5897
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

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIERlY2VtYmVyIDgsIDIwMjMgODo0NiBQTQ0KPiANCj4gT24gMjAyMy8xMi84IDE3OjA5LCBU
aWFuLCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4Lmlu
dGVsLmNvbT4NCj4gPj4gU2VudDogVHVlc2RheSwgRGVjZW1iZXIgNSwgMjAyMyA5OjIyIEFNDQo+
ID4+DQo+ID4+IE9sZGVyIFZULWQgaGFyZHdhcmUgaW1wbGVtZW50YXRpb25zIGRpZCBub3Qgc3Vw
cG9ydCBwYXNzLXRocm91Z2gNCj4gPj4gdHJhbnNsYXRpb24gbW9kZS4gVGhlIGlvbW11IGRyaXZl
ciByZWxpZWQgb24gYSBETUEgZG9tYWluIHdpdGggYWxsDQo+ID4+IHBoeXNpY2FsIG1lbW9yeSBh
ZGRyZXNzZXMgaWRlbnRpY2FsbHkgbWFwcGVkIHRvIHRoZSBzYW1lIElPVkEgdG8NCj4gPj4gc2lt
dWxhdGUgcGFzcy10aHJvdWdoIHRyYW5zbGF0aW9uLg0KPiA+Pg0KPiA+PiBUaGlzIHdvcmthcm91
bmQgaXMgbm8gbG9uZ2VyIG5lY2Vzc2FyeSBkdWUgdG8gdGhlIGV2b2x1dGlvbiBvZiBpb21tdQ0K
PiA+PiBjb3JlLiBUaGUgY29yZSBoYXMgaW50cm9kdWNlZCBkZWZfZG9tYWluX3R5cGUgb3AsIGFs
bG93aW5nIHRoZSBpb21tdQ0KPiA+PiBkcml2ZXIgdG8gc3BlY2lmeSBpdHMgY2FwYWJpbGl0aWVz
LiBBZGRpdGlvbmFsbHksIHRoZSBpZGVudGl0eSBkb21haW4NCj4gPj4gaGFzIGJlY29tZSBhIHN0
YXRpYyBzeXN0ZW0gZG9tYWluIHdpdGggIm5ldmVyIGZhaWwiIGF0dGFjaCBzZW1hbnRpY3MuDQo+
ID4NCj4gPiBJJ20gbm90IHN1cmUgYWJvdmUgZXhwbGFpbnMgdGhlIHJlYXNvbiBmb3IgcmVtb3Zp
bmcgdGhlIGlkZW50aXR5IHN1cHBvcnQNCj4gPiBvbiBvbGRlciBoYXJkd2FyZS4gTG9va3MgdGhl
IHJlYXNvbiBpcyBzaW1wbHkgdGhhdCBjb250aW51aW5nIHRvIG1haW50YWluDQo+ID4gdGhhdCBk
ZWJ0IHByZXZlbnRzIGludGVsLWlvbW11IGRyaXZlciBmcm9tIGNhdGNoaW5nIHVwICB3aXRoIGlv
bW11IGNvcmUNCj4gPiBldm9sdXRpb24gc28gd2UgZGVjaWRlIHRvIHJlbW92ZSBpdC4NCj4gDQo+
IEl0IGlzIG5vdCB0aGF0IHNpbXBsZS4gSSBzaG91bGQgcHV0IG1vcmUgd29yZHMgaGVyZS4NCj4g
DQo+IEdlbmVyYWxseSBzcGVha2luZywgaGFyZHdhcmUgbGFja2luZyBwYXNzdGhyb3VnaCB0cmFu
c2xhdGlvbiBzdXBwb3J0LA0KPiBidXQgdGhlIGlvbW11IGRyaXZlciBmYWtlcyBpdCBieSB1c2lu
ZyBhIERNQSBkb21haW4gd2l0aCAxOjEgbWFwcGluZ3MsDQo+IG1ha2VzIG5vIHNlbnNlIGJlY2F1
c2UgaXQgZG9lc24ndCBtaXRpZ2F0ZSBhbnkgaGFyZHdhcmUgb3ZlcmhlYWRzLg0KDQpOb3QgYWJv
dXQgb3ZlcmhlYWQuIE1pZ2h0IGp1c3QgYmUgdGhhdCBkZXZpY2Ugb3IgZHJpdmVyIGlzIG5vdCBj
YXBhYmxlIG9mDQpoYW5kbGluZyByZW1hcHBlZCBkbWEgYWRkcmVzcy4NCg0KPiANCj4gSWYgdGhl
IGRldmljZSBkcml2ZXIgdXNlcyB0aGUga2VybmVsIERNQSBBUEkgdG8gZG8gRE1BLCBpdCBkb2Vz
IG5vdCBuZWVkDQo+IHRvIGNhcmUgYWJvdXQgdGhlIERNQSB0cmFuc2xhdGlvbiB0eXBlLiBUaGlz
IGlzIGEgdXNlci1kZWNpZGVkIHBvbGljeS4NCj4gVGhlIGlvbW11IHN1YnN5c3RlbSBoYXMgYWxy
ZWFkeSBwcm92aWRlZCB0aGlzIHN1cHBvcnQgdG8gdXNlcnMgdGhyb3VnaA0KPiBrZXJuZWwgYnVp
bGQgb3B0aW9ucywga2VybmVsIGJvb3QgY29tbWFuZHMsIGFuZCBzeXNmcyBub2Rlcy4NCj4gDQo+
IElmIHRoZSBkZXZpY2UgZHJpdmVyIGRvZXNuJ3QgdXNlIGtlcm5lbCBBUEkgZm9yIERNQS4gV2hp
bGUgd2UgZGlzY291cmFnZQ0KPiB0aGlzIGJlaGF2aW9yLCB0aGUgaW9tbXUgc3Vic3lzdGVtIHBy
b3ZpZGVzIHRoZSBETUEgb3duZXJzaGlwDQo+IG1lY2hhbmlzbS4NCj4gVGhpcyBhbGxvd3MgdGhl
IGRyaXZlciB0byB0YWtlIG92ZXIgdGhlIERNQSBvd25lcnNoaXAsIGFsbG9jYXRlIGFuZA0KPiBt
YW5hZ2UgaXRzIG93biBkb21haW4sIGFuZCByZXBsYWNlIGl0IHdpdGggdGhlIGRlZmF1bHQgZG9t
YWluLCBhcyB0aGUNCj4gaW9tbXUgZGVmYXVsdCBkb21haW4gaXMgb25seSBkZXNpZ25lZCBmb3Ig
a2VybmVsIERNQSB3aXRoIHRoZSBETUEgQVBJLg0KPiANCj4gSW4gc3VtbWFyeSwgd2hldGhlciBv
ciBub3QgdG8gdXNlIGEgRE1BIGRvbWFpbiB3aXRoIDE6MSBtYXBwaW5ncw0KPiBzaG91bGQNCj4g
YmUgYSBkZXNpZ24gZGVjaXNpb24gbWFkZSBpbiB0aGUgZGV2aWNlIGRyaXZlciwgbm90IGEgY29t
bW9uIGJlaGF2aW9yDQo+IGZvciBhIG1vZGVybiBpb21tdSBkcml2ZXIuDQo+IA0KPiA+DQo+ID4+
DQo+ID4+IEVsaW1pbmF0ZSBzdXBwb3J0IGZvciB0aGUgMToxIG1hcHBpbmcgZG9tYWluIG9uIG9s
ZGVyIGhhcmR3YXJlIGFuZA0KPiA+PiByZW1vdmVzIHRoZSB1bnVzZWQgY29kZSB0aGF0IGNyZWF0
ZWQgdGhlIDE6MSBwYWdlIHRhYmxlLiBUaGlzIHBhdmVzIGENCj4gPj4gd2F5IGZvciB0aGUgaW1w
bGVtZW50YXRpb24gb2YgYSBnbG9iYWwgc3RhdGljIGlkZW50aXR5IGRvbWFpbi4NCj4gPg0KPiA+
IERvIHlvdSBrbm93IGhvdyBvbGQgc3VjaCBoYXJkd2FyZSBpcz8NCj4gDQo+IEkgYW0gbm90IHN1
cmUsIGJ1dCBJIGhhdmUgYSBkZXNrdG9wIHRoYXQgaXMgb3ZlciAxMCB5ZWFycyBvbGQgYW5kDQo+
IHN1cHBvcnRzIHBhc3N0aHJvdWdoIHRyYW5zbGF0aW9uLiA6LSkNCj4gDQo+ID4NCj4gPj4gQEAg
LTIzMTEsNiArMjI1NywxMyBAQCBzdGF0aWMgaW50IGRldmljZV9kZWZfZG9tYWluX3R5cGUoc3Ry
dWN0DQo+IGRldmljZQ0KPiA+PiAqZGV2KQ0KPiA+PiAgIAkJCXJldHVybiBJT01NVV9ET01BSU5f
SURFTlRJVFk7DQo+ID4+ICAgCX0NCj4gPj4NCj4gPj4gKwkvKg0KPiA+PiArCSAqIEhhcmR3YXJl
IGRvZXMgbm90IHN1cHBvcnQgdGhlIHBhc3N0aHJvdWdoIHRyYW5zbGF0aW9uIG1vZGUuDQo+ID4+
ICsJICogQWx3YXlzIHVzZSBhIGR5bmFtYWljIG1hcHBpbmcgZG9tYWluLg0KPiA+PiArCSAqLw0K
PiA+PiArCWlmICghZWNhcF9wYXNzX3Rocm91Z2goaW9tbXUtPmVjYXApKQ0KPiA+PiArCQlyZXR1
cm4gSU9NTVVfRE9NQUlOX0RNQTsNCj4gPj4gKw0KPiA+PiAgIAlyZXR1cm4gMDsNCj4gPg0KPiA+
IHRoZXJlIGFyZSB0d28gY2FzZXMgYWJvdmUgd2hpY2ggbWFuZGF0ZXMgSURFTlRJVFkuIEhhdmUg
eW91IGNvbmZpcm1lZA0KPiA+IHRoYXQgdGhvc2UgcGxhdGZvcm1zIHN1cHBvcnQgaGFyZHdhcmUg
cGFzc3Rocm91Z2g/IG90aGVyd2lzZSB0aGlzDQo+IGNoYW5nZQ0KPiA+IGlzIGJyb2tlbi4NCj4g
DQo+IFRob3NlIHR3byBjYXNlcyBzaG91bGQgYmUgaGFyZHdhcmUgcXVpcmtzIGZvciBTb0MtaW50
ZWdyYXRlZCBkZXZpY2VzLiBJdA0KPiBtYWtlcyBubyByZWFzb24gdGhhdCBhIHF1aXJrIHJlcXVp
cmVzIElPTU1VIHBhc3N0aHJvdWdoIHRyYW5zbGF0aW9uLCBidXQNCj4gdGhlIGhhcmR3YXJlIGRv
ZXNuJ3Qgc3VwcG9ydCBpdC4NCj4gDQo+IElmLCB1bmZvcnR1bmF0ZWx5LCB0aG9zZSBxdWlya3Mg
dHVybiBvdXQgdG8gYmUgd29ya2Fyb3VuZHMgZm9yIGEgcG9vcmx5DQo+IGRlc2lnbmVkIGRldmlj
ZSBkcml2ZXIsIHdlIHNob3VsZCByZW1vdmUgdGhvc2UgcXVpcmtzIGFuZCByZXF1ZXN0IHRoZQ0K
PiBkZXZpY2UgZHJpdmVyIHRvIHV0aWxpemUgdGhlIERNQSBvd25lcnNoaXAgZnJhbWV3b3JrIHRv
IGFjaGlldmUgdGhlIHNhbWUNCj4gZnVuY3Rpb25hbGl0eSB3aXRoaW4gdGhlIGRyaXZlciBpdHNl
bGYuDQo+IA0KDQppZiB0aGF0IGlzIHRoZSBjYXNlIHlvdSBzaG91bGQgZml4IHRoZSBkcml2ZXJz
IGZpcnN0IGJlZm9yZSBicmVha2luZyB0aGVtLg0KDQpCdXQgYXQgYSBnbGFuY2UgbG9va3MgdGhv
c2UgdHdvIHF1aXJrcyBhcmUganVzdCBmaW5lLg0KDQpGb3IgQXphbGlhIHNvdW5kIGRldmljZSB0
aGUgcHJvYmxlbSBpcyB0aGF0IEJJT1MgZW5hYmxlcyBhIGRlZGljYXRlZA0KRE1BUiBmb3IgaXQg
YnV0IGFsbG9jYXRlcyB6ZXJvIFRMQiBlbnRyaWVzIHRvIGNhdXNlIGRlYWRsb2NrLiBUaGlzDQpp
bXBsaWVzIGEgaHcgcGFzc3Rocm91Z2ggbW9kZSBvdGhlcndpc2UgaXQncyBzdGlsbCBicm9rZW4u
DQoNCkZvciBHRlggaXQncyBhIHdvcmthcm91bmQgYWRkZWQgc2luY2UgZGF5IG9uZS4gdGhlcmUg
aXMgZXZlbiBzdGlsbA0KYW4gb3B0aW9uIENPTkZJR19JTlRFTF9JT01NVV9CUk9LRU5fR0ZYX1dB
IGF2YWlsYWJsZS4gQnV0DQpub3cgaXRzIG1lYW5pbmcgaXMgcmVhbGx5IGRpc2FibGluZyBJT01N
VSBpbnN0ZWFkIG9mIHVzaW5nIGlkZW50aXR5Lg0KDQpzb3VuZHMgbGlrZSBJREVOVE1BUF9HRlgg
Y2FuIGJlIGZ1bGx5IHJlbW92ZWQgbm93Og0KDQojaWZkZWYgQ09ORklHX0lOVEVMX0lPTU1VX0JS
T0tFTl9HRlhfV0ENCglkbWFyX21hcF9nZnggPSAwOw0KI2VuZGlmDQoNCglpZiAoIWRtYXJfbWFw
X2dmeCkNCgkJaW9tbXVfaWRlbnRpdHlfbWFwcGluZyB8PSBJREVOVE1BUF9HRlg7DQo=
