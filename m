Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47888753026
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbjGNDtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjGNDtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:49:04 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C0726B6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689306543; x=1720842543;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dRVC6qyhmzQ51mQMiost6BSPCS+HJvzCW/fQJ5m5FhM=;
  b=eNSwzu6dH34GL0aLA3aPswCtL5ai/lhqgnhVRQrRB/eB8N4SiJrW03Up
   nqjl9NTfNI709GgK3v/VchJeG1gJBCLjxegs/SonpvZakxAOwFFEl4Tjb
   ytmK6IU8YfoD/RpAVbN2pl+37yeGCkKysKrpQPbCuywZ4gQC1kOiC5iAd
   tghISdvRvSWH2sfZdaG4SMwa1bmAoZJMYfA/DZLlyzdHrWBz68dP/JJWJ
   EooH3DrcOD3v6gJ8kb9LM+Eu03czmqhErSAIT2I8RDnTybHOIuWqHnSEg
   LI6F3f8u+4aZd1ih8+Yoc50wAQhI/v2liWkfLVcn1yC5coxs4UqJYAb5n
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="429148011"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="429148011"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 20:49:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="1052896332"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="1052896332"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jul 2023 20:49:02 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 20:49:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 20:49:02 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 20:49:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXlv4QPuROEprmqdriaSKEke+xwGvR2Ymz6G0yMRZTWXAFW45gBWP0/+krwxnHd9Ka7XXDc7LFds3nEWaFt7G75npKHSGtefhskGFKL4vHQELqcMGXaBhALQU9l9apHpmsbkm5kiJik/dWf9qmU5O/yAigwQH33hauvKIeiNqMqPxpzullUVkF/37J1OKQUlvhnDPchNaa1IGjXm9T6kcpoXEBWxsYn8V6xxEzPeeXPc8nyx6hnKW3uRw6Brih6G5WteofFmSkmbEU8PzCaDOmtvNEqR9FvYZ0bXmZOAloK9jAb3ll+rXqZiRTWNXup5ZMykfynqtAaHT3Ot/sM1Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRVC6qyhmzQ51mQMiost6BSPCS+HJvzCW/fQJ5m5FhM=;
 b=Is80dLYuy+u/Y8onww2Q+SH2d9cAafD/F7zBnwhbvNQtZ94Gkx9kLz/DmNcF46r787HGTRPfEWS7DTWKpmInOdk9vwJqs+G12ND/bH6/wT47NHrO9Rr67Wm7+9+h7J/ZEBGwlvqR2rcmxtSL3Z46uP+OfJ5yGWGfLXJWOSspOg7hws7tPdcE0+NNrgW80sAcAa8KYRt/hfFsUQBj0T+pnphLW/IPGnO/EvhUI6MFjnPfS8AoAXGN3R7Jjw0f44pMdzBbP/JPrQlkgK/G7Tcu+AYhflB8Em56qLif/VjUk4pDCHhdSqaX1ZHx51QDun1MFEQrdcmbOLUCToMs8OUNdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6676.namprd11.prod.outlook.com (2603:10b6:510:1ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 03:49:00 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 03:49:00 +0000
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
Thread-Index: AQHZtN37ZjGAjXNxukKTOXN/kBSnIq+3UoFwgAFKNACAAAVf0A==
Date:   Fri, 14 Jul 2023 03:49:00 +0000
Message-ID: <BN9PR11MB52763423F2A18E927065C8EA8C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230712163355.3177511-1-jacob.jun.pan@linux.intel.com>
 <20230712163355.3177511-6-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB52761F5CDE22E5C3C10E7E728C37A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <9875863a-eba5-c8fa-a39b-7d3300e3b5ca@linux.intel.com>
In-Reply-To: <9875863a-eba5-c8fa-a39b-7d3300e3b5ca@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6676:EE_
x-ms-office365-filtering-correlation-id: b2deb052-26b3-4c37-e417-08db841d4262
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QAUe0WBxc3qXokLlzF57mYgnrNJkKC0J5bAcj6dWSnqgia4JLno/FDHnMyU0OdC7Fel+eB2FZ7Tw7ucP2btLVlcxB4OFz+41976cYP8rBWJIwHSdwu7SMpiGCzNsMQGfVWwm/i1n6ynEBUdPt0XUcFTkYa13pJlctYcse0PDty0bB8ZLiNpm+b/iPhEwFULF+npfT0LWKCYrD84FQsUlLX/BzSDrJ5mrfCWg92PEHw7748WKH55/2QW9UoAelohNGsJkozFx3MHHPuO7drr0IEP2KqMWrSeChZPsME85x2UBTmPX9uo/QKcKeasXjVMzunG4SYrUQIaVn51BUU2WOV03lkoSG9mX8+EgTJikKqmFUyzPiA8g3ZQVKWV3x2tMgaoDIxG83iI0yahj5B6rqtyC8SrTu1ODUVKqerc+43l27rc4BezpJjld6+gNepjC8xFlTLc/nhZmuQQPWz39OxwW2tQPA7rH8cqjtQ6SL0YQaPX4kMmOI1knQj0RsE7WsBgmYWAgGMCzeT3cE51wbmns06wAQYZHg0r5MMzcG83idu24UM15Ol2Zoh5do6XROzYx1p7NFHlEpakiAWE9pCxobIAgBho97JDaNCTZPkbZxa+2WrtF16VFQzj9KzuQ7e2/LK7GroO9hBMdyn4APw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199021)(2906002)(55016003)(38100700002)(122000001)(9686003)(82960400001)(186003)(26005)(86362001)(53546011)(6506007)(33656002)(52536014)(5660300002)(38070700005)(8676002)(8936002)(4744005)(478600001)(41300700001)(110136005)(54906003)(7696005)(71200400001)(66556008)(66946007)(76116006)(4326008)(66446008)(66476007)(64756008)(316002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1FOTFpzYnFHcjYvVXJkRFIvQklnSzI4WHM2ZG1pa0tjTHNPd2lqZXNQOWIy?=
 =?utf-8?B?UUdUYjVNMURoRzZmZ2dvNUNiR0FEVTNqTzBTWTBOUzVTdjM5bVBSNTFFQlBW?=
 =?utf-8?B?UGdhV0pWUVFpcld1eUR6b0NPSks5WmVYVmIwQy9IS055MEFjS0xWcTNUbkpG?=
 =?utf-8?B?K3pWZ0tlS0NZSVlhOTQ1UVJvWHRZeUhlY2FMRjZjcmNBbVcraFNYMVdMMnRx?=
 =?utf-8?B?OFlEckdudzJZcUlLb3c2UlRKdWlGRVdZMDdnN1ZhMVBreWdTc1AvdzVzcEV0?=
 =?utf-8?B?em1ncEFPRnRuOUpuR1QwQUlWdlBQUnVadjQyWldhOWJGcnZFdEhZWlRZdHJq?=
 =?utf-8?B?U1BrWEp5NHhmY0pQWWYxLyt6c1FYSnRTclpQNDF0eVpKNWVTNmpoSVhaNWti?=
 =?utf-8?B?ZjVsTHRJSHhtUW1rZlQrTGd4TGFvckpoQlQzMzhlMUhqeUJrdkFZU3ZOd1Ry?=
 =?utf-8?B?MGwyb2ZGbUNqVE55bWs0ZTh5Mm8zalYwa0U2cjF0V2xJYmtFRWhFY3hmbmo0?=
 =?utf-8?B?UDRtMll0Mzg0QUVtaVBGVGMxUlpPMkRwYUdsZ3AxejZaWDFUMVdFNEtDNGZY?=
 =?utf-8?B?VHlMRE9sbnRFVmFtd0N5cHFPSWN2QWtqWGtBOE9EeTZsNS9weklSVkdQaTlT?=
 =?utf-8?B?blpPNEswRVpnYzhXTjBxemR0Y05Qa0JISWowbUFwMVdBSjVqeGpjcGVwbm85?=
 =?utf-8?B?dTFxVzFjRjB6aTRSSkxmYzBISkFCVVN3K1BPUFJZeFk3UWQzYy8xcE1uQm9W?=
 =?utf-8?B?RkFVR0M4dHJDNnpibDgwODBleDVJVlVFYmltVjUrbWpoVnlKdkFXZ2FjZ01q?=
 =?utf-8?B?SDhGZW1BVGQ0ZDViUnBBODNaOGlWQ3V1SjBGLzAwNDdFMTBGWW5GOXBzczU2?=
 =?utf-8?B?Ly9hcUxKek1mYlZYc3RVN2x4MVNCMXVGd1lxN2VORWRIRzFsY3BIMnNMejdM?=
 =?utf-8?B?Uzd5OUNNWWd1cEo4Lzl6MWxqTkZ5cGF1RjBJT2Nmb3B1WkJPWmFRZmVmcGda?=
 =?utf-8?B?Q2cxazN4alA5d2RSWXV3bjR2emh0dVlwV0plZk5kUGdrMjd2Mm4yNE9ZeFFj?=
 =?utf-8?B?RldUSUR2ZGdZdktWNFdMMG9mSHgzVnc2b0ZKT2VGZHNTVjZEcXlyTldTMDJB?=
 =?utf-8?B?YkNNQmYvbHlZSGJOMTVKOEZrT2hMMzBXVitQRHM4anhwTlZmOTg5OWtXREk2?=
 =?utf-8?B?NG5LVTJDS0lhMlpZcWI4YUR6ZTlMcUE5dDdpdWxTc2xZclVJS3kzbk5vUDU2?=
 =?utf-8?B?eVFqdjV4clF1TDdBVnNiOVBTRTdGMitYMG9wYXFtVFZYQ0JpUTRFMzM1Wks2?=
 =?utf-8?B?OWRjMU9NWXZtWWYvc1BEQzRYTGxzbS9ud0c3SGQ5UWVNZjVMd2ZvT3BlOWo0?=
 =?utf-8?B?RVVWQXduRXdmRWR4NjY3SG5jK0x2QVo5TU90aFNjU01rTmRKbEE1b3dhQUFz?=
 =?utf-8?B?WGV4enI2RTgwNGNKcEdJbVpwdnVWcm9CTmV6SW9aeFJ3WlZVemRpK3lLRHYx?=
 =?utf-8?B?QXp5YWtJanpzeDIvaTdDV3RvWVIxL1BPazVrOXhCR2EwZXU3UUhqTEd0L2NK?=
 =?utf-8?B?aTZ5a1hSaEdtWFhjb2hkOFZGVlZYR1BXK2t1N0RhbWZXVnJMU1Z0ZTRYR0pK?=
 =?utf-8?B?Vi91amN0eEgvTzJSWXRBcFdWVkttTWFscnl2N1p0Njl4eE5SL2pYcFNvRUR0?=
 =?utf-8?B?TWpjQkRNR3F2Q2ViWEs1U28yOTBVVW11MmZEc3ZBb0kwcEVpdUQ1L1NWTDhi?=
 =?utf-8?B?NEVVQTc1N0IwOHFMeW03aXVGTko2QzkxemIwMEx2RU9KT1VmcjNGTTlVODF6?=
 =?utf-8?B?UThzcDBJN1ZRbUpXUGRQZ0JhUW5WK2Y1dklyRmVES2Z0blVGcG1IWGFUUFZB?=
 =?utf-8?B?VzJDSTMyOHg5bXF2U1l0Z0Exek4yZ0NvSmZYNHZLd1V5dEJCQ213QW01emdz?=
 =?utf-8?B?NFpQQWl1RlA1MnMvK3JSdmZBTGZtZFdLd2s1eFo4K3l4elpkcjE2aUNsVSt0?=
 =?utf-8?B?NS93aG5WUk9PVTU4RVRNV3BtTlRkZTM5MUk1eE5kOGpZWEtTU1BJNVZ5a0g5?=
 =?utf-8?B?VHFSbEdoUU94QmxXZ3JEMTBiMUVMY3NVak00aXF5NWRnUFdXUStSWFJmVEdT?=
 =?utf-8?Q?LsiSdMWRUXLnyJnpqVG5RFluw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2deb052-26b3-4c37-e417-08db841d4262
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 03:49:00.5584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 66APKPjmxyAz4tP0l8SLgjNgKUqT7r6EIpv+0k0DcUTtpXsuU9BTDTkVsOQLPTHh4Do6pXYLtiq/hRYPa44dHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6676
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
YXksIEp1bHkgMTQsIDIwMjMgMTE6MjggQU0NCj4gDQo+IE9uIDIwMjMvNy8xMyAxNTo0OSwgVGlh
biwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEphY29iIFBhbiA8amFjb2IuanVuLnBhbkBsaW51
eC5pbnRlbC5jb20+DQo+ID4+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDEzLCAyMDIzIDEyOjM0IEFN
DQo+ID4+DQo+ID4+IC0JLyogRG9tYWluIHR5cGUgc3BlY2lmaWMgY2xlYW51cDogKi8NCj4gPj4g
ICAJZG9tYWluID0gaW9tbXVfZ2V0X2RvbWFpbl9mb3JfZGV2X3Bhc2lkKGRldiwgcGFzaWQsIDAp
Ow0KPiA+PiAtCWlmIChkb21haW4pIHsNCj4gPj4gLQkJc3dpdGNoIChkb21haW4tPnR5cGUpIHsN
Cj4gPj4gLQkJY2FzZSBJT01NVV9ET01BSU5fU1ZBOg0KPiA+PiAtCQkJaW50ZWxfc3ZtX3JlbW92
ZV9kZXZfcGFzaWQoZGV2LCBwYXNpZCk7DQo+ID4+IC0JCQlicmVhazsNCj4gPj4gLQkJZGVmYXVs
dDoNCj4gPj4gLQkJCS8qIHNob3VsZCBuZXZlciByZWFjaCBoZXJlICovDQo+ID4+IC0JCQlXQVJO
X09OKDEpOw0KPiA+PiAtCQkJYnJlYWs7DQo+ID4+IC0JCX0NCj4gPj4gKwlpZiAoIWRvbWFpbikN
Cj4gPj4gKwkJZ290byBvdXRfdGVhcl9kb3duOw0KPiA+DQo+ID4gV0FSTl9PTigpDQo+IA0KPiBX
aHk/DQo+IA0KPiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgcmVtdmVfZGV2aWNlX3Bhc2lkIGNv
dWxkIGJlIGNhbGwgaW4gYW55IGNvbnRleHQNCj4gaW5jbHVkaW5nIG5vIGRvbWFpbiBhdHRhY2hl
ZC4NCj4gDQoNCm9oIEknbSBub3QgYXdhcmUgb2YgdGhhdC4gQ2FuIHlvdSBlbGFib3JhdGUgdGhl
IHVzYWdlIHdoaWNoIHVzZXMgYSBwYXNpZA0Kdy9vIGRvbWFpbj8gcGFzaWQgbmVlZHMgdG8gcG9p
bnQgdG8gYSBwYWdlIHRhYmxlLiBQcmVzdW1hYmx5IGV2ZXJ5DQpwYWdlIHRhYmxlIHNob3VsZCBi
ZSB3cmFwcGVkIGJ5IGEgaW9tbXUgZG9tYWluLi4uDQo=
