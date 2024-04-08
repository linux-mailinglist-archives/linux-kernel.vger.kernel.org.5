Return-Path: <linux-kernel+bounces-134732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEFF89B618
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF441C21052
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744781851;
	Mon,  8 Apr 2024 02:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lp73dnhR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBA1EDF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 02:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712544711; cv=fail; b=C4crX9mbu/rDB2NHmE2N7ZRZ9iHqTTQ+KCltzYiuvKekq+Z9wfcIsHvJjJQwZtQy0gwC1dc7z2jjG9KFaT3zMYOnXuNUcrs4kfEnx5TjTSMp4aoMI2ZTIlqeqRbmzfCHNw9XnTYHZ1CWC8eZkkUJFTvU+OyvX1JhCca2rJxv5aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712544711; c=relaxed/simple;
	bh=jjsAbmvz9dTvb5ufCgzjkWN8GyBBxQVYNM+HAbDj9jM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MjdIvl5iLATks5NWOuW3KYV/Wf/kppahn728S8mICh5WIm1xAvZ4+3C6MmJEdFlVFHQ4eC3qcea1uiSXW+Y7+oGRRDSfpCR892xf8BjV1eWMv9zk/fvw1pmRY8m7yTrtjjoQqEzzQbKLKvMsueuiFM54QtVSbMQnczH7ZlSLSec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lp73dnhR; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712544709; x=1744080709;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jjsAbmvz9dTvb5ufCgzjkWN8GyBBxQVYNM+HAbDj9jM=;
  b=Lp73dnhRMUkdvIL79nGMLNQ7rgRlihnSIs4WLtUFovdiZ7GniTypA8FM
   Nz2G3tM2JZEgbsEwZ6KECnQ59bXpDCHmo48q1YOlTU902KmcSL2VXluBl
   1bKAjSC8FrmUIlrfa5dfQcwn8rDBckgywrdodsF6f/mF61IvNFgEE63yf
   qCQaoc0lJ7rGoxSDJ40vTmMTJqDJENxxurnuRs16YW0EN561w8K5/71XL
   cEeFotDHR0sIiBDWdrF0dNlneMH/EdWPP9unCd1THuOMneHqBA+V+p1Yp
   UMmNPDvZPE8WthWfHQ3Wffp3rAutLYUSUjewbHOq87GhfEchf+/Ps2/c+
   A==;
X-CSE-ConnectionGUID: XCIPjv9FQfGsirS3qvsL8w==
X-CSE-MsgGUID: q/5HqRJfRj6LpGEASvijLw==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="8382484"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="8382484"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 19:51:49 -0700
X-CSE-ConnectionGUID: AB2TpvTASGejFN2aq045gQ==
X-CSE-MsgGUID: tq62a8poQnyilpTBaEeuzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="50941491"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Apr 2024 19:51:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 19:51:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 19:51:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Apr 2024 19:51:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 19:51:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pc/Q5Lb4eVauimMBC1fwU4gNvbS70E0zHlXnUapoVGkMVZyCgjcrLOZgJ29kFL/QL1jksT5ylNsMtzRHqzHBunPN4uBHDOzlyRDLGFpulDOPOjvHAQ/PW8iNgDCZVyREN1Va6GRQKGQuQTfItZp+qDlWUq5oz8rBznBiQFndsVCVKR3tTurD2rlBlAPJ2ptkXEpsigGdkWA4952b8RhkOWzNBnlUW6EQEj8JSbvsiRjuSm3hWPkb0Ot/j6kZ74htTJVByRxtD89IyiXhF8dVGfHRRvRKRpVHmY2UW/BK9oa7Ejs9jZQjJufekgEs5xVcZfhyWyLpP9xSWBgxrNsD6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjsAbmvz9dTvb5ufCgzjkWN8GyBBxQVYNM+HAbDj9jM=;
 b=WRm10t2Nd1iUl4OXHrLkq/I1Xp7kZLaYLRpSdwNuooP84jl5K2ZrOyT1oRUYI3yVBa0NAbd7MdllbKQgIz8+QcsyxSg5SJ0oCnBMYOlq6A6v1i5y0Zz0s85j0ABVC/FF31/Vyjvs6NahJWNCzHbwP2FdbrfScPzkHM6US1ooZPOFEd7YmmlSF01nwaqKSH6vrmIw/nL/cnanYgfXlnBj4fyuJbExy0ooXl/qoLpYySIWG7maPLHSl7VJhAXzQUqL1XfVTHrq7MEv/dwG2mVoVz3tGNDUPlX5miETpanBOFfyk03rWE+Q5+J3++2BQ/idJmgYg7L8pqD8drnn92MDfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Mon, 8 Apr
 2024 02:51:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 02:51:46 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Zhang, Tina" <tina.zhang@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 06/12] iommu/vt-d: Use cache_tag_flush_cm_range() in
 iotlb_sync_map
Thread-Topic: [PATCH 06/12] iommu/vt-d: Use cache_tag_flush_cm_range() in
 iotlb_sync_map
Thread-Index: AQHaflq4yxLShVORlkmqLXclud+azLFMy8WQgA+krgCAAVFooA==
Date: Mon, 8 Apr 2024 02:51:46 +0000
Message-ID: <BN9PR11MB5276FDB6B86B8E49959236008C002@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <20240325021705.249769-7-baolu.lu@linux.intel.com>
 <BN9PR11MB52766C4CA9A27F34419AEE258C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7657779b-bda0-4303-96c5-33949cf6457c@linux.intel.com>
In-Reply-To: <7657779b-bda0-4303-96c5-33949cf6457c@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5073:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m7IM1eIvnF/x926J5T4KO5VokS1GQOuHg/vMaB7B0DNvrdioC2TV3xFp94pXJXHN5l364V52WBxjBZn8JUfgefSUvb9zX/m9sfOMOFk0Yic+W9JYdVRPQLXLFTr+mFaMTBvDsPrJOjANv+Gy9cOalWRY4rJK3hl8KaB6PlWCMowBvflCOA4drsUw5AcOvwPMYpCPSDhfssOQwwFAXsLtPxixpBs5OcNusNkOJjg39IZvnLRcYeXlzDINnaCWZq6UXP1uSrGEywuKQugXHbfnKzGooSV2pkmjFBOGtu/vR+awVj7BQb/4WxpXZjX46lmS54F83xkP6jjuQsGH8hJ+iBwTF+SnfRsdd/rTY+CwfKB0ZslaUH2QHi2Eg2NKcRxu5lw/EvrYZbAODxuTO6uDBK7ej8GTvzJCbPRdL5BL7jvpAWmQPUhKDOfBAmNkUGWo68OKvd9IVtx95gZ5ZAhx14w8/xLoFu0Wk1hTuaX9V8RUFz2A39Rw0FNLttsOHDEVY8LCDiu+nFZKUheQlF2Ym5YlDy2MM8MKJ9IAU0U1S01fj76WiyCyjGkZocbMtSyYzmJMrknwgvGyYCXqjwleTt5/JkAW79b7VoJ8CLX4mLOY5m+ZDp6lTVugltou264wp91iRHx4aBjIJcgHHWHmXYAbtDWVfDNyyfPjH41eu0Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2FleHRPRnRtWE5sT2VxMkpXNGxpdTZNRW0yMzRyUDlJRTB5MUdhQmVtNk9X?=
 =?utf-8?B?R28zLzVORkhRY0VNWE5USzNJbmczem82ampabGVZcHZZckszYm5XNUEyYW8v?=
 =?utf-8?B?NVpDMkxpemtwTW9NbXlxVnh2Z3V5VlJ3RzVYVE04Z21SdEN1K3haT3hwdkt6?=
 =?utf-8?B?bFRJNk9yRktjengzTklpUmRScDBrb2RnR3dJOWNsVUROVzhaTEFRYjJWaXRm?=
 =?utf-8?B?SjBSTXR3T2dxNGVKblg4RkdSQ0pkODRuZG5xUEhqZ3VUbGgyaXIzVTg2VlM5?=
 =?utf-8?B?S2YrMEcrSDB1ZUM3MEdKSmhzRjVqL1lSTEhTSlRJVkN4T0FabHFEVGNiRzRC?=
 =?utf-8?B?WksxYjRZQXg1cDdTMVRESno0TkdHckRBck8wWmYrUmVSdXBrSGlLTmR4M09y?=
 =?utf-8?B?OUR0R0RRd0NwdGpOZmhMVUR2VHF3TGJmMmlZTjdFa3pwZUZGRXhNWERUcW5O?=
 =?utf-8?B?N1N6MGNzUm9RZ3ZKa2tHQXVRMk02aDFCblVab0IzRDNyZHFXeXVNWjVnRlFR?=
 =?utf-8?B?R1FjWjhINjV2ZkpaYTc1cUVzSXVnN1FxbDFEUHN2a1IyZk81TkJOWU1OdmNh?=
 =?utf-8?B?TFBYb2wvTTlCRFg5K0E3WUNjdldLckFEL2dMNFMzSUxzQjl6R2M5Vk5hZVJ4?=
 =?utf-8?B?UXl4QU05dmZHYmFYR3B1SXZUYmROU1NmUUZRbTkzMjdIY21CbUd4L2RacWZS?=
 =?utf-8?B?ZEZ6NHVzZjZwemROejVjRVdvTUV1UzM1cnpTZ05seXVzL01KUEp0Zjl0T3VI?=
 =?utf-8?B?QVFmd0xKaTNRNkcycW1RYmdLYWQvaUJ0VU5aeGd3ZlZmS3N1dDNQTjYxWWUy?=
 =?utf-8?B?Y2lTNUZVeWF0dGdKL3A5TUxiRm1FclVXcnhNc1RzNzhFMzMrQjJIMGs3eC9l?=
 =?utf-8?B?bzZTWXdsbWhzSHNZdjE1Ry9heUkvNXJJVDJSc001ZEJiMGtGRXNSZ2YrWndO?=
 =?utf-8?B?OWd1OVlmT2JwQml3cjlsWGxCR3R4b2pZeTB3SU5Hak8ramJlT1FncldWRmRI?=
 =?utf-8?B?a2tYdXB2WXlFclQxMVdrdXljUE42RzB4UEh3V3A5czdYNmFwanJkbTZpa3lW?=
 =?utf-8?B?eUJUQkhJRk9WSG9BRnV6NmVCVFN3WVo3cDlNaTRheFFQWW5MZmhCaVJnbzBV?=
 =?utf-8?B?VTZ1a2JGVGgzcUZvS3RJOG4rcDlCQWpUOExlZ1Faa1l1RFJMV2lnN0hQaElw?=
 =?utf-8?B?NDk4eVFoWVZERm0wODA0dlZGbFloSG9QbStmMjN3V2hyMUMrK1NhK3ppanFU?=
 =?utf-8?B?MS9nZDBKOGE4U3V6dHRhbEZZVzNVQmF3SlovcEUxeHN0S1plYlVJOFVwd2w4?=
 =?utf-8?B?VGZmZm5Na3pWd0RIcm40dmxQRjRJaHdyQ1VnbnZLMFVoVk5JN1NncTlLbXdJ?=
 =?utf-8?B?L0tURDhRUk94MC9LQlF2b1l6RDd6WEYzWVNMMUlXdUo2RkVzVGNCYTBsUVVk?=
 =?utf-8?B?Zm5TVTR4eG1qeVU3T2Q0a053ZjArZ3ZUQ255dkNTR014TWwrVFNWdEZVdTVV?=
 =?utf-8?B?Q1ZpSWR4RnQ1VHpQeDg4RTdmQzVBM3BHUzQ5R0c2Q1ZwT0F0WGVzYnpBZGoz?=
 =?utf-8?B?K3V1VDRZVVBTeUhGMVhYdmVEdXRiZmVNakRrOURLQ2hiR0FxbFRnd2oxdXhh?=
 =?utf-8?B?dUZaTHRTU2h2TEpoWGlXMnU1ZU9wUmxPNGtmc2FsVWlPWVI1VDd3VHV5UHF6?=
 =?utf-8?B?WmNnMVlOTzF6T2dLdHYrd0RKZTl0UUVzMGM2ZkdmY2V0Q0RjcXZuK0J6dkxa?=
 =?utf-8?B?VW0vK2FCeWIrUDZnQncvcWNBa0pTZTdIL05VRU9qSWZCeitralBOQ21uR0JK?=
 =?utf-8?B?OGVjYVZtUG5XMlgvby9mV2hVbVE5RWs2UEp0K0dQd3M5d1dZR1FDUktkOTBw?=
 =?utf-8?B?dlZOeFJQaHBCSy9ESnZhVDlERGNOOWpsREcvOVJRZ0t4Z1VhUmNmeDRIdDJ3?=
 =?utf-8?B?VDNFR0NZdkdYcUhmZUUvNXZjaEVzS3VUVkhkVFFLSk04T1lIUnU1QUI5VXQ3?=
 =?utf-8?B?UERmTVlXQkdBVk81NUppdHBnSmIyeVRsaENQMkpjM04wcmZmZ082RTVDakFj?=
 =?utf-8?B?cG5Kenk5TmxiQUVDSXd2MEo1K0tpeDBOZUdKZzg0V084Ui9PTGkwUlViM0Nm?=
 =?utf-8?Q?z7s9FZcIL/urAuev2g69YLPJI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6486e396-ef4e-4f16-7422-08dc5776d47b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 02:51:46.2363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2dhEsVGsvcrpPBR6dia12WwoIYIVGj5rY/0K0pYKz7pUY5MnJYX8knkPKkK1Z67/nxJrgjDE5O3OMW7NwB0oLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5073
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTdW5k
YXksIEFwcmlsIDcsIDIwMjQgMjo0MSBQTQ0KPiANCj4gT24gMy8yOC8yNCAzOjQ4IFBNLCBUaWFu
LCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVs
LmNvbT4NCj4gPj4gU2VudDogTW9uZGF5LCBNYXJjaCAyNSwgMjAyNCAxMDoxNyBBTQ0KPiA+Pg0K
PiA+PiBUaGUgaW90bGJfc3luY19tYXAgY2FsbGJhY2sgaXMgY2FsbGVkIGJ5IHRoZSBpb21tdSBj
b3JlIGFmdGVyIG5vbi0NCj4gcHJlc2VudA0KPiA+PiB0byBwcmVzZW50IG1hcHBpbmdzIGFyZSBj
cmVhdGVkLiBUaGUgaW9tbXUgZHJpdmVyIHVzZXMgdGhpcyBjYWxsYmFjayB0bw0KPiA+PiBpbnZh
bGlkYXRlIGNhY2hlcyBpZiBJT01NVSBpcyB3b3JraW5nIGluIGNhY2hpbmcgbW9kZSBhbmQgc2Vj
b25kLW9ubHkNCj4gPj4gdHJhbnNsYXRpb24gaXMgdXNlZCBmb3IgdGhlIGRvbWFpbi4gVXNlIGNh
Y2hlX3RhZ19mbHVzaF9jbV9yYW5nZSgpIGluDQo+IHRoaXMNCj4gPj4gY2FsbGJhY2suDQo+ID4+
DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+
DQo+ID4+IC0tLQ0KPiA+PiAgIGRyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyB8IDIyICstLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4gPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDIxIGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9p
bnRlbC9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jDQo+ID4+IGluZGV4IDFj
MDNkMmRhZmI5ZC4uMmRjYWIxZTVjZDRkIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2lvbW11
L2ludGVsL2lvbW11LmMNCj4gPj4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jDQo+
ID4+IEBAIC0xNTA0LDIwICsxNTA0LDYgQEAgc3RhdGljIHZvaWQgaW9tbXVfZmx1c2hfaW90bGJf
cHNpKHN0cnVjdA0KPiA+PiBpbnRlbF9pb21tdSAqaW9tbXUsDQo+ID4+ICAgCQlpb21tdV9mbHVz
aF9kZXZfaW90bGIoZG9tYWluLCBhZGRyLCBtYXNrKTsNCj4gPj4gICB9DQo+ID4+DQo+ID4+IC0v
KiBOb3RpZmljYXRpb24gZm9yIG5ld2x5IGNyZWF0ZWQgbWFwcGluZ3MgKi8NCj4gPj4gLXN0YXRp
YyB2b2lkIF9fbWFwcGluZ19ub3RpZnlfb25lKHN0cnVjdCBpbnRlbF9pb21tdSAqaW9tbXUsIHN0
cnVjdA0KPiA+PiBkbWFyX2RvbWFpbiAqZG9tYWluLA0KPiA+PiAtCQkJCSB1bnNpZ25lZCBsb25n
IHBmbiwgdW5zaWduZWQgaW50IHBhZ2VzKQ0KPiA+PiAtew0KPiA+PiAtCS8qDQo+ID4+IC0JICog
SXQncyBhIG5vbi1wcmVzZW50IHRvIHByZXNlbnQgbWFwcGluZy4gT25seSBmbHVzaCBpZiBjYWNo
aW5nIG1vZGUNCj4gPj4gLQkgKiBhbmQgc2Vjb25kIGxldmVsLg0KPiA+PiAtCSAqLw0KPiA+PiAt
CWlmIChjYXBfY2FjaGluZ19tb2RlKGlvbW11LT5jYXApICYmICFkb21haW4tPnVzZV9maXJzdF9s
ZXZlbCkNCj4gPj4gLQkJaW9tbXVfZmx1c2hfaW90bGJfcHNpKGlvbW11LCBkb21haW4sIHBmbiwg
cGFnZXMsIDAsIDEpOw0KPiA+PiAtCWVsc2UNCj4gPj4gLQkJaW9tbXVfZmx1c2hfd3JpdGVfYnVm
ZmVyKGlvbW11KTsNCj4gPj4gLX0NCj4gPg0KPiA+IGlvbW11X2ZsdXNoX3dyaXRlX2J1ZmZlciBp
cyBmb3IgYSBxdWl0ZSBkaWZmZXJlbnQgaXNzdWUuIGl0J3MgY2xlYXJlciB0bw0KPiA+IGtlZXAg
aXQgc2VwYXJhdGVkIGZyb20gdGhlIGlvdGxiIGhlbHBlcnMuDQo+IA0KPiBUaGUgVlQtZCBzcGVj
IGRlc2NyaWJlcyB0aGUgd3JpdGUgYnVmZmVyIGZsdXNoaW5nIGluIHNlY3Rpb24gNi44LiBJdA0K
PiBzdGF0ZXMsDQo+IA0KPiAxLiBXcml0ZSBidWZmZXIgZmx1c2hpbmcgaXMgcmVxdWlyZWQgb25s
eSBmb3IgZWFybGllciBWVC1kIGhhcmR3YXJlDQo+ICAgICBpbXBsZW1lbnRhdGlvbnMuIE5ld2Vy
IGhhcmR3YXJlIGltcGxlbWVudGF0aW9ucyBhcmUgZXhwZWN0ZWQgdG8gTk9UDQo+ICAgICByZXF1
aXJlIHRoaXMuDQo+IDIuIFdyaXRlIGJ1ZmZlciBmbHVzaGluZyBpcyByZWxhdGVkIHRvIGNhY2hl
IGludmFsaWRhdGlvbi4gVGhlIGhhcmR3YXJlDQo+ICAgICBwZXJmb3JtcyBhbiBpbXBsaWNpdCB3
cml0ZS1idWZmZXItZmx1c2hpbmcgYXMgYSBwcmUtY29uZGl0aW9uIHRvDQo+ICAgICB0aGUgaW52
YWxpZGF0aW9uIG9wZXJhdGlvbnMuDQo+IA0KPiBBY2NvcmRpbmcgdG8gdGhpcywgd3JpdGUgYnVm
ZmVyIGZsdXNoaW5nIGlzIG9ubHkgcmVxdWlyZWQgaW4gdGhlIG1hcA0KPiBwYXRoIHdoZW4gSU9N
TVUgaXMgbm90IGluIGNhY2hpbmcgbW9kZSBhbmQgdGhlIFJXQkYgaW9tbXUgY2FwYWJpbGl0eSBp
cw0KPiBzZXQsIHdoaWNoIHBlcmZlY3RseSBtYXRjaGVzIHRoZSBjYXNlIG9mIGNhY2hlX3RhZ19m
bHVzaF9jbV9yYW5nZSgpLg0KPiANCj4gQnkgZG9pbmcgaXQgaW4gY2FjaGVfdGFnX2ZsdXNoX2Nt
X3JhbmdlKCksIHRoZSBjb2RlIHdpbGwgYmUgc2ltcGxlciBhbmQNCj4gZWFzaWVyIGZvciBtYWlu
dGVuYW5jZS4NCj4gDQoNCmJ1dCBhYm92ZSBhcHBsaWVzIGFjdHVhbGx5IHdoZW4gY2FjaGluZyBt
b2RlIGlzIGZhbHNlIG9yIHdoZW4gMXN0DQpzdGFnZSBpcyBiZWluZyB1c2VkLiB0aGlzIGlzIHRo
ZSBvcHBvc2l0ZSBvZiB3aGF0IGZsdXNoX2NtX3JhbmdlKCkNCmltcGxpZXMuDQoNCmlmIHdlIGRv
IGl0IHRocm91Z2ggYSBnZW5lcmFsIGZsdXNoX3JhbmdlKCkgaGVscGVyIHdoaWNoIGFjY2VwdHMN
CmEgcGFyYW1ldGVyIHRvIGluZGljYXRlIHRoZSBtYXAgcGF0aCwgdGhlbiBpdCdzIHJlYXNvbmFi
bGUgdG8gbW92ZQ0KdGhpcyBzcGVjaWFsIGhhbmRsaW5nIHRvIHRoYXQgaGVscGVyIGFzIHRoYXQg
aXMgYW5vdGhlciB0cmljayB3aGljaA0KdGhlIGNhbGxlciBkb2Vzbid0IG5lZWQgdG8ga25vdy4N
Cg==

