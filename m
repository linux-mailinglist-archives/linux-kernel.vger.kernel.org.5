Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A467EA9C7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjKNEqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjKNEqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:46:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23FAFE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699937188; x=1731473188;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pMy4gBTE9zdSxfhpKHfob9r3UotHHn54rfwGAtLZNRg=;
  b=T1we1GbhN0HGM42VlDoIoypFl9HD24Png13AX5kBFO/PjjBiEaV2UZgV
   OqRcB2CYdAiyFKNZg2bYO/d+MMMnMwEpV+NSfzzNSvxk8qqthlAuRtSHn
   5BtDJSwsNZe8ryXOb6ganee4Dde4b8D9B5V7LygPOe72DWtRP+BKJu238
   U6d5LeJ2j4RBUDSSmDIRpRt6E6CgKYTgWNFjNUVMUsfhBNz+cp/Y0hHcS
   B3zw2MiFoGhhnlBgku07Tra3ORHiXO66iwBn1R8MSjkdx66Nti1CXFcoc
   h1tGCKoXSVeS5q0g6T9UDpbtQ3h5imQh1x59rcq4S7doEHfBGUHeal2Mn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="380975857"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="380975857"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 20:46:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="12672102"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 20:46:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 20:46:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 20:46:26 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 20:46:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqnexLPQIPh8N66SY151iy4L7+k13qbSkScWF1mMlLtOxxJBcdf0oYdwWunsSSYKwX0AayDoSMbRA+7V5eXkLGg6i8ekZKxkuoPPPTkIio3ecsS5UdZhEH5xRPqgC//AKcIe8BD5pz5tFZ/nZkbK4hn0D755nbzdde/DreodXtmAquoXSciG8m4KH6ZaoJ1QEZBaEv16C3X2rZw79/oYlKWILL+oThMKUqOZA/UH37Fy3R4uC3omg/MaTEddCGNaSG50GCUm65pb8ToL67f6nkUE68Ld+agekbHTG/QV2I81SXFvrmVGKHsPDfsZZkHPU+Y4zEG5q0Tyfe5Fu8PnZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMy4gBTE9zdSxfhpKHfob9r3UotHHn54rfwGAtLZNRg=;
 b=TxPMaOs7kgGZxb9QsCbixRx8dcc/tBQhn8BMW9XJj19p/RnPzu3E2Zx2W6ki6+QKwNKkypa5knuNI+/rhVD6c5KBJpXPd0Bv1hSstkVrDiZ6lUfXJmVsDOm9vmsbpscI8psBmUDQKxGOPvvCzyY6+997GhIF48XFycGDXBUeoQ7NJ7/TEvnIZ8xKdmCvr5JdA5WlDiHJuoacmcQzZd8exsV7Gq1zRXKMcrgntzYqFGBvCAXgU1l7WiuvHV370HNjSXT+5nTqrXvJQpF5FPZd5GC730nr0vZ4QcWSliGNx82L15zmbAx3J9nWaP3860NM5ilAhh8k1MUbIflO6KbwAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4547.namprd11.prod.outlook.com (2603:10b6:5:2a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 04:46:23 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 04:46:23 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Make context clearing consistent with
 context mapping
Thread-Topic: [PATCH 1/1] iommu/vt-d: Make context clearing consistent with
 context mapping
Thread-Index: AQHaFpgD7eV3C3aZ80+9ufH0otr//bB5JNYQgAABhoCAABdMwA==
Date:   Tue, 14 Nov 2023 04:46:23 +0000
Message-ID: <BN9PR11MB5276C809A2BF1A63B92F09EA8CB2A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
 <20231114011036.70142-4-baolu.lu@linux.intel.com>
 <BN9PR11MB52765C637BFAD28ADF1D24738CB2A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c3053d76-433b-4c4d-b19b-13ff61c7dab4@linux.intel.com>
In-Reply-To: <c3053d76-433b-4c4d-b19b-13ff61c7dab4@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM6PR11MB4547:EE_
x-ms-office365-filtering-correlation-id: feda2f39-e11b-47e4-ac77-08dbe4cca762
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LNfI8v+HK3KadCKTwo/5aQ5m+FAFCL2z8Um7eSFy9L8N3ovnxPofez0vmALRcNMfD1QTXc1hsQY4vZBEevPtNHBYjHOTW+vVl7mjFAg9gIfDZp/5eHGoe7KXDqI/iKa4L/0RPsXWQQwUzDp8tuTkQUv540iWauIwh3bZe67Wcut1TwxCyNHSc2s4Bp98wdb3Bj70HzGeFtxtgStWsKMxmSALTuXLCnm5dwfSKnHQ+shjyAA/3jDYWir0ggn9wulKO2xwYGdDZDJyRk+GaAFbWOKDNPTU3Bxk9s8uL+QYncG/eXEB+EXGFzqBbrdnL7aOV6mNPb87ip/Rk8TOnuxP/kLDIaqgaZGa19c3TEjuq53SgPuuIJuI8Wh2ExHUuxj7ZKnZfXB+bCpiJnLdql2pf51hZvEdO8NFIIaC8OlWU95cxyrEx05RleB5DcX8h+XAwbonYTdy1M0/qFS9udHcdGWIsDSvh3m2GX/zw+ZpQn1PNwJq9AHWQpopNmMSwwHCmZ+NDVnXxgC8rGLq8h+WvcC443rn6dPcoVuUg+z4DCdxoYedMPPybo7WT0o9LNeE8CqBWA6cWZ+GYqOwuzwxeVn2yIkIcoZ3k15VjBoVwZJIO6lkb3nUfAzjCGRnsz64
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(346002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(55016003)(64756008)(66446008)(316002)(66476007)(66946007)(110136005)(66556008)(76116006)(54906003)(38100700002)(33656002)(38070700009)(26005)(86362001)(122000001)(9686003)(83380400001)(53546011)(71200400001)(82960400001)(6506007)(2906002)(478600001)(7696005)(5660300002)(41300700001)(4326008)(52536014)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zzc0aFVzUTlmeG8yaTVnemp5cC9PajVqWTQ0N2N5OUc4MmNMMU84RmxNTTRP?=
 =?utf-8?B?NjFGMUE4M1p4cGxmNGcyYnZ3R1dVQWZSRmh5TUNGZ1pFQU5mSE9yTkUyLzFB?=
 =?utf-8?B?VlRaenc4OGRURkZYTWxWeXMvdWZFWmtxbzZXS1kvcDdzYTZWblFhNjUzSmdl?=
 =?utf-8?B?NDVTZFNYUjFKb3F1bUZkTUJZeFcxQ1BrNm51UDlwdnN3aW1NVmQrMTYwaC8r?=
 =?utf-8?B?cmtDRU9janFDeGJTa1Y4cXpnVC9ZLzZ4a3FHMWFTeFFFR3JlTzQvN29DZGl3?=
 =?utf-8?B?SmllaG9CV3o1OU9sVWZmcEx4K0JnblNiRHVLUjZyQ1l2RWVOMEozSGNBeXVM?=
 =?utf-8?B?TFZ0ZUZaU0V6REdJU2lQWjdQbHNXOXJoMHRuT1prbjVkRDZPaC84TzJsdmg3?=
 =?utf-8?B?a1BqL0NDRkl3aG9jbzhaMFRtTUR6T003ckdKM0duM3hXdDBHVEUybnU3dWhF?=
 =?utf-8?B?TjJFZHFuaGhrYUQ5LzkvanRud2JheTkwQUJyZXUwVWhDVXgyWGRnSW5BcjVN?=
 =?utf-8?B?UnM3YUdCYXBRYVQ1RWdjTXlIUmhNZ3c2bTYvRXBqZy95MjJkbXZWdkxKcUlw?=
 =?utf-8?B?NThlMXNOZEZYNDFVY2FtNTdITXRFMmtrYS9PL1p3bkFGcHRIdkZFdlc5ZUtm?=
 =?utf-8?B?Y2ErcHQrOU9HMVJEUmZhZVRTd2pZS3NHNkkzd24yRkdKU3FXejI5VkhobE5z?=
 =?utf-8?B?T2djZGFZNjlRZTBMaDA5TXNiL2RtOVZUc0JqbVFmQmhLcGdqK242VHF0S0N4?=
 =?utf-8?B?MDRER1VqYk03S0JiSllYYUV5cHNOT3hpSkRyUzBweXZ6TTJjVHJYY1VhNkFl?=
 =?utf-8?B?K3NyOVdnTFpIMi82NUxKWnlIK0FtenhhTGFTTE51V0lTVHkxL242MzBONVR2?=
 =?utf-8?B?VDRCZUx1bnpmN2VqNjJPa3U0dHltdWt2ZlA2cUtndVppS1lMclZ1RGtUdVFC?=
 =?utf-8?B?VmxjcmVsQzBXYllKS0J6YUlMNUJGcmRQdk5ZMThRNDdqZDVUQkovTFFJS09I?=
 =?utf-8?B?dlVYMm1mWmh2d0prdXVCYTJ2eUtLQjJFY09oeE41dndabDZaNGR5K2Q3VVU5?=
 =?utf-8?B?WFg2NXRCcERVU3BsNHlCSkQvaDQzV2xsdzhsa0sxdEM0VnRLQ1RoeXYwUmpU?=
 =?utf-8?B?cncwdmp5M3A4dVB0d2NyZFJzWmpQWE00REY0U3VlbjdXRmxVWXBWRW1iTVBF?=
 =?utf-8?B?V0VUbHdTaE1yaCsxUXNiRXZkNndncEg0UFd5Yno1dVMyUDk5NzhsNDhKK1RC?=
 =?utf-8?B?eEZaN1RzVzVuM3RMTUVzUkp0YmE2UjNhT1YxWVdPeThXV04zc3Bkc1JFMmxq?=
 =?utf-8?B?TzdiMlN1N21NU3VTTjl4THpLL3E2dUhCc0xZdjhheGZRdkFKa01HeTdGNWw2?=
 =?utf-8?B?dWpPbE93Q2x1S3h4ZEpSUkl3aWk5WHBtZkc0VjZWSVZNN3NaTlN0VUtUQk5S?=
 =?utf-8?B?QWROUFMxWEROSzFpK3RBU0VBaldyamV5ZjhOSHI2T2RxeUNuTnlQQ052K1lJ?=
 =?utf-8?B?QmlFcWw4aEtvTTFqM1RIY1pqOTgrT3U3dndQNnNCM01YaHBqZjZ3ZjZoZ0Jo?=
 =?utf-8?B?QWxIZTRJSk5jS0tjcUZHMmZUZlBOckhqWVZVSG93cVE1endzakV4ZEowdkRR?=
 =?utf-8?B?T1Zxd0RROXJZUzl2ekJnTVBpdDE4Vjd4b1owdjBDVmt4RFNGb0RvSkVLa0FM?=
 =?utf-8?B?bFNWd0NTTzhuODd2VENyVWhOY1NCVXJCeC9YU0Nmdmd3QXJTcGVqaFM3bWN4?=
 =?utf-8?B?R0UyTFRLQ3ZjVnUvdWRXMzR1bS8rSm5CSTNDZHZoWC9uSWFRY3VaNWJUMGp5?=
 =?utf-8?B?MC9jKzRtZG5oRDFYSThDTnRteXBPdjJZb3dCdVBRY0R6cVUwajZBYVJhdHBW?=
 =?utf-8?B?MW1Bck5mSjJpUnJGWFZ3Tk5wNGc4dy9PNnd5bm0rcnpOc2VvUEFYZGU2dWgr?=
 =?utf-8?B?TTFRbmxydzhDQ3hyM210b1pFSVBrckdUWFFrdGVGU2FNaDJPdFovMkZoSGNq?=
 =?utf-8?B?RndVMFA1ZkRIMXNhU2hUTXRndVN2My9la0VjdHRlMDE3MHMxeXhiQS8vOThk?=
 =?utf-8?B?QUFJWnRDWlhpS29RcUh1MUlVOTNZRTR5RGtseitPeGltbG94bVJsNmdvUGZx?=
 =?utf-8?Q?tfnB80Ng5Piv2LsvGPRuA9knM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feda2f39-e11b-47e4-ac77-08dbe4cca762
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 04:46:23.5762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ULiOdHN4GAkLcx/DVVs7vk098eSiD5Ue60TUOa9xprJpl06ly4T08UgIQvRqunRQtjvukqCtJ1DH33+PUuSmFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4547
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBOb3ZlbWJlciAxNCwgMjAyMyAxMToyMiBBTQ0KPiANCj4gT24gMTEvMTQvMjMgMTE6MjAg
QU0sIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGlu
dXguaW50ZWwuY29tPg0KPiA+PiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAxNCwgMjAyMyA5OjEx
IEFNDQo+ID4+DQo+ID4+IEluIHRoZSBpb21tdSBwcm9iZV9kZXZpY2UgcGF0aCwgZG9tYWluX2Nv
bnRleHRfbWFwcGluZygpIGFsbG93cw0KPiBzZXR0aW5nDQo+ID4+IHVwIHRoZSBjb250ZXh0IGVu
dHJ5IGZvciBhIG5vbi1QQ0kgZGV2aWNlLiBIb3dldmVyLCBpbiB0aGUgaW9tbXUNCj4gPj4gcmVs
ZWFzZV9kZXZpY2UgcGF0aCwgZG9tYWluX2NvbnRleHRfY2xlYXIoKSBvbmx5IGNsZWFycyBjb250
ZXh0IGVudHJpZXMNCj4gPj4gZm9yIFBDSSBkZXZpY2VzLg0KPiA+Pg0KPiA+PiBNYWtlIGRvbWFp
bl9jb250ZXh0X2NsZWFyKCkgYmVoYXZlIGNvbnNpc3RlbnRseSB3aXRoDQo+ID4+IGRvbWFpbl9j
b250ZXh0X21hcHBpbmcoKSBieSBjbGVhcmluZyBjb250ZXh0IGVudHJpZXMgZm9yIGJvdGggUENJ
IGFuZA0KPiA+PiBub24tUENJIGRldmljZXMuDQo+ID4+DQo+ID4+IEZpeGVzOiA1NzkzMDVmNzVk
MzQgKCJpb21tdS92dC1kOiBVcGRhdGUgdG8gdXNlIFBDSSBETUEgYWxpYXNlcyIpDQo+ID4+IFNp
Z25lZC1vZmYtYnk6IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+DQo+ID4NCj4g
PiBUaGUgY29kZSBiZWZvcmUgdGhlIGZpeCB0YWcgYWxzbyBoYXMgdGhlIHNhbWUgcHJvYmxlbS4g
SWYgd2UgcmVhbGx5IHdhbnQNCj4gPiBiYWNrcG9ydCB0aGVuIGxldCdzIGZpbmQgb3V0IHRoZSB2
ZXJ5IGZpcnN0IGNvbW1pdCB3aGljaCBleGhpYml0cyB0aGlzDQo+ID4gcHJvYmxlbS4NCj4gDQo+
IENvbW1pdCA1NzkzMDVmNzVkMzQgYWxsb3dzIG5vbi1QQ0kgZGV2aWNlcy4NCj4gDQo+ICsgICAg
ICAgaWYgKCFkZXZfaXNfcGNpKGRldikpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gZG9tYWlu
X2NvbnRleHRfbWFwcGluZ19vbmUoZG9tYWluLCBpb21tdSwgYnVzLCBkZXZmbiwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHJhbnNsYXRpb24p
Ow0KPiArDQo+ICsgICAgICAgZGF0YS5kb21haW4gPSBkb21haW47DQo+ICsgICAgICAgZGF0YS5p
b21tdSA9IGlvbW11Ow0KPiArICAgICAgIGRhdGEudHJhbnNsYXRpb24gPSB0cmFuc2xhdGlvbjsN
Cj4gKw0KPiArICAgICAgIHJldHVybiBwY2lfZm9yX2VhY2hfZG1hX2FsaWFzKHRvX3BjaV9kZXYo
ZGV2KSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmZG9tYWluX2Nv
bnRleHRfbWFwcGluZ19jYiwgJmRhdGEpOw0KPiANCj4gQnV0IGl0IGZvcmdvdCB0byB1cGRhdGUg
dGhlIGRvbWFpbl9jb250ZXh0X2NsZWFyKCkgaGVscGVyLiBTbyB0aGlzIGlzDQo+IGFjdHVhbGx5
IGEgZml4IGZvciB0aGF0IGNvbW1pdC4NCg0KdGhhbmtzLiBJIGRpZG4ndCBub3RlIHRoYXQgc2lk
ZSBlZmZlY3QgZnJvbSBjb21taXQgbXNnLg0KDQo+IA0KPiA+DQo+ID4gQnV0IEkgd29uZGVyIHRo
ZSBhY3R1YWwgaW1wYWN0IHcvbyBzdWNoIGZpeC4gSWYgdGhlcmUgaXMgbm8gaG90LXJlbW92ZQ0K
PiA+IHBvc3NpYmxlIGZvciB0aG9zZSBub24tUENJIGRldmljZXMgdGhlIGNvbnRleHQgZW50cnkg
d2lsbCBiZSBsZWF2ZWQNCj4gPiBlbmFibGVkIHVudGlsIHRoZSBtYWNoaW5lIGlzIG9mZi4gVGhl
biB0aGlzIGZpeCBpcyBuaWNlLXRvLWhhdmUgdGhlbg0KPiA+IHByb2JhYmx5IG5vIG5lZWQgdG8g
YmFja3BvcnQ/DQo+IA0KPiBJdCBkb2Vzbid0IGNhdXNlIHJlYWwgaXNzdWVzIGFzIGZhciBhcyBJ
IGNhbiBzZWUuIFNvIHRoZXJlJ3Mgbm8gbmVlZCB0bw0KPiBiYWNrIHBvcnQgaXQgdG8gc3RhYmxl
IGtlcm5lbHMuIFRoYXQncyB0aGUgcmVhc29uIEkgZGlkbid0IGFkZCBjYy1zdGFibGUNCj4gdGFn
LiBCdXQgd2Ugc3RpbGwgbmVlZCBhIGZpeCB0YWcgYXMgaXQncyBhY3R1YWxseSBhIGZpeC4NCj4g
DQoNCm1ha2Ugc2Vuc2UuDQoNClJldmlld2VkLWJ5OiBLZXZpbiBUaWFuIDxrZXZpbi50aWFuQGlu
dGVsLmNvbT4NCg==
