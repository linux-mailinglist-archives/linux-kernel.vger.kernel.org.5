Return-Path: <linux-kernel+bounces-157424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC368B117E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6D01F254FD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAB816D4FA;
	Wed, 24 Apr 2024 17:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="imMFfbuQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B47316C855;
	Wed, 24 Apr 2024 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713981272; cv=fail; b=FE4ElMewOztj08tdgPpPU/hq6PbPiHDGgZ9Fcsg2TET9J54Qk/8rYJcUFo9sWaW+mmGhVLq9o/skQROI4laWTRxo9yIKPHmoFWmD2RhQB7sl7qb2E8Fk3R9QDs7/jyVKPfKXqWskLS/o23pZiHPdsW5smEg3hZKSYpkMPa6Semk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713981272; c=relaxed/simple;
	bh=djXw+Q7HMfTlAEpaVdsT58AV9MtRbQkJrTpRGXoILso=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bymEza7GMJjig/lP12ovUwcGl+LVDUkQqqp2ClNASvvPvy3PcS+N1fs33gANSoxAhlBNENbwrIU0Oo6iZLiyPLEJxSCS3RdqOmHeqPI+np3Hkno3ga2WQrOH9P28Z8ZM9dMSbDQszJvXGS1yXYVAanbMQ3ZVMOX7hafNGv2x3qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=imMFfbuQ; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713981272; x=1745517272;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=djXw+Q7HMfTlAEpaVdsT58AV9MtRbQkJrTpRGXoILso=;
  b=imMFfbuQhi+cZZ1JDloA2mTqNQbAR90V4avlN6OY1gnq6Cy0OnHrbGZV
   uGwMjFnQBqRiEBLZWRypD3wttTpPkzq+bS/CmQjyQhJNHVFQ7+vDejGSo
   reV9f37/jKk1XGMpfo1rpqcrNC5r6FNA5W4Pk2caBI2dW201kiohx4o96
   X0rTAYLQzqNglKe2D91/y9+ZvG6Wd7GsgOHioutm1Fa+IUYKn1KpgZXvu
   te1w9N1z60RMlcCAy1ko1HPi6bqBjylZnN/EZ+apHsuLU2f4mSaJG3xRp
   XpWkg3XhBo5uPwcqVS4YRIiGDNGritY+8eXztPmYRHPup7JPMqC+DaBiY
   Q==;
X-CSE-ConnectionGUID: htym43vEQk+W48A3YXSeWg==
X-CSE-MsgGUID: kJaYhtk1RZOlJuZPYhjDXA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9751812"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9751812"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 10:54:31 -0700
X-CSE-ConnectionGUID: RFKN9WzUR4atLTSb97J6pA==
X-CSE-MsgGUID: 2PHEkEL/SP+zqWjeywfAyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="24677859"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 10:54:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 10:54:30 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 10:54:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 10:54:29 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 10:54:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlNknYNXa9xAxQ+Q45BP/azHi9JLYfMsZjIMw1ww95o7oK5+LXfKsSe4ufcg6ElQOR5Hql9ss6G6rgMix5L8E4vBZ/8NHsDv1LatKjO0zRBCsWhAFAZ7g60KzK6JcISbnIOJnfxq45Bhg+f7H78XBR8t/VtLBExAR83xfXuE/0wKW0+gZpXiBGAe/ErcIT4+Cj9sCtjPU2toDw38JGwI79gI8LefZRO+s1DRqRhVykkuOHNMhsj4ubcLk8OJObmsjq8HRVZ+zQpQLAyEjdHk1dnH3pqG57VJbiL0yfNxT2aMP0crbsrzHNWY/zVaKfRAwAqYkiE1SKqAEQKaY+ZkTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dq+tZomzdw5FPp5mU7s7DKXvagn3/qp1tStN7NAIfiA=;
 b=KE+y4jQW/jQsy5aPn/sjBbZR5/340MTEOvpFtJVEviCxTfnSDOV9IBQU7HFICaGAjjtCol8Pn66QWVG5FM9HXhPNBM+tocFJ90wjOwzlux3qn5sSG8uf/qAIA4cllacZizvKzRcQ+tzJV+FRzuwCvQlkb6fCvLLPIOqgOC7kLwr930//iPnUOuT+oFrsdEAVK4hi8XTpec6v/JY4SaAEwSHGb7q40qjjKH8sjiAc2t0rwFRweDLHeV4l6zVfK8rkMdKR+S60s7K21oznto7V8B4VkF7DKi3cB2UJYotn/OmVicI+3ZTFKm7NyRM2qpmeGf0Z5bNf9TJLWWxOv5+UFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB4955.namprd11.prod.outlook.com (2603:10b6:806:fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Wed, 24 Apr
 2024 17:54:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Wed, 24 Apr 2024
 17:54:26 +0000
Date: Wed, 24 Apr 2024 10:54:22 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Len Brown
	<lenb@kernel.org>
Subject: Re: [PATCH v4 6/7] ACPI/NUMA: Add log messages for memory ranges
 found in CEDT
Message-ID: <6629474eab671_b6e0294e8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240424154846.2152750-1-rrichter@amd.com>
 <20240424154846.2152750-7-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240424154846.2152750-7-rrichter@amd.com>
X-ClientProxiedBy: MW4PR03CA0146.namprd03.prod.outlook.com
 (2603:10b6:303:8c::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB4955:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a952f1-afb0-4568-fd39-08dc648794f8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?30BZDOyBZheZwmnqn1xWaE35MsYDq7S2g5C8g9fMPglBXe8bkMFn592cSOeJ?=
 =?us-ascii?Q?jtnzx+ICBPRBbJwCxyxF8ObYHzdMX1Q+q0gjKvJKaqBeO+zhOr3oH29CEjGE?=
 =?us-ascii?Q?Fvy5HA66qLSaTDavIlICtmNgW9us6Ljif7JHqDnwYJAuMmi0vzWAam5DxSIN?=
 =?us-ascii?Q?fuM0HhIOZ8xNgfvguoVmvL/fePcQAVogaDKa4qBeel6C1Umspu01d2LoerFx?=
 =?us-ascii?Q?4Lp3rwgwCd957WXcYX6JHtvhaPvW7PI8I0BfZIyCVcH1LZxLl8AY60GkV0ql?=
 =?us-ascii?Q?l7JmYlubfBxMHCAo0on28FI+nsdDPlkQRwV64x6nZc6zoUi2Rj0dkievh1J2?=
 =?us-ascii?Q?TNGEr4ZL1dCcpSM3aBlzGBFLrbkKqXAdUW+LsJppGwM33BgJRsTR8Sv+TEhN?=
 =?us-ascii?Q?qIAZkzrdqqm6QYxvRG7W+LGX55UXw9MHt23aDAXXDrx8QQczfezXNlR8u8YW?=
 =?us-ascii?Q?ELuCHRCiaJoBxHvQot0A4eNW20x+mhelzBdDaLbAjfHEUV6k9Q2s+GMKPeIH?=
 =?us-ascii?Q?Hvc4NuVQbSXRIDdWDBPELnoPolVrK9e1TpMGMB7d4r4U+NPyn+od47ik/D4v?=
 =?us-ascii?Q?AqzA2QyybnjhDXKBXuWc3zrs89px4yH0EsSqMPZDB7wuSMzLafUPoD8i2MiR?=
 =?us-ascii?Q?7kng6wegFV3CSP/RzrNSXN7XUKzoyoi/LD7bXM5wEVe4SS6BWfUjyrNzzkYE?=
 =?us-ascii?Q?ys2szKMb8eEKT5nnNpyt5aWri3i3zkBILwR1cjuTTvrA9MevQtuPBMXErkNq?=
 =?us-ascii?Q?R26oGyjMLDXUc900P9CPH69CysZkovYdVM/ae/cC+cV9ArJ96yeoYkpvquoU?=
 =?us-ascii?Q?YxZQ70qcq33RowRoO356XfmD3pfAXUFXRXMDrtMko758QHqiFSnNChjoU8sD?=
 =?us-ascii?Q?27WyefJSEoboGub0+Wh8vmiASABu+jXBbunOu5QezF5zr3+XFTwXeLdzXCPa?=
 =?us-ascii?Q?2A8RQzHsT1JNVtgNS528Lh3fitJI9EFWkEzmv/JgUKLYfm34d3LmTOfw57Jo?=
 =?us-ascii?Q?8Nu4r0dEUsHHu3790ZoUTeplgI/pwJtng7Pt/OE+Fmn9GLLkFIysKhW41LoS?=
 =?us-ascii?Q?Ih8jEGq5tr5zw1QStOscyGs6FchiOOpS1yyull03X5dUyYQOZQLXQ6aXStST?=
 =?us-ascii?Q?nEzr7oHSmwcA5vOvUWPBIRpZOoUND+gqMlqm+NHaZMx6jy51iUZCe3E08WmY?=
 =?us-ascii?Q?pJPfSreHkQ/peIzqI4C6S9Tfhme+2L4V4dprrNlPPRy2epz/488i4idyDilc?=
 =?us-ascii?Q?dUQ/tNAe7IsZ/H1ENeG0u3DFEL7PsN0bd+yLE9Vvkg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aIL5SFUrMnmeO7JtIn9im/C5ZG2+5RgqtV/XPE5cHhh7phVbXI2TdISVT9x5?=
 =?us-ascii?Q?IxlBb8N1GY0WPK2tVWpUztc7chiDS1jA3hfvrZ2Ffo73L0gy2aLxTd/hxgGK?=
 =?us-ascii?Q?bScH/X/UB8mxixnm0ip7gnfdmzOxPibwQT4buIG+ptZsW4GsgJfJW8spmEDX?=
 =?us-ascii?Q?ry2beKTIDPKOWit0kEZ+D2jU8bmzSCs6/zTUS/Zj0CTPiNntL36BLNX6KHwR?=
 =?us-ascii?Q?FWEA0A3uaqLmjc/geOQ4SmeCIXhJ90pD2LR4ng4esdvEptagZ17+xDKUqTlr?=
 =?us-ascii?Q?nIgmnOj1hcTfC3rjihyPWdKvzV/5rcWv4g+x4wD/lTGE7L5Tf5ElFIroPumV?=
 =?us-ascii?Q?7gvdEDVnaCgwl11M18mK94ZyBmuvduqGsBgX1aAoWcjj2fZd1bfDiCPS7hta?=
 =?us-ascii?Q?suXVdNy6eDzpRJYmYLPy7G2hfvnUhdFecKiII+dGXPzESlqpBklq23coZGmd?=
 =?us-ascii?Q?w63NFvlwyb/Qvh9lP1bWTWnXYnigfQ/JCoPzU3TfhtIZgFgrEZQv0jIwWI7n?=
 =?us-ascii?Q?tBmVfhmbTyAryR/8vrQQN49/JDKcI/D4ly+LTfPxydcn6uO3y6I66VpX/l1S?=
 =?us-ascii?Q?roR0Scm3am72IqLbrl0nCQFSu4SFjWcZXGv25vena08Yeotvi2qMH5M5l6W9?=
 =?us-ascii?Q?MmwlKVn+m2nRe7wcKWYn5UQ5pt8HRQuJRYR+fu0/eDkCd25ErVFNop3bmfao?=
 =?us-ascii?Q?NS57YvOnawllX5dhtkSwI6VEfQgrYsF72x2R0Se8SqJxQUceEhzuWQmLxccg?=
 =?us-ascii?Q?tKbcPmu5Z3Ev3WUOCcF1gb9mUsNNgVzKWCz+zUV/IOxpfZj8LTfTPuc0oJwN?=
 =?us-ascii?Q?DMqN6St17ke+oM/G4UXny3LQm+JTUPmVBVst/CYi2cYOU6yz/KpXXCBwz0+Z?=
 =?us-ascii?Q?EatUjYaXwTKCCuCIn9ymdrjdtKcVkEoObmj7uuM43zTwZS+5TAYKho4l51wZ?=
 =?us-ascii?Q?+VLpO6UTULvgnWusVSaEDNsFPrd3kQTdVNmGsbKxatJBBXu06NaeW7N/wjAT?=
 =?us-ascii?Q?5VZxSwUGIJAKftvqB+N7AE4/slzJyJ08HgA9P+cHf92G61VQbonMlDIpUdIK?=
 =?us-ascii?Q?/gu84Puv3Prwr6VgoV0fW/yDMOGJb9utv9gZyIkIG6saMM3mNMvlwPF21SxZ?=
 =?us-ascii?Q?oyRxnUr/EYxdxT7hrfLH0ES8PG1LDFfXVdA0CLhO4RjkFwEXCZw+udWjoNSc?=
 =?us-ascii?Q?pb6s7o2CIzVblJ4YkLo3xzjVzVjmrfJiGFF5vYmYryhs6Cq/CwMUF2/l0yL4?=
 =?us-ascii?Q?/aKfbQKkH6IXR2X0KAVctXM1abOP2UukJDCQC3qhvyqydb/6dAuRL2sSiWgx?=
 =?us-ascii?Q?g10Zx+34EONLCbS+H5UvqW5trQEmTHLs4S/Ff4PtTg7/VjEugUdO22wRf0hh?=
 =?us-ascii?Q?Q6OiCu9yGCTqhS4BEa4v59e84Wx52dmOqJXVKzjTg41s10mwjNDlR1mIDBm3?=
 =?us-ascii?Q?VelmrasUeqpw/U3ok+A6Gr5gJ2WPf+VIWZrVBLsVeGD7Y919ShENfcNTbfIh?=
 =?us-ascii?Q?kkTfFDjt511TCkHWQLthS5Ssx3CNuwZVnHKgVeqnFSvMc+4zNlvztvfjpcHg?=
 =?us-ascii?Q?vGHlkHJifzPipW1AzuPR5U8niVvRBsRVFdR4gBXyHpSAIwuuAqMAZPPAlNj7?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a952f1-afb0-4568-fd39-08dc648794f8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 17:54:26.4050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EuuGOT0TjxZ2PMHWr74ALw6X9qKY9HKewWi8tR7AFr3nF44gF1XpWqOL5A4/6dq5wB+EiAuadoH+SILbuL48NXdaKsBzgQLhUIFZ8MOXAkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4955
X-OriginatorOrg: intel.com

Robert Richter wrote:
> Adding a pr_info() when successfully adding a CFMWS memory range.
> 
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/acpi/numa/srat.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index e3f26e71637a..c62e4636e472 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -338,8 +338,11 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  	 * found for any portion of the window to cover the entire
>  	 * window.
>  	 */
> -	if (!numa_fill_memblks(start, end))
> +	if (!numa_fill_memblks(start, end)) {
> +		pr_info("CEDT: memblk extended [mem %#010Lx-%#010Lx]\n",
> +			(unsigned long long) start, (unsigned long long) end - 1);

This looks like pr_debug() material to me.

>  		return 0;
> +	}
>  
>  	/* No SRAT description. Create a new node. */
>  	node = acpi_map_pxm_to_node(*fake_pxm);
> @@ -354,8 +357,13 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  		pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
>  			node, start, end);
>  	}
> +
>  	node_set(node, numa_nodes_parsed);
>  
> +	pr_info("CEDT: Node %u PXM %u [mem %#010Lx-%#010Lx]\n",
> +		node, *fake_pxm,
> +		(unsigned long long) start, (unsigned long long) end - 1);
> +

This makes sense to mirror the SRAT pr_info().

