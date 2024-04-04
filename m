Return-Path: <linux-kernel+bounces-132165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C5789906F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7931F2279B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186E513BC38;
	Thu,  4 Apr 2024 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ixi0s6p2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD67131BDB;
	Thu,  4 Apr 2024 21:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712266386; cv=fail; b=GEAxRPNCrcQq66ptJtOlKip49aYWBWxOmt5APqrTey9pSzZXKG1hDddHnR/zlvMscc8fEyKAw/2iDkVWcbmIa5o2eqsP9vm54b6Mb2SjL11aLnkzanTepUsp7FNqhneNJmFqUGBcaYKMzdlSfwl7EbFQe4Pz3BZTai1Eb9rGFNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712266386; c=relaxed/simple;
	bh=nzkpOFzyH76c9PydUCxcjjiLNpbwAcEjSXl4WohTU44=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dDDix16nNbiSRmOhpDiPS9RBPVyUzxvRF3CpnSKhjnKLy1bFnS22vghohS8UF+y1TRV29LaIfX4sEaBgi+5UVuiCT6O6+oHSDKapavM5TVV2ApN4g3xG8fi1jKzgxzFTPkNleZdYrMLFI0dfmJhiw4J8yHVLCbInlJqoUf9dmmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ixi0s6p2; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712266385; x=1743802385;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nzkpOFzyH76c9PydUCxcjjiLNpbwAcEjSXl4WohTU44=;
  b=ixi0s6p2QNFCfBf2DYJGp+ojLJATxuLuECeB07pRqy7RsnpGp6LtqIPh
   PCN4wdRQGMRdK4FIAuD1MwAv04XhL5EJrJ2sJBtbM6ngoYgGfGjgTAODY
   YukGE5j26ffF8ldXwWER7hkdaMSjuZ2rR6lCs8zWGIA+AAXwdBD4jjqwJ
   DysPW4V+W9hw8HyjxYZDUWM/lOQTmk5LRk8aZUuZEM6hI66iMyoFpM0bW
   fVkdNmKHLb5GSfnHzcuPbvk3h+zl5tKVUMh00bYG4rGjNygh7MlZgLUHr
   ysLeIkcKmq0wJH6+5NeCsHOWdXWGiYFRSoLCicFb47X6LE8Xse4eiZ6uJ
   w==;
X-CSE-ConnectionGUID: 2tswljbbRRCHtW7hI2zjRQ==
X-CSE-MsgGUID: qlp1RGxjS3WgWogx8r0StA==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7768656"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="7768656"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 14:32:29 -0700
X-CSE-ConnectionGUID: Ii9oeVxsTFSRAwDSgpRSqA==
X-CSE-MsgGUID: uZO2EGKKRsahqN/BAy1TCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="19042025"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 14:32:27 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 14:32:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 14:32:26 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 14:32:26 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 14:32:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEl6yVdsFD0pME2f0DWA+qdeqAYtTA2KTcb9w8j663R3/TcLzPL36wZ7Vq7qUWmzqyXBn5w5NxHmzVFLLj44Wg2OxEF6+sT4BGmHHCBU608KnHFAn5n0p9ADysgNUw4QhgGCaK8Gp54APhA/9ei6J80Zzp5FNBVgnqdiy954EugzzI/5a/NyURsqpufU1L03fmq1Oit9fhqMJumv2oNu9hdhpWMJyOWjpMDKnlPOXIJr00cTI2kydoGQTtn5pYLB55cY57UrlmNZPfO2KQfe8wL+6dJ+59KQMa9m4YJwo5MadFyTX1e9KAUU1i2XUrK5xTmCPqQs40bjtFYEuD5l0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzkpOFzyH76c9PydUCxcjjiLNpbwAcEjSXl4WohTU44=;
 b=DPLRZ0rgRi6E6MFv40R9HxYZxKLsmy+HVC0/RfqSXnsZQHoYrlQVuLaLLdTZaOU87OO0cQMKC2Du50E+JjQ2YExZmGtZRJuAqrCHNkZaQyATwQXp7Ep44Obeq+GBxgaxMayG2YylftR8fOJwQG/rjUXpcfqM7O2JJHISIZb0LZ/SQ4lr6ZJezvQQKWHA/aIU0duoLbAAWCS7f6WSiStDNEaSm2fBQXD9Znq2qUwnmZnEk807ALTKXJDXhctTRbm3a+zrU48nrOD8P1zZZYZBNe64vorbd+hvb9yPZEs/N/Eo7z5RwOd4YrkLJpDd8SC/jNZd2j94u6IHvkRP4sRKVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by PH8PR11MB6928.namprd11.prod.outlook.com (2603:10b6:510:224::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.21; Thu, 4 Apr
 2024 21:32:24 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::28bc:28a9:78d3:8190]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::28bc:28a9:78d3:8190%4]) with mapi id 15.20.7409.031; Thu, 4 Apr 2024
 21:32:24 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "Williams, Dan J" <dan.j.williams@intel.com>, "Jiang, Dave"
	<dave.jiang@intel.com>, "Schofield, Alison" <alison.schofield@intel.com>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dax/bus.c: replace WARN_ON_ONCE() with lockdep asserts
Thread-Topic: [PATCH] dax/bus.c: replace WARN_ON_ONCE() with lockdep asserts
Thread-Index: AQHahMZ6SvMVAKw3jUyL7msiMIuYOLFYoxwAgAACfwA=
Date: Thu, 4 Apr 2024 21:32:24 +0000
Message-ID: <556a9d595b815ac459f1d43f5b6394b41f661e60.camel@intel.com>
References: <20240402-vv-dax_abi_fixes-v1-1-c3e0fdbafba5@intel.com>
	 <20240404142326.b3d5b0f3f7b9f25f1a16288a@linux-foundation.org>
In-Reply-To: <20240404142326.b3d5b0f3f7b9f25f1a16288a@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.4 (3.50.4-1.fc39) 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|PH8PR11MB6928:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nBHpV3LTL2rfzdubxRX1nTas78vfZDY1H7LCf6UQO5mzzhxrL79DTr6DqNyuvantjCAJ60XpVwMjGbxJYfO8S0US07J9R3OKcuZzVJy8ISS2slH4rD9MxybSwxKx0LQLyvl9SV2VYVPDVmp6AozW1FDSg9sCD1SO1+BFP7GW/M05KrXEZ2CiTTO8PTgBlGH1/b8M2ZqPWTjrK3lTMC/VJ6wp1NidAVzC1npCg6CaKroaGkwpWKq/4iJaEBIqKEDFajhUfVtoT/xBf7fQhOKglGaZK6kxWFogt2oaM+/XxTqFvyrDeaOP2zU5RhlwjM6ZphD1U8m74aCrM4k55Kz3QlCq1OQjxYly765BO22hr3A2/L455vRiqxdW70dpC0wqxVOOhhxMiQKiTR3PBV6MUPF4qgqL+MyQ0OZ+PKrMi6J7r4Z3SVD0GP57ZS9GDSiTsIVIBblJxF4mgI+P6a8U9J73D+eRdRMok6WDMlAT+16lOfowRbWc1ekr7UPCEmoazElYglSKSxYF3KghXaZEclzA6WSem1sBTVJFbjmInkec7okz6lQzDlxG2CGBEdDcbqSAg778UF1Y7rsvJYslIWqTz2CgfV+5k/O0whgLaqlkMYTJOgqghHfBl8z6yQ/YyoJakIiYLwV7rtQZhBr8TfY9KYLeajs7KzrVOFH34gc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFY2dE0wM2NEOENwREpybXBuOFV4eE8yS0ZOeXkwWmRrekN3Rjl4d2YvN2dw?=
 =?utf-8?B?VGsxSERPL0lCOGdRZXR0Q1F2WW9FTjVPN09SMkdMd2M4QUxIa1pmWWlvUmc2?=
 =?utf-8?B?cnE1eWsxczdyeTZ5aU1YSzZaUk02dUtvUUNvbE9zZm9ORE03WWZ4aThJWU1h?=
 =?utf-8?B?djdmUjR5aWIrMGxwcVRHSEJ1Zk9kNkY1M2F4RTVQYStMVFdnNEYvbnZFVGd0?=
 =?utf-8?B?Z2NCY0lVdVhhdHhLNmpiRWpHVmlqV3NqdDM4akNvNUMyZFo1b1dWSVNNWURv?=
 =?utf-8?B?VTRSZVMxRWtFM2dPem12c3V6aS9sL0RrQmU4S1RPaG9tUU9xNE9TZ3hyWE1p?=
 =?utf-8?B?dDdJRUpBSjA1QnFSOG56dldYek9MTXZ0NkpkU3NMbS9NTDE4czVMdFBYUlgy?=
 =?utf-8?B?MThVeHV6bFJvYVdtRVFXc0pqY1N5Q1dvc0MxUHNBTmtBTUNSYWRRNmV6OEhn?=
 =?utf-8?B?eHB6RGNlcHZaNE03TzUyVDFlWURCWDJGSlFnM24raUpZMVZzR1ZHci8yUjg1?=
 =?utf-8?B?eWRpUk9XNFVBWUFuU24wTHBkWlVjUHEzOWtYbkFET1QrdmNrR1BaUGJIeXRo?=
 =?utf-8?B?UjFRN0dqd3k5cEZ1dC94RUVVeUJJTCtPeWx3QUl6K0ZxVGx0RFNrZERIZGxH?=
 =?utf-8?B?bi9Ca2tVV2FSdnJpYUZna1daVWxtSVd2ZHF4NUJ3d3lQVzlUL1JiNG5MWjNC?=
 =?utf-8?B?bk5PVUgya0FkME5KUEtnZWlkMWwyRmkvajhIVlJxazZraU5YMjc4bHEzd0dF?=
 =?utf-8?B?d2dMUTJPSVRyamNiTytPRjBTK3pQMDdVeUdqeDNoMFFiRWs3NG03TnlLTUU5?=
 =?utf-8?B?OVRLUVNvVTZocWRROVg1R0F2d3AvUXFyRFZLcXZSTFl1MDNtMzA4NjNpaWYw?=
 =?utf-8?B?WDY4NklVNEhiWXNPdzZJV1VNRVJkN294NGxXMENuUDFEV0hrNWxqZGlubkdh?=
 =?utf-8?B?NTk5eERIRTdrQTFOK0s2b0krcjlwUnZzQys4QmlMQm1BR3dVN0VsMHV5SlJt?=
 =?utf-8?B?eFRNTVE2TzQrSmV3dDd3MmxrOXlNZnFEOGdlSW5GcmhsUDdabnJ4TUgxcGly?=
 =?utf-8?B?N2NUT3NyZnNIdjdINTNJdnVmV05RaVFEM0lHOGZYSzVTMFVJSzBGcVFkWnVJ?=
 =?utf-8?B?VVRrVE54eFlOMWQvQldkNVk3WElNZ3pBV1FPeVNFZzBjZ3puOVRYKzFaVzk3?=
 =?utf-8?B?SHJRdUEvbXpqUm5DS3NwbWhMTDhSOHAyRU1mZGw5QjF2ODFmTmtmdDNJRGp2?=
 =?utf-8?B?Nk5HVzZHQ2lOYVJsaTI4MG8zZDFJNUh4YXZTaHo0SFlremo2MEU1ZExSL2xD?=
 =?utf-8?B?MDNwRzlyT20xRVhlYzdyNUYzMmwvVmN4U0dHRDkvOHdJUWFGUFVDTUM3WmJl?=
 =?utf-8?B?ZW1Rb3BOVUpYTm5PU25OeDdtM3hYQU9BSzFRS2JIcnVPbnFCTzlsb1dvZ0FU?=
 =?utf-8?B?WjhlVjhsVzdpbWs1ZnVTMUZ4WmF0Smx5WDRmcklvRlJ6TzlSaWJSNzJ3TTJx?=
 =?utf-8?B?TTI1ZjRCd1hKY0NUYzg2eUdnS3lmNmRNaXBDNnp0MTJKcTQvRDNCQTM4OS9a?=
 =?utf-8?B?UE9IRXVqV0NMY2UzcjI3TVRrSjBkQmFKaDVYdzJWR3hKTWZKM0ZTWk1hb3lh?=
 =?utf-8?B?TkQrRGdTZWtqU3VrL252a29pZXk0L2pxL0dTUmhibTVwV0Qra1lYaE1WRm8r?=
 =?utf-8?B?UitOVVZPQXd4Y0FUelRCUmNoMHJiMjhyUmdPZTVlUVo2WitCem5lWmlCeWp2?=
 =?utf-8?B?czJzUG5ZbE5ZK0FVRzFQL3ZtTFB0clBGYVBaeDhGZFVDZWRFV3hsUk1GdEdW?=
 =?utf-8?B?SkRrVnRFSldSdjErTzdtcVRob2gxMENIZmJHczJUNzZaTmpvcHJkMjJOVjZZ?=
 =?utf-8?B?eGd4S3hKM3lDNGhyeWhZdm80VmJpYStvZFdBRFp1RDdIQUhlclQzem44WXcv?=
 =?utf-8?B?RGNyb0NjV1BXQk96bGcwOGxZZ244VUtuT2FId01FRmlGWE9LYVVLSTNhTkZl?=
 =?utf-8?B?OVB4amVhdy9jOEdZTWtYV0huUWVTQVNxQzUxTTF4S0xpWGl4OTlTWGdLV0lt?=
 =?utf-8?B?WWlzd0I4UWhZWjNPMXRPNEdOQ0ZxZ01HY3lrRHZIcVozd0M4VE9CbjdMNzI3?=
 =?utf-8?B?SnFiSk1QMmpJYk03K0dtZEg4NisxYUtjVmJnV05UQ3p5SmZzcE9odkVRQ1ZR?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AA688A52730504786CEDE2E3555846F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e49eaf-b11c-4499-58a9-08dc54eeb7e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2024 21:32:24.3555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q6EFen9QaYpWjKrusgLCzQR9QwDC4SqF31VBoRUk4iEuTilhG7kUZPsTwa810qon1t4AZ/BP9aabUQg7YcqdYqG0uwLwLcgP9nAb9cC9ZRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6928
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA0LTA0IGF0IDE0OjIzIC0wNzAwLCBBbmRyZXcgTW9ydG9uIHdyb3RlOg0K
PiBPbiBUdWUsIDAyIEFwciAyMDI0IDAwOjI0OjI4IC0wNjAwIFZpc2hhbCBWZXJtYSA8dmlzaGFs
LmwudmVybWFAaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+ID4gSW4gWzFdLCBEYW4gcG9pbnRzIG91
dCB0aGF0IGFsbCBvZiB0aGUgV0FSTl9PTl9PTkNFKCkgdXNhZ2UgaW4gdGhlDQo+ID4gcmVmZXJl
bmNlZCBwYXRjaCBzaG91bGQgYmUgcmVwbGFjZWQgd2l0aCBsb2NrZGVwX2Fzc2VydF9oZWxkKF93
cml0ZSkoKS4NCj4gPiANCj4gPiBSZXBsYWNlIHRob3NlLCBhbmQgYWRkaXRpb25hbGx5LCByZXBs
YWNlIGEgY291cGxlIG9mIG90aGVyDQo+ID4gV0FSTl9PTl9PTkNFKCkgaW50cm9kdWNlZCBpbiB0
aGUgc2FtZSBwYXRjaCBmb3IgYWN0dWFsIGZhaWx1cmUNCj4gPiBjYXNlcyAoaS5lLiB3aGVuIGFj
cXVpcmluZyBhIHNlbWFwaG9yZSBmYWlscyBpbiBhIHJlbW92ZSAvIHVucmVnaXN0ZXINCj4gPiBw
YXRoKSB3aXRoIGRldl9XQVJOX09OQ0UoKSBhcyBpcyB0aGUgcHJlY2VkZW50IGhlcmUuDQo+ID4g
DQo+ID4gUmVjYWxsIHRoYXQgcHJldmlvdXNseSwgdW5yZWdpc3RyYXRpb24gcGF0aHMgd2FzIGlt
cGxpY2l0bHkgcHJvdGVjdGVkIGJ5DQo+ID4gb3ZlcmxvYWRpbmcgdGhlIGRldmljZSBsb2NrLCB3
aGljaCB0aGUgcGF0Y2ggaW4gWzFdIHNvdWdodCB0byByZW1vdmUuDQo+ID4gVGhpcyBtZWFudCBh
ZGRpbmcgYSBzZW1hcGhvcmUgYWNxdWlzaXRpb24gaW4gdGhlc2UgdW5yZWdpc3RyYXRpb24gcGF0
aHMuDQo+ID4gU2luY2UgdGhhdCBjYW4gZmFpbCwgYW5kIGl0IGRvZXNuJ3QgbWFrZSBzZW5zZSB0
byByZXR1cm4gZXJyb3JzIGZyb20NCj4gPiB0aGVzZSBwYXRocywgcmV0YWluIHRoZSB0d28gaW5z
dGFuY2VzIG9mIChub3cpIGRldl9XQVJOX09OQ0UoKS4NCj4gPiANCj4gPiAuLi4NCj4gPiANCj4g
PiBAQCAtNDcxLDYgKzQ3MSw3IEBAIHN0YXRpYyB2b2lkIF9fdW5yZWdpc3Rlcl9kZXZfZGF4KHZv
aWQgKmRldikNCj4gPiDCoA0KPiA+IMKgCWRldl9kYmcoZGV2LCAiJXNcbiIsIF9fZnVuY19fKTsN
Cj4gPiDCoA0KPiA+ICsJbG9ja2RlcF9hc3NlcnRfaGVsZF93cml0ZSgmZGF4X3JlZ2lvbl9yd3Nl
bSk7DQo+ID4gwqAJa2lsbF9kZXZfZGF4KGRldl9kYXgpOw0KPiA+IMKgCWRldmljZV9kZWwoZGV2
KTsNCj4gPiDCoAlmcmVlX2Rldl9kYXhfcmFuZ2VzKGRldl9kYXgpOw0KPiANCj4gVGhpcyBpcyBu
ZXcgYW5kIHVuY2hhbmdlbG9nZ2VkPw0KPiANCj4gSSdtIHRha2luZyBEYW4ncyByZXBseSB0byB5
b3VyIHBhdGNoIGFzIE5vdC1BLU5hY2sgOykNCj4gDQpUcnVlLCBidXQgd2l0aCBEYW4ncyBuZXcg
ZmVlZGJhY2ssIHRoYXQgcmVzdWx0cyBpbiBhIGJpdCBtb3JlIHJld29yaywNCnRoaXMgd2lsbCBs
aWtlbHkgdHVybiBpbnRvIDItMyBwYXRjaGVzLiBXb3JraW5nIG9uIGl0IG5vdywgd2lsbCBiZSBv
dXQNCnNob3J0bHkhDQo=

