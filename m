Return-Path: <linux-kernel+bounces-136211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB3A89D13E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E0E9B21A01
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BA856465;
	Tue,  9 Apr 2024 03:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ChQAXjud"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D80F55E40
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712634074; cv=fail; b=OC0AiUh3Xr03u1x0cAo7qQgze+sYxruYEJWd7jZpHaakcc/VdzpE9AWnxCOdrwpaAy93cJXw0i93ptmScQoZDHmz2BMHxNY52CZol/9sHMYDfpyeOcoC3mvXFRxtzhPpkniGMZhEUcpNrRQOwnJE14tfUxT5xguQbwtG2MuLbHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712634074; c=relaxed/simple;
	bh=puE35l+6lK9vuUMO+Fxz+894BA+UnOA9f1pYoha292w=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UqB/WCcVfZJ+luJF3ssxwjF8cifhdeoxEcSy/Zp6QZ67WOl4IJqjwcZHKKPr7alJgmsWbwyyM8OQFXAAXPbFXtM9qp8rsp2AeJ2QmBziF+o9nW85YDUr6uu9hz67Ok6xUkwYC2lhezCfMH6qO4fndPgqozSqc+eZKeZ6f2rhAdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ChQAXjud; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712634072; x=1744170072;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=puE35l+6lK9vuUMO+Fxz+894BA+UnOA9f1pYoha292w=;
  b=ChQAXjudUQgpNoPVe+mUMJHUHEKjZA6Ji3beoGrOVowVo6P8EdszH/VQ
   eyhWqruGeo+3LbIRQbvITxESkBpVjGIu/ADaU6pvNa9Em2aQ8n9Vdo9fS
   7wBz0Iriek4MVfwrhsrOjB3oOgmycoOW3jq+x/5hx4NmkWAGvBlmjd98y
   e/GiV2aoIXX17ORCdpv3g5F/OvmkDdGhD9WEGBuOmQmUBB40eA9ELCjRI
   srbTmhbBqrieDoUsGGK4WEAgLR8S+DKCjtJ9garZVoYqiNKsFWJ950Pe5
   MS4XkOEV9HE+b+4VUJ4iGFYmjkoLXoPgkSaFQLg5bg1eOD7fhkRxd185u
   w==;
X-CSE-ConnectionGUID: mmZjnVSvRaS8uVKBnWqcog==
X-CSE-MsgGUID: eQbWVQ8dQbGzl6rc9a0/zg==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7790723"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="7790723"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 20:41:11 -0700
X-CSE-ConnectionGUID: rjOVnjIAQ9yzTN3CV66QjA==
X-CSE-MsgGUID: vAYt8HJQQ0e6jf3bf5nBYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="24831949"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 20:41:10 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:41:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 20:41:10 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 20:41:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1HaF2abMpsuVCUYiQJoob69h0QVhSavXrvNYKpE2FDA6pvZ3bbzZLV7QGfKSy//XjFNNRmHKAu80ao6UWSWucqqGKfj5hXO0NH41Yi881ONwt26owAuj5Rhq7IdgkDz9Jxp+qJfKEr4rjSX2EcaXJHoegNJjdR2rALdYj8mbnGeeJQt4U0pJ30FAtmlT3hg0OBdjp3lMDvOiKvBOHQG1oc1kiggCjQIYieSl5fktFKKXzo3G7vO6s5xwjB7Jh0ZCIWvsalgmm5RevuPvIVOueexTU2J+0VBWXVIuaYG88MIOblfbtzvqdCqJBOxMOMqtOcbHyKqcVjV+HgMEcT5vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xdb5IS/77/68ilRqZQx+h5HN6ZFGv+CoUV4iHed+Byg=;
 b=f25/Rsd95xNvUsN+gaopjopY5TmOZIonVqjjkyx1agTnNl2//ww5reIH2lp8vJEB4k49I6SdbepCTLxZfktAK+3Hqk8wgMaop+0FfOjypLiVdaXy5flwc/tlc+WbR2ooCrd4DYEo4rY5inr4puVX2DCusTFK26/GehMaGsNpMhDJ4XPdRhLNS9eQTfdtsQmk1c1jI3YBd4y4IE+TBh3dtoS0nXf5RTuMqmxzh6xhY8hpB/zlmDvTiTg4MyWNBV0CzNYvzRM1UEBYMBEnmizdH3ofaPXK41vBL2dG6K11PGlPb8k+ETqa2U+Y43vJrRHnMzq1W4/XDF7xkEMQAjD8nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW3PR11MB4666.namprd11.prod.outlook.com (2603:10b6:303:56::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 03:41:08 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 03:41:07 +0000
Message-ID: <fb4abe11-5859-4a53-a4db-bb4e59a571c6@intel.com>
Date: Mon, 8 Apr 2024 20:41:04 -0700
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v1 29/31] fs/resctrl: Add boiler plate for external
 resctrl code
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-30-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20240321165106.31602-30-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0251.namprd03.prod.outlook.com
 (2603:10b6:303:b4::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW3PR11MB4666:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 57MfNyxilbcQffiZBLGjmxQyDO68WDh6fkZ31OIhl6yQDfG98Hj2LmXTxxiGz2sae0/x2+QM142kiTCd01pxfdtF5FMcS1XsCNRX7KF1+waPemNrFk5iCh3UNXab7MbqjZn/tR7QX1F3/+vzpV0XUTVeLdqRwcO8lLLNmOa5Hj461VB/annzUbavFmvKl9pbruCiBZYq9teL1QSk2xsljrwP+v6psSXsnU4vhPujfS4bXpaGobFSgXeBByLdwEpxnxj+ugbtrFwv2ubGUvj7LUn7qnj9GDd3r05KXHoXBEpywqRukmAJdAz/fd/dazpJ70kvY4mHGV+8lGiZ3qFmg2rnDdUqEU/nNYdbERYDcxaaLMD++76UMnumQ1h9R27vjP5dBx1zJvNlkQQInbZYiF3L/OxQbYfdEh2mIDv6BYvK4uEdC/J+teLzTtuBCJag1KASVe9++Sj0N3a5gRxXm2C3pIzasUQpjjJ5kOoG2rmjZJs4eaqQkUQMz/Pq3Gtzh9UoaiSzyQ8l/au+lbhMvR08/k0xueddZ7noTUtdK/ng6CSE9cGAdpzfSsSa7aLbEPQ8sVTENtP7/j63/REzqQMAH/t74GqgH8qMj4+Bi9iwzvRHQhGh2HhLE9O8b9tiSwynOjVs6r7nuQ2/0KSYSwIMTfFTsHLyj3S+hDlQ0wk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVU3SlZRTGs4Qzc0U1kxQWlCTFVBOEc3cm11VGFtZUVVQTh2QU02YXhsYVBH?=
 =?utf-8?B?cW1VYkxtS0ZhcjRyOXJNdkJvQWlOWnVzNGNkcnZibzR0dnhFR0Y2WExiaDA5?=
 =?utf-8?B?Z3dFT0RVbVBmUWVmZEE2a09xZmdzMy9ZRlhtUGJyV29QSjk1eTVEZHVwL2w5?=
 =?utf-8?B?Y0tVRDZkZXJwQ3I1Z0M1b3E0akJOeFoxTFFSSXYvbjA2aDFXN0ppcm5Td3Ev?=
 =?utf-8?B?K0hTL2VOMW1BQktlbnNreTBMc3ZmL1AvY0pzaUl4dDRMbVZ3a3huOXNIYjNQ?=
 =?utf-8?B?SklySCt0Z1Q3QkJUUkJzMHVKYjI5YVdpR2RhOFk2UGhXVk1TUkF1aG1BRXV6?=
 =?utf-8?B?MENkTWYweldGalU5SEhNUnhldi94M0QvbnNCUThySVA2Tk1sWTFoR2lKdVJF?=
 =?utf-8?B?Vi9CNU1CZG9OL3NUQnVFbERQYVNJZEFyaTRFQlVSTXA1eEs3VXRnUE9BTzVj?=
 =?utf-8?B?QjJhRmsxUVdEc1doemdjQTNQNTNoUXRnZ3VUZGJtVzZ5MGo3SU5ZbnM0OEg5?=
 =?utf-8?B?YVJXUmJBTnh4R09MQUprVkFtQlg1cS9GZkhBTE1FcDlDMjBTRG5hMEwrVzBh?=
 =?utf-8?B?MjFHcEJ1OEtuMjNOcHhkUVo4cEltNnlhM3JKNFhRVVRlcmU4U25QMGNJbmxV?=
 =?utf-8?B?Sjl0bU5JV3JxVkcvUUpBSnlXSTBwU0RkMnJ3Q0hDWld1bDk1akJMcVNKVmx2?=
 =?utf-8?B?cEdYR2VUZS9IdUI5dk44R0JJNUtIeGFDcWFFcnhyd0lzVElCbFErNDduQkxu?=
 =?utf-8?B?RnVSVXN0dkh1UXlqUExnM2tpUTdhOHFzKzcvdHVYN0h2NUo4dkx2bS8xc3Rv?=
 =?utf-8?B?RlpJNmNsb1pjc0tVWXlEV3NXZ1pTMVRUeTdHNElUTXZqVmhqWit0OGtQRmFw?=
 =?utf-8?B?ZzQvQjNZUTZyaGpFVUFNNU51STFFUEhhVitqYVVtQ2tMaVpaQ2RBOUMxMm1L?=
 =?utf-8?B?SFpuNGtaQWpqbmVCbFZwRC9pd2dtTWpDTzZyb2JWdDBFdjZIQkZtN3Z6cy9Z?=
 =?utf-8?B?NmhRNklwQTQycWpNZlZyb05vcUhmSElDcy9rWWRGQlNGVWNUbVg0NTU4YXF0?=
 =?utf-8?B?dnp4RUdDb0piQzJTVkxrR0NnNVJrWmEvOVdJZXNQQ1pnaWZ0MVYzVkJudlRp?=
 =?utf-8?B?V3p6d0hZKzdsT2E4dHBBNGR4SVJUeldOT2Rkak93UEJDeXl6aTZWVlBGUFVr?=
 =?utf-8?B?S1FBSStGdVFBbU1rNjBQTzhrMVNrcWxMWkRrT2VJeGJ6UUc1MmZESWxHeDVT?=
 =?utf-8?B?ZWxKTW1CRFhtWGN4d01YS3BlK1hQL1lRWWZ6elI5NmRHeVBUMjBDcGI2TXJE?=
 =?utf-8?B?VjBKanJpYmNEMm0xMnJ2K1Y2VVU1dkVxcTFLT2VPdVlJYkhVVzdDNHVTZjRw?=
 =?utf-8?B?OWhNdnVrUFZpS2VzbElGQzhBL1NQRlF2N0hValJyWXJkMDlyQ1A1ckIrRmkw?=
 =?utf-8?B?bm5KUjE5Q0U5VEdEQWFyZE1iOFNGcFM5MUVsbXVUSjdZQXpBTzVOV3pxcnFV?=
 =?utf-8?B?cldCc24xaGFwZk1iQUtIbUdoTHAwRXlwZmF5aDFkcDJWUjZjZldxSkwvaTNa?=
 =?utf-8?B?dTVuNk1sUkhKN2Y2U0U4Q0Q3Ykk0QUlMM3NZWlpJREQxdGF1bndkTFZYVEYy?=
 =?utf-8?B?ZDk3bFpPRU9hcUdLK2dPYnducnlRZkhrUGVPM2FJa2g1NUZ3YnZrSHBoOUZa?=
 =?utf-8?B?YUhiNklJcmExK3Uya1BCcVFhenNEOE9KVkhmUHhFSTdLY0xZMHB6cmk1WWI2?=
 =?utf-8?B?VGpsOXc4TGhKRE9hOURaUG50REU1SGV1Y3hka2gvOGltQ0g3UWM1Qjl5R2tz?=
 =?utf-8?B?SHoxQ3Ura01SR0JpZURHRjFkZWpra0piVTY0bmt1ZGhmOGNPSGtodVVzL0hC?=
 =?utf-8?B?enFQWllJdS9hb2FBcFFLcFBOZ3RHRTd6cFlHS1QwMHBrQXZOVm5JOHVRWEZY?=
 =?utf-8?B?ZVYxeDYwZVcrdThaK3ovOHpPc3hXeXhHeXdOczNBZkEyVUQ0d25YSW9uVFRn?=
 =?utf-8?B?UlRCWDBHNjVrVjRHNGMzcGlPcHNJdDB2bUdHMjhnUjZtVVBmMzZ6UFhuK3pB?=
 =?utf-8?B?QkZPNGxRa05wT1JrbU9ORzJnKzY0RTRnNXpCeUhYbzREeWJ2US9hcDVSWUtr?=
 =?utf-8?B?ZUFONUc2ZnNWWXgwSytJOVVzSTE1Y1VIamNCWkV1bmRDVUd3TEJxSkxPNnBi?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2cbb1a4-51e3-45b6-e27e-08dc5846e38f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 03:41:07.0042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Htputo1AOS3vKTnYaXjQCN8zd/JwpOYpggjrhcK52Jh0ttZvg7pHLL4hbxI+o06PH1h3uJbK0PeL6DFyY7TF8vJprLZOJoDdd4FyTV1dCBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4666
X-OriginatorOrg: intel.com

Hi James,

On 3/21/2024 9:51 AM, James Morse wrote:
> Add Makefile and Kconfig for fs/resctrl. Add ARCH_HAS_CPU_RESCTRL
> for the common parts of the resctrl interface and make X86_CPU_RESCTRL
> depend on this.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  MAINTAINERS              |  1 +
>  arch/Kconfig             |  8 ++++++++
>  arch/x86/Kconfig         | 10 +++-------
>  fs/Kconfig               |  1 +
>  fs/Makefile              |  1 +
>  fs/resctrl/Kconfig       | 23 +++++++++++++++++++++++
>  fs/resctrl/Makefile      |  3 +++
>  fs/resctrl/ctrlmondata.c |  0
>  fs/resctrl/internal.h    |  0
>  fs/resctrl/monitor.c     |  0
>  fs/resctrl/psuedo_lock.c |  0
>  fs/resctrl/rdtgroup.c    |  0
>  include/linux/resctrl.h  |  4 ++++
>  13 files changed, 44 insertions(+), 7 deletions(-)
>  create mode 100644 fs/resctrl/Kconfig
>  create mode 100644 fs/resctrl/Makefile
>  create mode 100644 fs/resctrl/ctrlmondata.c
>  create mode 100644 fs/resctrl/internal.h
>  create mode 100644 fs/resctrl/monitor.c
>  create mode 100644 fs/resctrl/psuedo_lock.c
>  create mode 100644 fs/resctrl/rdtgroup.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5621dd823e79..c49090e9c777 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18543,6 +18543,7 @@ S:	Supported
>  F:	Documentation/arch/x86/resctrl*
>  F:	arch/x86/include/asm/resctrl.h
>  F:	arch/x86/kernel/cpu/resctrl/
> +F:	fs/resctrl/
>  F:	include/linux/resctrl*.h
>  F:	tools/testing/selftests/resctrl/
>  
> diff --git a/arch/Kconfig b/arch/Kconfig
> index fd18b7db2c77..131d874d6738 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1406,6 +1406,14 @@ config STRICT_MODULE_RWX
>  config ARCH_HAS_PHYS_TO_DMA
>  	bool
>  
> +config ARCH_HAS_CPU_RESCTRL
> +	bool
> +	help
> +	  The 'resctrl' filesystem allows CPU controls of shared resources
> +	  such as caches and memory bandwidth to be configured. An architecture
> +	  selects this if it provides the arch-specific hooks for the filesystem
> +	  and needs the per-task CLOSID/RMID properties.

Should it mention monitoring capabilities?

> +
>  config HAVE_ARCH_COMPILER_H
>  	bool
>  	help
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index e071e564452e..cb043543f088 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -479,8 +479,10 @@ config GOLDFISH
>  config X86_CPU_RESCTRL
>  	bool "x86 CPU resource control support"
>  	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
> +	depends on MISC_FILESYSTEMS
>  	select KERNFS

Do both X86_CPU_RESCTRL and RESCTRL_FS need to select KERNFS?

> -	select PROC_CPU_RESCTRL		if PROC_FS
> +	select ARCH_HAS_CPU_RESCTRL
> +	select RESCTRL_FS
>  	select RESCTRL_FS_PSEUDO_LOCK
>  	help
>  	  Enable x86 CPU resource control support.
> @@ -507,12 +509,6 @@ config X86_FRED
>  	  ring transitions and exception/interrupt handling if the
>  	  system supports.
>  
> -config RESCTRL_FS_PSEUDO_LOCK
> -	bool
> -	help
> -	  Software mechanism to pin data in a cache portion using
> -	  micro-architecture specific knowledge.
> -
>  if X86_32
>  config X86_BIGSMP
>  	bool "Support for big SMP systems with more than 8 CPUs"
> diff --git a/fs/Kconfig b/fs/Kconfig
> index a46b0cbc4d8f..d8a36383b6dc 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -331,6 +331,7 @@ source "fs/omfs/Kconfig"
>  source "fs/hpfs/Kconfig"
>  source "fs/qnx4/Kconfig"
>  source "fs/qnx6/Kconfig"
> +source "fs/resctrl/Kconfig"
>  source "fs/romfs/Kconfig"
>  source "fs/pstore/Kconfig"
>  source "fs/sysv/Kconfig"
> diff --git a/fs/Makefile b/fs/Makefile
> index 6ecc9b0a53f2..da6e2d028722 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -129,3 +129,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
>  obj-$(CONFIG_EROFS_FS)		+= erofs/
>  obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
>  obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
> +obj-$(CONFIG_RESCTRL_FS)	+= resctrl/
> diff --git a/fs/resctrl/Kconfig b/fs/resctrl/Kconfig
> new file mode 100644
> index 000000000000..36a1ddbe6c21
> --- /dev/null
> +++ b/fs/resctrl/Kconfig

Could you please review the contents of this file for
appropriate line length and consistent tab usage?

> @@ -0,0 +1,23 @@
> +config RESCTRL_FS
> +	bool "CPU Resource Control Filesystem (resctrl)"
> +	depends on ARCH_HAS_CPU_RESCTRL
> +	select KERNFS
> +	select PROC_CPU_RESCTRL               if PROC_FS
> +	help
> +	  Resctrl is a filesystem interface
> +	  to control allocation and
> +	  monitoring of system resources
> +	  used by the CPUs.
> +
> +config RESCTRL_FS_PSEUDO_LOCK
> +	bool
> +	help
> +          Software mechanism to pin data in a cache portion using
> +          micro-architecture specific knowledge.
> +
> +config RESCTRL_RMID_DEPENDS_ON_CLOSID
> +	bool
> +	help
> +	  Enable by the architecture when the RMID values depend on the CLOSID.
> +	  This causes the closid allocator to search for CLOSID with clean
> +	  RMID.
> diff --git a/fs/resctrl/Makefile b/fs/resctrl/Makefile
> new file mode 100644
> index 000000000000..10fcfb0fdb10
> --- /dev/null
> +++ b/fs/resctrl/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_RESCTRL_FS)		+= rdtgroup.o ctrlmondata.o monitor.o
> +obj-$(CONFIG_RESCTRL_FS_PSEUDO_LOCK)	+= psuedo_lock.o
> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/fs/resctrl/psuedo_lock.c b/fs/resctrl/psuedo_lock.c

pseudo_lock.c

> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 5da55e58f229..f786ffceeda3 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -8,6 +8,10 @@
>  #include <linux/pid.h>
>  #include <linux/resctrl_types.h>
>  
> +#ifdef CONFIG_ARCH_HAS_CPU_RESCTRL
> +#include <asm/resctrl.h>
> +#endif
> +
>  /* CLOSID, RMID value used by the default control group */
>  #define RESCTRL_RESERVED_CLOSID		0
>  #define RESCTRL_RESERVED_RMID		0

Reinette

