Return-Path: <linux-kernel+bounces-141873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4EF8A2475
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB06428490D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFCC17BAB;
	Fri, 12 Apr 2024 03:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i8bkmrVO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEA6175AE
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 03:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712893086; cv=fail; b=i+e7XzU32D0IyGiH656Po67qfp7hlwNbhUlTon4A56ZCpMBFVXARsOnVDBMcYdxCtgS8Av53VbNJHsHmXwMh/EPY4j5u2Cl3xXALiO1IFpob9ro79u6TuQXIQZSEcQrvN2b5h/IoDm4ONNTdbhc+Ad1wkPcwb+Y//5iLcT38GEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712893086; c=relaxed/simple;
	bh=Io/vgaDFFKIyt6a9IuTNnUNgR2DdTPR+vQWH3wlnngw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WHUIavDeKJvQyCHuH5yc+vqDo9zhjfe3j0Zqzd1NTX/rxvnmZLJLEspfBWe4IiwtcQTqVppWMyKMVb//eZWqmfh7pQ6GaDROv0LBOk05DNlnQh240hwZ8s7ePaDBO4yXSNGufsc0uPPztNZu2dsd8UVtc6KhdHlf4M+JPhyMnPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i8bkmrVO; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712893085; x=1744429085;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Io/vgaDFFKIyt6a9IuTNnUNgR2DdTPR+vQWH3wlnngw=;
  b=i8bkmrVOZTftfoGqmWSL0HgN7/71TTDTaiX2wOfRDPglJENvpPYij6eY
   gafAhdO3tIvCKQMtanTE2tSdQ3aXYNHb2AXi6uQpn/Q2F9RlSi+MWs014
   WPjFMB+SEiqrPDCp8udAgNKUdAcj1Yy5k3lrx4X9D8RUHdVFYlbkmVJUs
   7zHbRGfqt+ncRy01jsClE6y9YCVQiX6kFDkxauNhGcBkfcvqheSI+oiUe
   sj8cG9Z6essDoUbjAvQZUhqX0foPM8iEg9BVYJDztJNZi5cUdXEJQEXMw
   uKHU4V0Dvse7ShqbsJXhQ1Jb7zkLI5EiC0++mtc96hKD4mbUUCCyv8Mo0
   w==;
X-CSE-ConnectionGUID: h2i0sUVbThSXzDW924g2oA==
X-CSE-MsgGUID: slpaLtePQrugNPltdSjxOQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="12122498"
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="12122498"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 20:38:04 -0700
X-CSE-ConnectionGUID: n7BB4SAGSG2sP0BaxnTPnQ==
X-CSE-MsgGUID: /eaDByYYTJKY/TqoD6Vo8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="21155967"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 20:38:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 20:38:03 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 20:38:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 20:38:02 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 20:38:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHErvsjCAN+k6dkSQabWk13sMzHLg8/cjbgQkmA7vQ48hNytfO3+ZtxPMlJcSwdIzI3F7eNDAx4eqQBV/PGLmeLKW/Lh6DoBL79o25LC6pPhTgM32Xhls6AYhwHLz7Q6U2KEne79/G3rbg/3pu7FNKLT6pgrDdm3v0cC3NjNa6pTE/835w9eac1rYflISoDZWMnMNqcLcDp1CTLlr6npD5zBeIT5VIOukh0mdiVNe/cRl3nrzYgvvHSXagNOHVddBbOs7M6igc/hrr3CY1IyBeUXxGUzeHNb57phlZJjCj0p8L5dgdi9nZGP4+1KwR5O6d1h6wGD7z8V9nmpqntOXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Io/vgaDFFKIyt6a9IuTNnUNgR2DdTPR+vQWH3wlnngw=;
 b=HPLdPVyXvcVI0aLH+NDncW4/SYCNPShYDWDAVfMiz58YjjTFWdpBd0Qe2uOTT8L9L/tE/soFE61hXctd9WYemfsEERJc9QaIZGDIND0SajhcOcmgsURm34HxTCNdNgZXTdsx47JSDSzMfGOrQwlIA5GhBlNoDN7NsBfheceLvyJ8QBVMvbzDk+ylrRGqd+LqMLxRHjJMhk/NwWnkC3qV9o2yDTn/xH9M0sbNoRXBf3zwqzz54RpKMNPlSe8cbL3V3HYfGH2YSdoRKq06j1U6H/dBcmgZwwpPyoctLzIM+ly1fvEf2eBa3O4WN/YyUnjX4n0pbO4VlbSaYpbG6K2y/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV8PR11MB8463.namprd11.prod.outlook.com (2603:10b6:408:1ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.10; Fri, 12 Apr
 2024 03:38:01 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Fri, 12 Apr 2024
 03:38:01 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, "Zhang, Tina" <tina.zhang@intel.com>, "Liu,
 Yi L" <yi.l.liu@intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 01/12] iommu/vt-d: Add cache tag assignment interface
Thread-Topic: [PATCH 01/12] iommu/vt-d: Add cache tag assignment interface
Thread-Index: AQHaflqwfTup1ArZ00iKq9wT+H7xNLFhvmwAgAFfT4CAAPsEwA==
Date: Fri, 12 Apr 2024 03:38:01 +0000
Message-ID: <BN9PR11MB5276E9CEFDF2D5310D1508568C042@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <20240325021705.249769-2-baolu.lu@linux.intel.com>
 <20240410154134.GG223006@ziepe.ca>
 <40b32537-b2c3-450a-866a-82cf4686057a@linux.intel.com>
In-Reply-To: <40b32537-b2c3-450a-866a-82cf4686057a@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV8PR11MB8463:EE_
x-ms-office365-filtering-correlation-id: a2300453-c93e-4fab-cad5-08dc5aa1f40d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C5hWtQ/ZS/efC9aGOoJ6RVquVwm7W1OTRhZRvaiC27QQczuJJSZYQboEVQ8DeBwyZdu70D27JtBwFkQ1q0vfcMbl6IxDx+C0KK7jY5Yy4ifW08RNE4u/88si/KQBOwP0vSv2UyUrft2bnXOkAJrTXSuowdim2QEiv++Z9i+wvpN/Ty25ghcD67azk8NkpvO1JqpMyLWmsy5TyY/ZClJ3Lkujtv0Nrp/x5tI4NHPB7M0QB84UA6iOIg2yp425Y7YRE4vYYiXUt5wyxHv1LT20QYnYb1hWsJHbFlvdjLtlPSKJysX3vLMgBIN78tBCSUHPcr25efX1DXchHxVO82F3PssYJqzi3gWij6E0XzPKSDQKuOmAUbEcCPIR0Wm7qHV8ua4m/dRpLaRtnPpo3gedltt+Zp3fVXIjkQu19G8GUi2DIs0VgDfjWJh8avP2MdRejbDsBix702Y4IfKMxKUywHZC5UDrqQutUi/t5+dMMwYWffLrOCRccaNWoKcbaDCOusGJ9dShOcu74IantW5R6sf5O6w649NXq2epSUmGlWRYRtmvip520WsSw/V59mUF5Qd2rTPDNNsTnJNM4f2OS7ccsmKXdZqJ2PRqLcmBwKp/Z++r6z4eLfCsMiVLQyjStCvxKpcj10jGiPCuM417esKqC7CQ5hoGHIeOfL1EmG+TP3XpPeM5sgCVUpj6frmXo8doRYtW7HzuO4zGnoVcsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajRsbXFMd1FvSTdXRndMcVBkU1cwNzM2UWQ4VWhySml2azdSMHIrM1hYaFRY?=
 =?utf-8?B?S3dCZGd6enpmNDErUmhvb1o2eFRoVmNRV2ZZWTdSK01FZWhJNGpHZXEyb2dO?=
 =?utf-8?B?dmpXR2ZJTGZtVGFEOXFoRm1TWmVQVnpCdWY4U0dIZVlxSDJHcnR5RzlJamgz?=
 =?utf-8?B?dmJ5VlpvdzNGa2tMOG5pbWNXeFU3VEZSNTBSbVhzKzhOZ2swbGV1SlljRFZI?=
 =?utf-8?B?elVkKzJYM1lpUGFleW5wd2dHZTJ4eEM5VWlsM0NGclFNNk5uQi9qak0zaitI?=
 =?utf-8?B?TmlvOFloaFltNmFVcEVJWE5xQWZNaklabHRZSUx2eFNCaHhmSnVQZjRMbUxr?=
 =?utf-8?B?L0ZZZHRJZHFndElTWVR3TTZ1c1oybE5aL3ZQdmpyM1RTVDVQTGxKUnU2QzAz?=
 =?utf-8?B?NWxMTys3ODBzZ2RKTHdEVHNWVU1vN0Y1TEExK0JWQWE4ZU1WcWoySVJJYkI3?=
 =?utf-8?B?N0xsMEVNM1dUMXB1TmtuYnd4TWlwYzNhdjNVaExvcUNDMGxYbmxTTmliNFVU?=
 =?utf-8?B?S0hKaDViT3cxZitobUN5VVVtTk80eGRnYnJHWlQrank3VVVMWTJRTWlzT2M1?=
 =?utf-8?B?Z29IaURMVVFtZGltOG1KNHdDVFo1RWpiNDFpbUxsV1YrMGxaYnRQM3VJS1o4?=
 =?utf-8?B?aVZUT1R4ck9zWFhiSnU4NkhjeTFaSUE1Y0IxUEw5VnJYb3RHdzRsaHNMZXBn?=
 =?utf-8?B?eG1JQ1owbzVnU1o3QXRpdG5Eb0tYZ1pOUlZGa2NXQXZ4L3hDL01WSmpuQjdl?=
 =?utf-8?B?MVZZVTBCeWRMMUtHYmlBYU8wQ3FZY055UEtXM29GOTA0NmNkWkVMN1YzbDI4?=
 =?utf-8?B?S0R6bXh1M25ubGx5SHRYWjZGUlZqL1VQbFdyN0x4cGFRd0p5U2VVNTlGZi9S?=
 =?utf-8?B?UVpHNGpwT1crMEZOZ0VLN3E4Sm1obzJ2YnRCcG04Q0FPOWg2ODdLekFLSmdK?=
 =?utf-8?B?ZDNZVzFNVzRtY1VoQ2xMeVl1cyt0VENHeGdURFQ5V24vRWVTVC9TdGpmK2E3?=
 =?utf-8?B?a09WSEREK1RrYWE5a1A0d1NTRDNCN01YbHJXRWlieG0weG1Ld05GQmQwZStR?=
 =?utf-8?B?TVp3SVkwQ2Q1dThZeVZIM01zZjZJTVEzWndUdzZXOGVBZnhDaFFNcDVaU2RR?=
 =?utf-8?B?dWJneG9EWUlTR1A2WjFIM3hxdnFoYWREeldvSFF5U1lEVm1FUFVHVWs2V1BI?=
 =?utf-8?B?dE1uTFJDRnkvdTN2U2FSR1hXNkVGa0VFbDNOUTlwMVZyUmxtY3VJTEEzK004?=
 =?utf-8?B?REg0cXRFTjlZNG1ubkFUL091VlFjMVZNRVdmRzlIMDVYZlo5bkZrU2xRQ0Qz?=
 =?utf-8?B?dTlzTGxQcHRjMElTYVJadmlVZTd3S1JUREQ3RmxHa09mS3JKTi9YUEV1UkFr?=
 =?utf-8?B?TjQ4dnZUSGk3Z0JsTVArNXlXMGpaQStvZTcyM3JiR3cvdS85ejUvb2xTUE12?=
 =?utf-8?B?QlBMQXY0dUNvWURpR05ldnFzR1F3Wk82Z1BxbjFCV3RFcXpMU05BQnJzaXpY?=
 =?utf-8?B?WFlROUM4WlNHWWhQMVJWV0p0Z3Blb3pKNWZOdTg2NlpiMlBBRmVDNWtiK2dE?=
 =?utf-8?B?UFhpZkR4SC82ZGFCOUs4b3phZnVLdW9IN1Urck1ySG1jVVdlTC85bitMTE4w?=
 =?utf-8?B?K3FEaTc0OVlmcUszL3dIRGg0Qm5MS3k4aHV2Z0h0OTBkMjdseWFrRldVR2pC?=
 =?utf-8?B?ZzFjZTQ2emJWVitNWGZPL2o0M3k1UElTMFBZWlZvSHlUQkdPKzk2eklaZU5i?=
 =?utf-8?B?V3YvZ2p3TjNTc3NNZG1NNFFJdWsybm1rQ1pRb1Noa1F6Ukg5dXJJdnNWT2ZU?=
 =?utf-8?B?WWlIZVFqK242MlV5aWR3bzBZaVNYTDR6N2wyYkVCUjdVVWEvNWc0N2VyOFRT?=
 =?utf-8?B?L2JGYWZITlcyeEJZQzU4Mi9GRjVVRUp5ODdXQmF2aTM4V01yNHR2cFlybnZI?=
 =?utf-8?B?WS9SNmlIV1prSy9DV3pHL3N0WXJGVEtGM09tMUdhUmdMVERMUUEwYnpwSGp1?=
 =?utf-8?B?Q1lHR05uOXpObnorZjlZc1BkNWlyRzdEdkQ4Y1ZDazZXRytMTTRrWmh0NVVI?=
 =?utf-8?B?ckhWQ1IweitXOTBHUkJGMEI5a3hBcFpoTC9oMFpOMzhKZTZ2bWZBMWwrRStM?=
 =?utf-8?Q?cnqnTCzr9S9s5Nvs3BML+cCNM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2300453-c93e-4fab-cad5-08dc5aa1f40d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 03:38:01.0460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERaSOTILdSb4WjhpCHLrA/CqUJwN+swd+eGrheJXOIMHIMq5EVe3Unu/yuaH/0d/8J6mJSy+wBezFnml31jLxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8463
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgQXByaWwgMTEsIDIwMjQgODozOSBQTQ0KPiANCj4gT24gMjAyNC80LzEwIDIzOjQxLCBK
YXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4+ICtzdHJ1Y3QgY2FjaGVfdGFnIHsNCj4gPj4gKwlz
dHJ1Y3QgbGlzdF9oZWFkIG5vZGU7DQo+ID4+ICsJZW51bSBjYWNoZV90YWdfdHlwZSB0eXBlOw0K
PiA+PiArCXN0cnVjdCBpbnRlbF9pb21tdSAqaW9tbXU7DQo+ID4+ICsJc3RydWN0IGRldmljZSAq
ZGV2Ow0KPiA+IGlvbW11IGFuZCBkZXYgcHJvYmFibHkgZG9uJ3QgYm90aCBuZWVkIHRvIGJlIHN0
b3JlZCB0b2dldGhlci4gV2UgaGF2ZQ0KPiA+IGlvbW11X2dldF9pb21tdV9kZXYoKSBub3cuLiBJ
IHN1cHBvc2UgdGhpcyBpcyBwcm9iYWJseSBhIHVuaW9uIG9mIHRoZQ0KPiA+IHR3byBwb2ludGVy
cyBkZXBlbmRpbmcgb24gdGFnLiBERVZUTEIgbmVlZHMgdGhlIGRldiBhbmQgSU9UTEIgbmVlZHMN
Cj4gPiB0aGUgaW9tbXUuDQo+IA0KPiBJIGZvcmdvdCB0byByZXBseSB0aGlzIGNvbW1lbnQgaW4g
cHJldmlvdXMgcmVwbHkuIFNvcnJ5IGFib3V0IGl0Lg0KPiANCj4gc3RydWN0IGNhY2hlX3RhZyB7
DQo+ICAgICAgICAgIFsgLi4uIF0NCj4gICAgICAgICAgc3RydWN0IGludGVsX2lvbW11ICppb21t
dTsNCj4gICAgICAgICAgc3RydWN0IGRldmljZSAqZGV2Ow0KPiAgICAgICAgICBbIC4uLiBdDQo+
IH07DQo+IA0KPiBJIHRyZWF0IEBpb21tdSBhcyB0aGUgcXVldWVkIGludmFsaWRhdGlvbiBpbnRl
cmZhY2UuIEFsbCBjYWNoZQ0KPiBpbnZhbGlkYXRpb24gcmFpc2VzIHRvIGhhcmR3YXJlIHRocm91
Z2ggdGhlIGludmFsaWRhdGlvbiBxdWV1ZS4NCj4gDQo+IFRoZSBAZGV2IGZpZWxkIHJlcHJlc2Vu
dHMgdGhlIGxvY2F0aW9uIG9mIHRoZSBjYWNoZS4gRm9yIElPVExCIGNhY2hlLCBpdA0KPiByZXNp
ZGVzIG9uIHRoZSBJT01NVSBoYXJkd2FyZS4gSW4gdGhpcyBjYXNlLCB0aGUgZmllbGQgc3RvcmVz
IHRoZSBkZXZpY2UNCj4gcG9pbnRlciB0byB0aGUgSU9NTVUgaGFyZHdhcmUuIEZvciBEZXZUTEIg
Y2FjaGUsIGl0IGxvY2F0ZXMgaW4gdGhlIFBDSWUNCj4gZW5kcG9pbnQuIEhlcmUsIHRoZSBmaWVs
ZCBzdG9yZXMgdGhlIGRldmljZSBwb2ludGVyIHRvIHRoYXQgZW5kcG9pbnQuDQo+IA0KPiBBIGNv
cnJlY3RseSBzZXQgQGRldiBwb2ludGVyIGFsbG93cyB1c2VycyB0byBzZWUgbW9yZSBhY2N1cmF0
ZSB0cmFjZQ0KPiBtZXNzYWdlLg0KPiANCg0KaXQncyBub3QgYSBiYWQgdG8gYWRkIGEgY29tbWVu
dCBmb3IgQGRldiBoZXJlLg0K

