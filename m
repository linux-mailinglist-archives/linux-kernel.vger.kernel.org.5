Return-Path: <linux-kernel+bounces-140095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D0F8A0B61
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0ECDB27F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E77F1411C7;
	Thu, 11 Apr 2024 08:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UjNwQ9RS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CE713FD94
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824337; cv=fail; b=o1fPvXQ1Ig4GEsQuA4Tfl4KJsQZrJvW8XgADPUBbe4HvjEtL1j+CHv/uuEuU/Pgufe6JTKGLjoMLhOyGdoPzLWS2TUWyh7JZV6tIl9MnkHKQpxLPt+nNLVjuR38k+hfmvDSdBIWgq49s2HQMmhdTnGuuTZzYC5aX0Q/L8U0B9ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824337; c=relaxed/simple;
	bh=ZGsQQ+RruE08jpHMRJAC8U51gCeerX6uf23HQXM3BAQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YzHj8WczGcglg83O+2T6tCRB8r8Oq691cP21ljK8/jZlN6OjLWIwCrL0kEk0gtkNPgXc/Qf/3QYjhpB0WsZ/Om9+Y6GiJUSdAlvglpn2vP2OsF9n8qZNd+/2FgrBmJ5EIAq0cPWdsiUuM8GQgUCGXm9a4gX5CBHaQyq5y0XBlPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UjNwQ9RS; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712824334; x=1744360334;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZGsQQ+RruE08jpHMRJAC8U51gCeerX6uf23HQXM3BAQ=;
  b=UjNwQ9RS5l9Xz/lrSoLSnOmqHnQIAahWcin1rS5msF+bEAEd+7D8SAX4
   NUMXRLSTQbXfAYofZ/kt2+fHoZuyY9CSdwKmzJOOB5SOhtEF+JC3pQFlR
   qni7H/PQaiHopUMLUby6ALIpKzgXzMnqiZcIJpHj+u833XWeM9vbK0K2D
   j2QuO33bO+DGW3+psRXzpoWFmDeC68hvcPpyPFoS7Z7xE+RzMNEnu9e2q
   kCdP0OcW8xFf4PNL2OvAFjftIYYBde+5Up/7e6JXKpycGwPwvRHchXQ2U
   OfzTeK/Cq/IjlqnQEdkw8sdz8EDvn42ecrY/xkgy6ifu4EcIKM+PvYnt0
   A==;
X-CSE-ConnectionGUID: EzrdJMX1TLub25XYbirA9g==
X-CSE-MsgGUID: jZoiSouKSrSxpqxWu7rByg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8384613"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="8384613"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 01:32:14 -0700
X-CSE-ConnectionGUID: SQAaHwO1TUC6zLsxQgZhoQ==
X-CSE-MsgGUID: PbRvUIIDQUKNoCFhUFSbLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="25602060"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 01:32:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 01:32:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 01:32:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 01:32:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4DUWG2wjMZ2PU90LqHpnMTzyewkw+ylu9AGOA4CBAeQEJGYt/ZptozQ9bEfM7vSoF43iaYISGDvew6Zwb2LJUvYnXqPuw3vtkrUjMk8I5PYt0GbJm/yp8n8Gr4XkZnpxG/MiMHt5j3N2zt56AWLpBJ6UkdgFfMjjzsSRJbQwmhpea+jkhnLLa1VWdRMw4wTuHH3CLqOqRjJa3qSljkL3bmWBIM6SVpjmcjO/TgQHAIKLDY7mPZrScRBfuR4dbZ+s877kR03vkRQB4fn4kZkoiRiLR8PIsjOwb66W1FD3Yl4a14b8C+RrJLsPzK1u3Uea4WurcwyG1mvQur6fcs7nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGsQQ+RruE08jpHMRJAC8U51gCeerX6uf23HQXM3BAQ=;
 b=gLGGD8PmgV3B8Ies/35jfm91sim+tV65X0VOznADyplGkohW68T/72zm98/NkrAqjPQs9yavcQrz4s2DCnpEYG/CBQ+z4YG9iTRS4+rF8qZBHBSlKW52cpmihPJtSn2w5UKLJwIghqfam3Wiks4XsgEXy8wiuTqXy3aCAT8yXJL7cQejGdCshD6wncgTGkndWfolWHOv+MKMunDkWl8uS8o8S9fSXKtbvTdEDeqg4PI92Fx0jbDuHXcpQN7gIMebflTJDK/tCvMmGESZtAHZEw67SCu0Di72pR57ssopbLg/NnmBvR8rWyZcfm8+ZyUXyEdk4EfDtBT+imM8LVLN+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6513.namprd11.prod.outlook.com (2603:10b6:208:3a3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Thu, 11 Apr
 2024 08:32:11 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 08:32:11 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, "Zhang, Tina" <tina.zhang@intel.com>, "Liu,
 Yi L" <yi.l.liu@intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 12/12] iommu/vt-d: Retire struct intel_svm
Thread-Topic: [PATCH v2 12/12] iommu/vt-d: Retire struct intel_svm
Thread-Index: AQHaiuxL0QoUUwGBOUWRwwQMu4eQMLFhp5mAgAEN5QCAAAgEIA==
Date: Thu, 11 Apr 2024 08:32:11 +0000
Message-ID: <BN9PR11MB52767D3287A7E000AD17BC9B8C052@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240410020844.253535-1-baolu.lu@linux.intel.com>
 <20240410020844.253535-13-baolu.lu@linux.intel.com>
 <20240410154951.GH223006@ziepe.ca>
 <b24f3380-1ac3-41c4-9163-56c1dcff6297@linux.intel.com>
In-Reply-To: <b24f3380-1ac3-41c4-9163-56c1dcff6297@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6513:EE_
x-ms-office365-filtering-correlation-id: bef04176-7f0c-48f0-e219-08dc5a01e1f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wdTS78TDL3OPJFn/CRM9a5Cy1QF2+zDAMvl4thGy1sUPM33DIDqdUZlkYD2UopN9dkmCmzdXLTxhsRmxT3/nKePtXZ2k/mxaALGOkUYh9gczDk3ozbJVwbzs/crsIUdULW4f9rho4hf/Pw7E3g0PTnbgAuqulAxtJUm3oFQ/9UhUdR2odW8/Idr/J4Gz/3wbrft083+PkkF6MjV5avtZnaUxsYfXxWmJr0JpiaTovM2Y/2k2fpQ+J1ZtOOAD3A4wC3Bps4R4e4Q/oP9x4cMpJlmZX51Bmz9WHfTE8HIFXTfFfa+rK5LxU+bzrETQmBN1V0DlNM1sRNpmScw9dwRCoOtBeCXBkvl7uJSD050RPcPRvLezwg68QOvD/CZFlcYz6qjTTmm/cwYJWFbKoQ9Yi9RP6ClML11a5LKTo8LNQCM3FIp1dCn5xd8sCKN4Fq47v9KSMsHmnQv/Q19KGJR7xbmLulAITTdlFC7T6VY3dVu96ORMlDW9rMko6LgF6lyopBtv4y87khbM+yGBpk3AGz9LgJWSUs/BgapTAQ9C1kUEpxYHnS+aFyyQVMHF/0BBXnXnHRSA9PmTnjYNprVigBIeyrKSx0kLCHfN5w6vZZ/tR6yTrMVynsXXS5/1aBkssUThhtuZIuyQUXlz5UDdj8Kt0+bFpJ07XNlHYXuzaFpqofGYaTiAlsUu3Q4UTs7tlKd7s15r4N/oUBU1RPkID7mm8QLirb6ua5OTEZwJTj4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkUwQzQzWVBoOVRDNWdwM3kyV0hKajc2aFUzYzNnSGl6c0VTM3BzKzJRbEdR?=
 =?utf-8?B?VjJwZ3F3VEE5UTJ0VDBrZXJDem1oNVdwOTNyM1kwa05GMFZOZFJWZW40SXhl?=
 =?utf-8?B?UVRrK0huUXZMTHZEZnRNclZFS1hxZTZWbHgzYldiRnZGb1ZkckxFakdJcVZK?=
 =?utf-8?B?RHdERVFRYjl3Y2Q1ZjFnZ2pidmtTT25lbFpXb3RqbnNYWnhCVWNIL3owdjEv?=
 =?utf-8?B?REZWTXVsSmJOUE5id2tVZ2xoRkhPS1ljRWRNeDYrMlpqaU92S1hISDg0bU1Z?=
 =?utf-8?B?bWp3V0JBTkxWeFcvU2FUMm05NUJhREZCYi9hV3ZBK1V4clNGSzN5T0FYOWxz?=
 =?utf-8?B?eHNGdW5oTmNJbDNEV0IyM29pTndEZkZlQmlvdTVCY1I0ekZLZHp5WHdXejRp?=
 =?utf-8?B?VGNPbkZzaFZ0RHlRQ0V2a2txWjJ3TG5uTHorR29MczBVRHlqRUh6b0hoTGM0?=
 =?utf-8?B?WGdzTEpkWEMxUUZyd0s0SUw1N0UrcGdsQm5FMWdPTEo5aTNpSlZVN2I5R2c4?=
 =?utf-8?B?RTAweEpIaHlmTmxTSG5KbkxzRGUzRXFwQ05xYks4TG9wK3N3c3RjTTY1Vmla?=
 =?utf-8?B?SUk3SlIyQ2wyVk4vMVMzakV5WHJvYVk2ai9QSyt6ZnJuYk84SmxDdnJ0cXlF?=
 =?utf-8?B?TmhRRmdlSytZUUhNRllqTlB3dEJoeHY2N3FqQm5yL2JoNStKazZBNkt6MmRs?=
 =?utf-8?B?eTR3WWhhTVNsbERTUVRVWUFZR1VKd3VPVktzU3BENW83NlFsb0ZaN0xuSUFk?=
 =?utf-8?B?M1J2WkhPL1VQeEpTR0dBYUk4Vjh2YVJPUkgwL0dJbmtKRVBHaHJuS0c4Y2V2?=
 =?utf-8?B?VGkxdW1HUUM4enVOL1RkNzE4WW5JZTMrYVd6NG1VT0VjY3JHT3lsRlF1QzV2?=
 =?utf-8?B?dndMbkFja3dubTIrY2pOdWNXY2NJeVpwUU9JTkhLZTUrb0pmZ1Q4dDBMSzFE?=
 =?utf-8?B?SWVZVm9zY2tabXBlUE9WT2I4V2FIMVVSL2dXN3UzZzBCNkJibGw1TlRnN01X?=
 =?utf-8?B?KzNkOU4xNVB0emJpYjd4WDFOSTBoZzIyMVlPbW51RFNQN2FJZFp6akdPSDM5?=
 =?utf-8?B?SjNYRVMvSE1jdmNJZDdlaFFrSGk2RmUzdVhza3hYSU1zcUIyOW1NUmN2Z2V1?=
 =?utf-8?B?YUpUdFZrWXlyRllnYmhlRGNud2R2OWxoZFZheGg5M21RZnZreEpPZHNDL29i?=
 =?utf-8?B?RkJveTVFcGZmamNQQUh0THFDWHA2RUJoOTJIZFVoVTJZTWVZWml4b3lmTy9V?=
 =?utf-8?B?YnlMckxTcFdxcitteUY0a3ROODJUWFpjMFlyeEdhUEQvb0VyT0lCQXRXUVFV?=
 =?utf-8?B?TFU2cjZqRVdKc3ZkV1NNcGQ4WmJDaCsyaUZ2MElhTnRBVnFXVkJ0TDlBenBI?=
 =?utf-8?B?OWhOdGErN0RKalhCSi9ibzUzTFp4YUFEaGtEaXkwOS9sSDRvZTRWc1lwei96?=
 =?utf-8?B?SjFHSSt2UjBXMFEvVHNHZjVyb3h1dlprSzhQNEJiWGFiM1FpQXFxZ1AyZ29o?=
 =?utf-8?B?WkVHRWlKQVJIaXhHSXhlNUV1eWhFdXNra0h0UlhnajIzUjQ2WENZTHZJQUdO?=
 =?utf-8?B?MTVMdFNDSlFTS25BMXhqQWVkUE9YMk0wR0k0Z1l5cm0zSmtJYTN3YlJNek1z?=
 =?utf-8?B?M0RobTBkZzJrdjIwNk5Ec1I5aE5FTGkxV1AyeVRwOTMwam9YOVRmQThjTzhu?=
 =?utf-8?B?aFpWemRoRjQvclNvOHFaZU1nNzUvQy9ueGkrbkRDRFd0c2RtUFo0bTZSNUZE?=
 =?utf-8?B?QktHVkc0bGF1ZVdrZEJ5bVhweTdkWGR5S2V6VWFwcjdnZ2JSUHc5MENrSDJZ?=
 =?utf-8?B?V3VqMWRlRVZKR003by8wQjcxV25LWWQ5NjNkUVgyRGtoWEhjSDFXSEJ2YkMr?=
 =?utf-8?B?SWxKL1lXNGVKQzlNN2V0dHc3UzhacUMreG5MNTR6VUUwQmYvUFM2UFYxL2Rw?=
 =?utf-8?B?QiswUU9zaDNEYUYyQWMrM3VhWDlSQWJ1VU56akRXU0x5SVJJZE0zZnZEY3o1?=
 =?utf-8?B?TE9Pa3Q5MHhqTkRrSmlyQ0pvbWVFNUxzUGJDMVB2ckFyQXdmS3NMRW9iclJu?=
 =?utf-8?B?UWlaNXhrVzRIclpVZUIvdW9YcFh2cWhucURYK1pQQnlGU3Fkdm5FV0dpOFVV?=
 =?utf-8?Q?+g7xrkC2l1eAZeydGs8gWnBt+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bef04176-7f0c-48f0-e219-08dc5a01e1f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 08:32:11.1780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I6mazz962pJ1uKDyicyZJmD2KajYFfsSTu5DAB/RQvqXtM/IaDt5l8/7v0V6bGV2rcUNOCfDLOwruTDiJHp2ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6513
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgQXByaWwgMTEsIDIwMjQgMzo1NiBQTQ0KPiANCj4gT24gMjAyNC80LzEwIDIzOjQ5LCBK
YXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4gT24gV2VkLCBBcHIgMTAsIDIwMjQgYXQgMTA6MDg6
NDRBTSArMDgwMCwgTHUgQmFvbHUgd3JvdGU6DQo+ID4+IEBAIC00Mzg4LDE0ICs0Mzg2LDggQEAg
c3RhdGljIHZvaWQNCj4gaW50ZWxfaW9tbXVfcmVtb3ZlX2Rldl9wYXNpZChzdHJ1Y3QgZGV2aWNl
ICpkZXYsIGlvYXNpZF90IHBhc2lkKQ0KPiA+PiAgIAlXQVJOX09OX09OQ0UoIWRldl9wYXNpZCk7
DQo+ID4+ICAgCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmRtYXJfZG9tYWluLT5sb2NrLCBmbGFn
cyk7DQo+ID4+DQo+ID4+IC0JLyoNCj4gPj4gLQkgKiBUaGUgU1ZBIGltcGxlbWVudGF0aW9uIG5l
ZWRzIHRvIGhhbmRsZSBpdHMgb3duIHN0dWZmcyBsaWtlIHRoZQ0KPiBtbQ0KPiA+PiAtCSAqIG5v
dGlmaWNhdGlvbi4gQmVmb3JlIGNvbnNvbGlkYXRpbmcgdGhhdCBjb2RlIGludG8gaW9tbXUgY29y
ZSwgbGV0DQo+ID4+IC0JICogdGhlIGludGVsIHN2YSBjb2RlIGhhbmRsZSBpdC4NCj4gPj4gLQkg
Ki8NCj4gPj4gICAJaWYgKGRvbWFpbi0+dHlwZSA9PSBJT01NVV9ET01BSU5fU1ZBKSB7DQo+ID4+
ICAgCQljYWNoZV90YWdfdW5hc3NpZ25fZG9tYWluKGRtYXJfZG9tYWluLA0KPiBGTFBUX0RFRkFV
TFRfRElELCBkZXYsIHBhc2lkKTsNCj4gPj4gLQkJaW50ZWxfc3ZtX3JlbW92ZV9kZXZfcGFzaWQo
ZG9tYWluKTsNCj4gPj4gICAJfSBlbHNlIHsNCj4gPj4gICAJCWRpZCA9IGRvbWFpbl9pZF9pb21t
dShkbWFyX2RvbWFpbiwgaW9tbXUpOw0KPiA+PiAgIAkJY2FjaGVfdGFnX3VuYXNzaWduX2RvbWFp
bihkbWFyX2RvbWFpbiwgZGlkLCBkZXYsIHBhc2lkKTsNCj4gPg0KPiA+IEl0IHNlZW1zIHZlcnkg
c3RyYW5nZSB0aGF0IFNWQSBoYXMgYSBkaWZmZXJlbnQgRElEIHNjaGVtZSwgd2h5IGlzDQo+ID4g
dGhpcz8gUEFTSUQgYW5kIFNWQSBzaG91bGQgbm90IGJlIGRpZmZlcmVudCBhdCB0aGlzIGxheWVy
Lg0KPiANCj4gVGhlIFZULWQgc3BlYyByZWNvbW1lbmRzIHRoYXQgYWxsIFNWQSBkb21haW5zIHNo
YXJlIGEgc2luZ2xlIGRvbWFpbiBJRC4NCj4gVGhlIFBBU0lEIGlzIHVuaXF1ZSB0byBlYWNoIFNW
QSBkb21haW4sIGhlbmNlIHRoZSBjYWNoZSB0YWdzIGFyZSB1bmlxdWUuDQo+IEN1cnJlbnRseSwg
dGhlIEludGVsIElPTU1VIGRyaXZlciBhc3NpZ25zIGRpZmZlcmVudCBkb21haW4gSURzIGZvciBh
bGwNCj4gZG9tYWlucyBleGNlcHQgdGhlIFNWQSB0eXBlLg0KPiANCj4gU2hhcmluZyBhIGRvbWFp
biBJRCBpcyBub3Qgc3BlY2lmaWMgdG8gU1ZBLiBJbiBnZW5lcmFsLCBmb3IgZGV2aWNlcw0KPiB1
bmRlciBhIHNpbmdsZSBJT01NVSwgZG9tYWlucyB3aXRoIHVuaXF1ZSBQQVNJRHMgY2FuIHNoYXJl
IHRoZSBzYW1lDQo+IGRvbWFpbiBJRC4NCj4gDQo+IEluIHRoZSBsb25nIHRlcm0gKGFsc28gb24g
bXkgdGFzayBsaXN0KSwgd2Ugd2lsbCBleHRlbmQgdGhlIGNhY2hlIHRhZw0KPiBjb2RlIHRvIHN1
cHBvcnQgc2hhcmluZyBkb21haW4gSURzIGFuZCByZW1vdmUgdGhlIGRvbWFpbiB0eXBlIGNoZWNr
IGZyb20NCj4gdGhlIG1haW4gY29kZS4gVGhpcyB3aWxsIGFsc28gYmVuZWZpdCB0aGUgbmVzdGlu
ZyBjYXNlLCB3aGVyZSB1c2VyDQo+IGRvbWFpbnMgbmVzdGVkIG9uIHRoZSBzYW1lIHBhcmVudCBj
b3VsZCBzaGFyZSBhIGRvbWFpbiBJRC4NCj4gDQoNCmF0IGxlYXN0IGFib3ZlIG1pZ2h0IGJlIGNo
YW5nZWQgdG8gYSB1bmlmaWVkIGNhbGwgd2l0aCB0aGUgaGVscGVyDQphY2NlcHRpbmcgYW4gaW9t
bXUgcGFyYW1ldGVyIGFuZCB0aGVuIGZpbmRpbmcgcHJvcGVyIGRpZA0KaW50ZXJuYWxseSBiYXNl
ZCBvbiBkb21haW4gdHlwZSwgZS5nLg0KDQpjYWNoZV90YWdfdW5hc3NpZ25fZG9tYWluKGRvbWFp
biwgaW9tbXUsIGRldiwgcGFzaWQpDQp7DQoJaWYgKGRvbWFpbi0+dHlwZSA9PSBJT01NVV9ET01B
SU5fU1ZBKQ0KCQlkaWQgPSBGTFBUX0RFRkFVTFRfRElEOw0KCWVsc2UNCgkJZGlkID0gZG9tYWlu
X2lkX2lvbW11KGRvbWFpbiwgaW9tbXUpOw0KDQoJLi4uDQp9DQoJDQo=

