Return-Path: <linux-kernel+bounces-162679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F168B5EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94DD31F238CB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC1284E1A;
	Mon, 29 Apr 2024 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xs0Ejz5X"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D226C824AA;
	Mon, 29 Apr 2024 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407790; cv=fail; b=ElXICMwYSlM1PibU9x0NZFI9Tb7IXCkOUYlX+xMQN++eXsw0qSiWsubh6LmNRk8JgZhr6USAjapTgCCcpdYzuNla3ap5Fwi8vwJKCarD6nAetYp3KaMyxFQ/9DEsHcXxlzIpvuC3+Vn0N68r6R+ozoXfC95Y/EdcNTTDtIADQP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407790; c=relaxed/simple;
	bh=jrtE+fRaS4cMSpgCWLIWoTWC1H3gX/eynMEfcPYsyOk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Oepf0prvdMA6icppaPB2wsl+Fr3s4c8xSqDH/SF4CJnGJTW553nCV3YudX1nyPdbvqKRU0SAMqccQynvMoPyeFSkpED0YP6XPPwpI38csLXOK+p3xR5mv0tE2bl4Umlk071FSBlBJ4vjc+lc9eVvQzYhJ1wmImQjVR8GmleZpQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xs0Ejz5X; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714407789; x=1745943789;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jrtE+fRaS4cMSpgCWLIWoTWC1H3gX/eynMEfcPYsyOk=;
  b=Xs0Ejz5XDAQnFSvvJWihy5iVY9EojXPuk1dSOrRNI2PUKXrgyU+aWKb0
   nt4rYw95hXeMrMrxucW5uzOdBGbTXEOvxXNBanwTENPbFafVpGL9jveBI
   lNd+clTnK7BGlr8puhwix7g3irpA6s9AjzCqsw7GGjKjAWQMMkO/KhLgI
   gMlph3/x+Vn0UWiXV1itwx4gKTKYCY2mGkkS1VnKMabzKDEvYj1gf3PV3
   iGAqa/vRKEawiDXtb6OHF/N0eN5YXJYeAr0lh82SdGpoF2eB8GfLNECdy
   dtSvXXzwd60YOAJi6uuFdCp4TKbuzeTTIRyjFXUGf8fsTtSzJ5/0BdrzR
   g==;
X-CSE-ConnectionGUID: e+zpqBHJRB6nP9GdMIlF/w==
X-CSE-MsgGUID: wj2AXW4rQPesLADZL2XeCA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10296524"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="10296524"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 09:23:08 -0700
X-CSE-ConnectionGUID: PtmlmLSlTXGlUZBJqZK/vA==
X-CSE-MsgGUID: MR1cB9iBQwex4ZeNZqbMCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="57040896"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 09:23:08 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 09:23:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 09:23:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 09:23:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hK6kWxwT4+2yA4cP9EKUQL7uIuIUoy1YGbQ9+q6A5rSZpIcKrdadEoykHm92iBGXnQrwsNqYmHWSLjoJbTUmNvuPO4WPR93SNUWcNFfJ/U6phtPVoP6RWUzAuDCioN5NLQ8YcfOiAYq8BuM1fCtadaDWxiFSV7zEB7oN3+IncdKbwuyXt9rfa3P1RVkAK2OzUf89Sj4A13jKBLJtp+vOCWi1Ayj9n1iJiX+IYetS1QoaeOCg+cqJGC2pGcqRdYoLxfLMaRr8m64roZZGi8BpVMsqckMs3eKIBgZGQa5cKMnpW6I2/U0BpRkKSkz/I4KxNBvicw5NL2yaPCL3hUfZjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6qx/FKh7lJBgaWEQ7vcDhjf6x7IZav/z+ii/KoSM2M=;
 b=T+849CENBNdFv6B9E683U/ZqaNJRRoNLnnwPWxNEiU+/V28mXiOz4lR58FpfzGziqs0fL56jYCRIbo/p/QmY28H27qHZYXfnqWj6Ca7o2xCpzpyUYm6ZGQcawul+YGMj575H/QtMQMTumoT2ajYHKDSoiXPl+tRSIdyjwkJ+Dz9go3kURBRwQehLwlMIfH4Yn0/rtbrRXGdy9X9hnGZv/ai/4JbmDYfcfiB5i2yz3dPwm7QyY5AvU/+7FU2hZdKVFxEYWxp16GdeqKlzQANsUbkRPb5nhzi46sK7mkTf3KWMprYwd0za8mAs/HgJx7Zf4o3y7Nm1YiwV2TLQWBgSzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB8176.namprd11.prod.outlook.com (2603:10b6:208:452::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 16:23:05 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 16:23:05 +0000
Date: Mon, 29 Apr 2024 09:23:01 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Li Zhijian <lizhijian@fujitsu.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH] cxl/region: Fix memregion leaks in devm_cxl_add_region()
Message-ID: <662fc9659f6ab_19ca3929435@iweiny-mobl.notmuch>
References: <20240428053715.327444-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240428053715.327444-1-lizhijian@fujitsu.com>
X-ClientProxiedBy: BYAPR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:40::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 7821af0d-d909-4972-74c5-08dc6868a5e6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dkwihg+XOUhWGirAUCTOtIuLd7WoT/h8k6BPKLQ1ucbe4btApYWNmM+ai3zX?=
 =?us-ascii?Q?lF0kkMHssUmUZdHqK+v7mEOpwBOZJVaVTZlUJfYQeMkH2aKHtzYbXiihRnJz?=
 =?us-ascii?Q?PgSkOTyzXTHdxaVlHlh3gjXtUqO6dQiS1TNdnYtNd4k20yckmqJLzwc5dcp+?=
 =?us-ascii?Q?VsapLrOmYK4776eXO4LrS6pvAUBFo1CrX9kGwUAC5ayhMAbH5EO9BPSPgd7t?=
 =?us-ascii?Q?ZMnus0/qW0beTGltjYcwBVT12iG0HV6FYwiNhZaGQS5p9enrnvj45to9cMd9?=
 =?us-ascii?Q?9AREZV0ki+cn8ycDD3xXKjcx/ILOWWiIxOdHrCbZFy5ePeaU2jNBb6rAgwox?=
 =?us-ascii?Q?tHpURH4KWKnAaPbuj0b/VZxC/eawP+YtTrdr1UR/iF2vkgYc/sO/NlZ3cxq1?=
 =?us-ascii?Q?RPOBkQpvmAbTMRZofT4FWRUALmm/8Ths/Cx+/nz/ph2iDLQlZY8hAD/C1GPy?=
 =?us-ascii?Q?GxtJjrqaIgMd5RSyy/5vpBUsTWioIkVrhJ0M7Mys6l05natnWWdRX9b30B1I?=
 =?us-ascii?Q?44riXU3hIAZe5G0W2bGjUONYVRUoULnIhot8OLgAOAnAng8XavioG8UeQJIh?=
 =?us-ascii?Q?F+aP5+by0o5XtoT1M/f63rNWwM1RbIFaX20KdZFzVGXH5SXVjK1pKX90Cta+?=
 =?us-ascii?Q?usOLUg8oeuehubI4jajnHRuaL552+0Min4qblRN+KMmBJnraFjBhZON61MoT?=
 =?us-ascii?Q?/ZMUVttvhUb5+sRxL5FH4N8NFPj3Tb4iwuvVrjplMC1U6Vzd1uVjLgwC+XTO?=
 =?us-ascii?Q?6xW8BABbqczQbTXnR9efk9jWLqYwtKa++Lg8z+G0MBN/XF1BDmab/fYegJqL?=
 =?us-ascii?Q?9L8EcG2OiDgDEUYRQ67pD50Ke58NAw7KMNDGZlWSO4nK0cHHGMMooz9bO/fU?=
 =?us-ascii?Q?bCE/kSOo+Gkh50jOd1lo7G83PIbpPgYE0cYVGztE2LkcejrmUkj38QsZfRZt?=
 =?us-ascii?Q?ztmnrHB9W+jwFp7q7J+rTns0SKqO2PoYeedxT6vNNpCsBUfH+zJGWKtRk3tG?=
 =?us-ascii?Q?2uZSY4JDrpOcKuFUVh/8ASCBmChWRL+sXIAzlnChZMH7GO0m62BbrzZzSSOb?=
 =?us-ascii?Q?MT/vj12D6pKFgmnNkivpXhC5gtdqXjr8GdMgH1aW+awWItayya13KVSyVEvR?=
 =?us-ascii?Q?EHV86XXPcvommKU4kExJi01yROmtp8Qj08fCJ5eqN0L+AW85FDB+xZXc95iZ?=
 =?us-ascii?Q?NJJ7RLq/ZydYg0muWyN4q/bhqErFGzqviLxZMudI7hHA6clRl2OUOBWOvncO?=
 =?us-ascii?Q?XY4Zkg+xLt1xvDCjCxqqyXqjdgxw73LyaPO6uTPzLw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NuSYdMJQSRl75JIUHe5TzSBRBgDUFXBsorCButRU5d87IXnS8gyguBOqkY92?=
 =?us-ascii?Q?+m1XTO/qpk9BEkvq1s/+sdIu3ZCcwEf6m3znxohToLMce/QMVFNOh0w8ckqw?=
 =?us-ascii?Q?zHsEuiu36pRbJifFkvcyMhQU3kmoYwlxK6r/akeElFllUKEwjsvTQS1UDIur?=
 =?us-ascii?Q?uA35L8F7ZO+OWDBbTihNsb46LQozcNeadP8IUcEpI9yjAzRRA/WadBF/OTBv?=
 =?us-ascii?Q?KsY/YyE7n32kLr+EIVGhH63iQQHuVSvNl9MB9+wi+A617EisTPXzjuk19F1c?=
 =?us-ascii?Q?YlT1ro7boBlao7qQK0Npg+Aol8/9evuair75Ntze4SrrS+sgVN0EEwpgWdqu?=
 =?us-ascii?Q?34VaIniVxjgMxa6bXwROqTl6kFDeE+oCh/0KIMjKvKyHj2rgkrTMrvkOaNZh?=
 =?us-ascii?Q?TJWLvSbUzGMVoPIdPRp9YOAdVZg64hb9LWDJSv9Tz3lpkwtQRyX7hyp+1rOQ?=
 =?us-ascii?Q?8+voL1xIk3CS5DLCcQTbqQ7cmpKeg6eSVnMrt6NG3CbkQW1TkRGxmKODgWS1?=
 =?us-ascii?Q?REIFCiXY0j5B+NUl1qnty/5BqnAPnrOS0mFbaOqT2YzwzFeuvHA/SHmY/+Ws?=
 =?us-ascii?Q?HcuGCFdPZEjfyUlPQ+p7chTKg1dCTo28uV+4HV9o5VBF0mw0G7DYnsI8rB6d?=
 =?us-ascii?Q?7pmg3RLC48Z0/k76OBfS76wfQO8zkx4qOiAo0WTxaBp7yBgSpee0oax9T9Fe?=
 =?us-ascii?Q?R8X6KpIKuPB0/dq0g3kg8ggdMCRYy6XiDJ1IueC0nCN7P9JTWNNy672AC3Ft?=
 =?us-ascii?Q?nAbR4XlUAgmMwWKiKiH+svo7v0xR4Ad7DBxjjbiS+SGusp3W86SZL2oxa04C?=
 =?us-ascii?Q?HlXk6fkKwS5rCDc3Uo3jthEXRt/5TV08oKOjy+SbzM5EAm0jUV1g8nUjX8EB?=
 =?us-ascii?Q?s2C68eSnwQIGnt0I18ysLaFnd0FOr+Ire/dyrt6x4Ylq3fyZfdCpWQ54KyH6?=
 =?us-ascii?Q?YEiG+zTJS5V3l8mxErsaSWL0CE5RTzbFYQK+HkXga4/Ciy6jQ3UHPcGua4Fe?=
 =?us-ascii?Q?CkTVRu1VSePtsmN0+IsBfmM1rtzmsTorT4TdT5Htav0m67gIFQufR6v2jks4?=
 =?us-ascii?Q?MZ4AeSEJ4hMKy4cAEPitlqjHZtjL1PrpGnQX/BG1VOMzrqLjsIUB66q/qW6j?=
 =?us-ascii?Q?NOnbZOAfjdTfmNHai5m+KEUdS1c0ZlhfYKaVI3/CP0b+Zf5p2MPy8cWbeP62?=
 =?us-ascii?Q?IMvEXFdNlyc6GFIRTRASF+qpqynVw2XBlvyUMVg+tJcWiwbBuMkuZhAcCYI0?=
 =?us-ascii?Q?VTPgIaVmcYBWmQ7Y3cNz9P5KmHoV8QMi6aFBlxDYyi0cdUnyZGnYLyJBsU2E?=
 =?us-ascii?Q?zkLGNyHPjMdn1zEAcz1KQjVr2DTmMmF6lYooYLKKelYHSPgDtrlE+okz9Ico?=
 =?us-ascii?Q?hoeSz8GFUHM/O8jvLYLLqJedakz+AGftHMpm0fcRJKCc/WHjr2CJDVAHuNFS?=
 =?us-ascii?Q?agwh8pb5zAJcNt2HRGOjb0cjOgE/3HYYrNuof+TdxTucqAy+SY98KHXqqYMP?=
 =?us-ascii?Q?VD6RfAJkYwI2UuOS3V14ZZ3qn0bBGAvQkXwAfyxrUzAFE3Mui+NEKgO/BLgD?=
 =?us-ascii?Q?ZvaYx7PNrK4dOQOe3tn14FTuB9GiDFYcdKZ6n4jg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7821af0d-d909-4972-74c5-08dc6868a5e6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 16:23:05.1193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MiAjIKBnLlPvEvo9MgfBcPB2gG2Uzotd+dgIG50ciRJBkWRJbz9C2r2Q5WBELx5qZ1QtOnQxnnEeMRKqBSKmyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8176
X-OriginatorOrg: intel.com

Li Zhijian wrote:
> Move memregion_free(id) out of cxl_region_alloc() and
> explicately free memregion in devm_cxl_add_region() error path.
  ^^^^
  explicitly

BTW you should run checkpatch.pl which will check spelling.

I'm not following what the problem is you are trying to fix.  This seems
like it just moves the memregion_free() around a bit but the logic is the
same.

Ira

> 
> After cxl_region_alloc() succeed, memregion will be freed by
> cxl_region_type.release()
> 
> Fixes: 6e099264185d ("cxl/region: Add volatile region creation support")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  drivers/cxl/core/region.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 812b2948b6c6..8535718a20f0 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2250,10 +2250,8 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
>  	struct device *dev;
>  
>  	cxlr = kzalloc(sizeof(*cxlr), GFP_KERNEL);
> -	if (!cxlr) {
> -		memregion_free(id);
> +	if (!cxlr)
>  		return ERR_PTR(-ENOMEM);
> -	}
>  
>  	dev = &cxlr->dev;
>  	device_initialize(dev);
> @@ -2358,12 +2356,15 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  		break;
>  	default:
>  		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %d\n", mode);
> +		memregion_free(id);
>  		return ERR_PTR(-EINVAL);
>  	}
>  
>  	cxlr = cxl_region_alloc(cxlrd, id);
> -	if (IS_ERR(cxlr))
> +	if (IS_ERR(cxlr)) {
> +		memregion_free(id);
>  		return cxlr;
> +	}
>  	cxlr->mode = mode;
>  	cxlr->type = type;
>  
> -- 
> 2.29.2
> 



