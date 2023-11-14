Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4017EA9BF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjKNEpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjKNEps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:45:48 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA56FE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699937145; x=1731473145;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5nKSULytD5rX5xoHLhDh3I5DkBdC369QuJDNZ4VZi2o=;
  b=ZBnxFiz5UHOg8E9GB+sYfFfX+X4lEtQeWZW5RzQqaDa3AgmkcUZPz+J6
   0C2x1Xj8S+gpWUwLrScurte5hYxirECRyzf58uMWW2nXaCKtyR6O0Muf/
   7d9bky+8G5j0uVwTj6P2FkcRY9lovrnIvr7Ng3OVpnQd1ZpAJq3IlFrmF
   rY5xN2n0O33Vl1PhQn7bWXWpJhXwoeBorPIoABJzh9fpaurAxsNxLYxri
   yvw6+is3m+es5DyQjZ/gA/71yCKDZD/RyrmrCawPOuaal4E800CiYYZfu
   uK9Xc7hsIXiH56pHB7ohht466YZ0wOSHj5r30Gwm5TygbRz0mgUg+ed34
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="12125114"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="12125114"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 20:45:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="830469152"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="830469152"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 20:45:44 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 20:45:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 20:45:43 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 20:45:43 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 20:45:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTRlMRYZg6mb8OimU3/kS4fXsiYPpDefR4jMuTr6InTuK4+4DqtlxREeElWBTuQd+fR8wSsIWzqHcdmbZkihicuQQ38q0T/D5dp1cZMT/mjysq/b910Cmo9sFjTH72MFwX2ZYHzegLUsXphsy+aotUSpOM5+OwCyM+wQAQ4Fpjt9LETDExp+mx0pdZB48lxrYwh0KCOhtJ6ssXio3WfWp6cpvdu0jh/3tF0R2PFL4T4WTdLqKINlI1zyu1xIutuwsZQPXuc1gkbbMhvL69vJXjIMTabzu0kGTu5xFU9HfiAipcTHnRNov3JliaBIyD1aMIslmCHDrawMm55uzwvWpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nKSULytD5rX5xoHLhDh3I5DkBdC369QuJDNZ4VZi2o=;
 b=VMC7wHjucpTH4OnA73Ry1S8K4lLvWlmO5EYqnCqgt0xqIZsvIesGX1YD7d0O1L41VvKmrIM83aKOOurVF4xCkWMfnmnBG3MMXcrKNAG/Ue3o/0F+AHfhc25JklZqGKktBZdPYTzE7K3DmmHg4T+dxbG55GVHLfmFHFt0I/yEJS4yZ3ycLG4dwG1xIAy4blOXwLg2en+z2E27y+MIpN+RUUD/hwCBQkGFoQIDC8roF0oHkvnbT6/3CwDjUlLdw+xBnEh+zxduyVihkE9sUJ2w8SPlYIRYHuoV2wJDg5veLQfKmewIPcWpLJjvGaxyVq0yBG9TEookOnHGn4mgS2PyRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4547.namprd11.prod.outlook.com (2603:10b6:5:2a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 04:45:40 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 04:45:40 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Omit devTLB invalidation requests when
 TES=0
Thread-Topic: [PATCH 1/1] iommu/vt-d: Omit devTLB invalidation requests when
 TES=0
Thread-Index: AQHaFpgA5wtOoye5ZkuI8htuBJqfJLB5I8pwgAAAI4CAABlw0A==
Date:   Tue, 14 Nov 2023 04:45:40 +0000
Message-ID: <BN9PR11MB52761EDB3AE90DE87661A3C28CB2A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
 <20231114011036.70142-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52764263BE04AAFAC0907A8D8CB2A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <1a07a265-f834-4834-b9cb-5c7016ee9142@linux.intel.com>
In-Reply-To: <1a07a265-f834-4834-b9cb-5c7016ee9142@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM6PR11MB4547:EE_
x-ms-office365-filtering-correlation-id: 4f6fb10b-e605-4eab-5b9a-08dbe4cc8d98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8wvIFBozhWI26M7ncGAUsZ+K3542cyg8jHi+F/882K4NW+LgiB7Jzz8Wgaub39ubFBAnugeoxaTIgxZILv00iVpyoOb+2Q3g73GlZl9b23iPzv0nMobI88iN+G4nZ+B5C7kOVFVpOKamVJoKC3CbvpaoBUmBqpMms3X9FG5n8IdxGbg8ZI+MYBFkIcKg6rNAcyWRsH9u1SjoBfokVC6NjCISL8ofM588cDsx4VOoN0teaOp0ACIKS7ZlkP7L8t6crX/LTrmN8HJCjfpJOHOxfKiHWyYmhDP45uL32j0C4ujbo4mIH2jVSPyzkUAWTPQT6+Bkw9KgtcczxvnakjkGvZUbQQdCEn9sk0uT7N4C7BtwFrNZX8oONLMm9vcZMaN1GJ5UWBZmIkrfNeVerQF8rfVTQs+Muru0eYRVKSipanGKdjgObIjM1atV/FzSylsv74Uw5rC1qVrdxY3lQLa91B0bEYegEE4AxVqF2O91RrsgfnTIUJlJWvO8lu5D2Zib8U1TDUUGM6sNdj4Bh0CVM+TktnyCkrvl2PHUGF7bo+cznH+wfXdOHwoSGle2ticngwGYaWfFNvG2vOo1rsC5t+uA4HXhToAxCUV4Q6+sq7YfiGg3D+hkVn6u9l3ttMYB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(346002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(55016003)(64756008)(66446008)(316002)(66476007)(66946007)(110136005)(66556008)(76116006)(54906003)(38100700002)(33656002)(38070700009)(26005)(86362001)(122000001)(9686003)(83380400001)(53546011)(71200400001)(82960400001)(6506007)(2906002)(478600001)(7696005)(5660300002)(41300700001)(4326008)(52536014)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0d0UFVSNVBPaTlBdFpKZ3dYWkFKQXhlTTBPQ3poYUw1dTRidXdETUtLSEZF?=
 =?utf-8?B?RnNLdEhvbTAreFdNd2E1Rk1LOCs0TW96QWhCZDFEOHV5TGREbGxIUzFtT0Nr?=
 =?utf-8?B?Y0d6MCt0VmQrQXF2OUpXWVhhZm5Td1BqL0s2T0hDa0l2cjJlZHBYMEJRdk9x?=
 =?utf-8?B?K29CdmlQbHFidmE2M0V1allBdFlYbDFPRHJtMFJwSys4TGJSYmk4U2llTUU2?=
 =?utf-8?B?OFk0Mmc2NHAwaDBCa01hSXh3eGRBUVYwRU9WbnRLZmxka0JmRVo3UVFpNVlm?=
 =?utf-8?B?TUNldGp4TlAvOEVlV3BheDloN2M1TGdTN1ptaEVKTGgwRy9LK1NGakRSSkpk?=
 =?utf-8?B?bmJaZTZPQ0RYajFlSFFhWnVTaFNKYTdqY3lqVnpUZXVtOWxNWGJNc3J1bDNC?=
 =?utf-8?B?bHJtUjN1YzhWQzNEeE9XTVM5QWF4WFNDYWFZNnBnZ2dMZTVyRk5GZnA2UFJu?=
 =?utf-8?B?WmRlTm4rZHB0LzhndVowL1JFbi9NOHlUWEhrRUI0T0xYRlFaQ2h5aEIydW12?=
 =?utf-8?B?RHNMUEtHRVNFaEhHb2pvdTRJMkdFZ3hNZU5pZzBuS0pzaHV3bTlZbkZubEV6?=
 =?utf-8?B?TVdmaXhsRDNjWVlZNWU3RmNBT2grQ045ekdNcmlFcjE0eU5yVzEzMXhIczUz?=
 =?utf-8?B?TjhGbHlKRmVxK29QakllakhYVmJERHNOY2l5cHRTeGhFRElmdnc3TFRQSFJt?=
 =?utf-8?B?RHpWbjdBZW1uUnk3d3hKRU1qckg3UUdLSS9aRCtMcmhTanEreEZSRUY4aVBv?=
 =?utf-8?B?U1N1cktDV0pySFgrYng0MjhxZDNTakE1TzFzekUzeTJndS9hMkhyeWVMemJP?=
 =?utf-8?B?MlgxSzV5UzNRV2t5UVVId3g2NWZFU0tId0h3eG1vcDZkWkpZU3FOODVGTG15?=
 =?utf-8?B?YTVjVEdVdWJDTDIyQzdHNldKNEs2Y3g4MEVDbkFCc3ZGOEZYYkpXZk9LL2t6?=
 =?utf-8?B?NTMyRzJYNlZzdUQ4RzMyZVRHQVJwUSs5OFpESklpanM3WVNxQnJzZkk2bFMx?=
 =?utf-8?B?MUpXdDFvUVVTVW5kVXo2SkVGalA5TmJrMTlRNlVCSmowS05sSksrczUvekJM?=
 =?utf-8?B?S2lPS2J6c1BMN0hHOGF4akhIWmIvWGo5eXNtd1VKaVE3NFBkRGJsanBKY041?=
 =?utf-8?B?enhHMG9SaUNjdyszR3FQYlVDa3RTSkdDZ0RQNjk2SmVVRTROUGVqc3FhSlBw?=
 =?utf-8?B?TGNiNklEWTUxSTNsLzB2ZzZObjNpKzR5eUpnbzdxSW8wbUNrU1o3YlZvcHVD?=
 =?utf-8?B?aUoyMllEdGRMaHlKQWdxL09hU0trS0JZeVdrdStUQlJnNVR3MTgzTjVCYnha?=
 =?utf-8?B?YzlyTVgxenNoVzZaaTJ0c0hnaWZaMEZTYlJqRHQ2S2cxc2tzbE40elFZQ0lk?=
 =?utf-8?B?YW1MMDBhNDhlcGpjak9qN0lqcG5JMzBqek9zRjlJb1BuVk4xM3lsV2lmT0Nr?=
 =?utf-8?B?YUJhU1R4QURObjV1NzlncUtZK1ZYMWQwbjI0eWxCOW41QUZ1L2NZRlQ3cWVO?=
 =?utf-8?B?eWt2YzVCNGIwdU1uZU52UVdDZWRsVzNqeGRoQlc1bGxUeXIzMEJtemdLZHpj?=
 =?utf-8?B?NXgwOWw0aGR0V2ZEbnhHR1BPWDNLUjJwNGRiSFhEd1dROUoyN3E1RngzcDF5?=
 =?utf-8?B?RHpkZU14KzhNbHJiWGdaRnZyL2FMd2tKNHNocFJvZW05dFNMczBTdkJWcmwr?=
 =?utf-8?B?SWFCVTZhRFZxdnUzOWgzNTRzK3NZVnRickFETE9tTGsyMHVXQ2plZ2k2dE9o?=
 =?utf-8?B?dmdDT1dxVE5KeGp5NHMvU2hsTlhiVUdoQ0tKME5ySVlDbzJjdmtrVzI5R0Jn?=
 =?utf-8?B?TEYvd3ZqczI1dXVTaWN3MzhQbWkxMDZCV3oyb2hPN2lIUEF0V3BuSmxzb1RJ?=
 =?utf-8?B?QnJYYUVmRUc1Z01BSDZYVCtoenpDTlRvL011MXhQbExEMWJBSzdxbktNS0dy?=
 =?utf-8?B?d2RQSk45YWhpOElBWndrdXQ5ZzR6MUJUbk13ZE9FYTZSdjRaODNaU3ppSldt?=
 =?utf-8?B?NTdSbXJvMXkwWlRLTi9xM29Qd2UxbFU5ZnFTejdJMzBwUHl3NjdaTDgwZVpz?=
 =?utf-8?B?SGRQNmdiL1RNTjJKbzdjbzVRQmxXY2NrY1l5ZHk2ajY4NXRJVlNyR1VaWnN1?=
 =?utf-8?Q?lW9daQ1ZVfjBwlU4kQOM58IQ3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6fb10b-e605-4eab-5b9a-08dbe4cc8d98
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 04:45:40.2767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jvr2uQ3aP+F1qu599f0cMT+0B0ctAuMMHa04+7pRAtiB3YrC0M46yBE9aj/e2sCh38PtOAPojFbm8nV78PpA8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4547
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
ZGF5LCBOb3ZlbWJlciAxNCwgMjAyMyAxMToxNCBBTQ0KPiANCj4gT24gMTEvMTQvMjMgMTE6MTQg
QU0sIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBMdSBCYW9sdTxiYW9sdS5sdUBsaW51
eC5pbnRlbC5jb20+DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDE0LCAyMDIzIDk6MTEg
QU0NCj4gPj4NCj4gPj4gVGhlIGxhdGVzdCBWVC1kIHNwZWMgaW5kaWNhdGVzIHRoYXQgd2hlbiBy
ZW1hcHBpbmcgaGFyZHdhcmUgaXMgZGlzYWJsZWQNCj4gPj4gKFRFUz0wIGluIEdsb2JhbCBTdGF0
dXMgUmVnaXN0ZXIpLCB1cHN0cmVhbSBBVFMgSW52YWxpZGF0aW9uIENvbXBsZXRpb24NCj4gPj4g
cmVxdWVzdHMgYXJlIHRyZWF0ZWQgYXMgVVIgKFVuc3VwcG9ydGVkIFJlcXVlc3QpLg0KPiA+Pg0K
PiA+PiBDb25zZXF1ZW50bHksIHRoZSBzcGVjIHJlY29tbWVuZHMgaW4gc2VjdGlvbiA0LjMgSGFu
ZGxpbmcgb2YgRGV2aWNlLVRMQg0KPiA+PiBJbnZhbGlkYXRpb25zIHRoYXQgc29mdHdhcmUgcmVm
cmFpbiBmcm9tIHN1Ym1pdHRpbmcgYW55IERldmljZS1UTEINCj4gPj4gaW52YWxpZGF0aW9uIHJl
cXVlc3RzIHdoZW4gYWRkcmVzcyByZW1hcHBpbmcgaGFyZHdhcmUgaXMgZGlzYWJsZWQuDQo+ID4+
DQo+ID4+IFZlcmlmeSBhZGRyZXNzIHJlbWFwcGluZyBoYXJkd2FyZSBpcyBlbmFibGVkIHByaW9y
IHRvIHN1Ym1pdHRpbmcgRGV2aWNlLQ0KPiA+PiBUTEIgaW52YWxpZGF0aW9uIHJlcXVlc3RzLg0K
PiA+Pg0KPiA+PiBGaXhlczogNzkyZmI0M2NlMmM5ICgiaW9tbXUvdnQtZDogRW5hYmxlIEludGVs
IElPTU1VIHNjYWxhYmxlIG1vZGUgYnkNCj4gPj4gZGVmYXVsdCIpDQo+ID4+IFNpZ25lZC1vZmYt
Ynk6IEx1IEJhb2x1PGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAg
ZHJpdmVycy9pb21tdS9pbnRlbC9kbWFyLmMgfCAxOCArKysrKysrKysrKysrKysrKysNCj4gPj4g
ICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pb21tdS9pbnRlbC9kbWFyLmMgYi9kcml2ZXJzL2lvbW11L2ludGVsL2RtYXIu
Yw0KPiA+PiBpbmRleCBhMzQxNGFmZTExYjAuLjIzY2I4MGQ2MmE5YSAxMDA2NDQNCj4gPj4gLS0t
IGEvZHJpdmVycy9pb21tdS9pbnRlbC9kbWFyLmMNCj4gPj4gKysrIGIvZHJpdmVycy9pb21tdS9p
bnRlbC9kbWFyLmMNCj4gPj4gQEAgLTE1MjIsNiArMTUyMiwxNSBAQCB2b2lkIHFpX2ZsdXNoX2Rl
dl9pb3RsYihzdHJ1Y3QgaW50ZWxfaW9tbXUNCj4gPj4gKmlvbW11LCB1MTYgc2lkLCB1MTYgcGZz
aWQsDQo+ID4+ICAgew0KPiA+PiAgIAlzdHJ1Y3QgcWlfZGVzYyBkZXNjOw0KPiA+Pg0KPiA+PiAr
CS8qDQo+ID4+ICsJICogVlQtZCBzcGVjLCBzZWN0aW9uIDQuMzoNCj4gPj4gKwkgKg0KPiA+PiAr
CSAqIFNvZnR3YXJlIGlzIHJlY29tbWVuZGVkIHRvIG5vdCBzdWJtaXQgYW55IERldmljZS1UTEIN
Cj4gPj4gaW52YWxpZGF0aW9uDQo+ID4+ICsJICogcmVxdWVzdHMgd2hpbGUgYWRkcmVzcyByZW1h
cHBpbmcgaGFyZHdhcmUgaXMgZGlzYWJsZWQuDQo+ID4+ICsJICovDQo+ID4+ICsJaWYgKCEoaW9t
bXUtPmdjbWQgJiBETUFfR0NNRF9URSkpDQo+ID4+ICsJCXJldHVybjsNCj4gPj4gKw0KPiA+IElz
IGl0IGEgdmFsaWQgY2FzZSB0byBzZWUgc3VjaCByZXF1ZXN0IHdoZW4gdGhlIGlvbW11IGlzIGRp
c2FibGVkPw0KPiA+IElmIG5vdCB0aGVuIGxldCdzIGFkZCBhIFdBUk4uDQo+IA0KPiBUaGVyZSBt
aWdodCBiZSB2YWxpZCBjYXNlcy4gVGhlIFZULWQgdHJhbnNsYXRpb24gaXMgdHVybmVkIG9uIGFm
dGVyIGFsbA0KPiBkZXZpY2VzIGdldCBwcm9iZWQuDQo+IA0KDQpidXQgSSBkaWRuJ3QgZ2V0IHdo
eSB0aGVyZSB3aWxsIGJlIGFjdHVhbCBtYXBwaW5nIGNoYW5nZXMgYmVmb3JlIA0KdnRkIHRyYW5z
bGF0aW9uIGlzIGVuYWJsZWQuLi4NCg==
