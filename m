Return-Path: <linux-kernel+bounces-165697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 046028B8FE3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858D31F23ECB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1291805A;
	Wed,  1 May 2024 18:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gftzcC19"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A291146D53;
	Wed,  1 May 2024 18:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714589498; cv=fail; b=NDp7uorkpzBxsw4C7oIl6a9/LaNdN9dM21wg7gNhY6sAm64Qz62o0pIpBtNV5K60zG5RczrbzkV19xb8sf4n35QXE4L+9JNVJAP3mJj/XaphlnnpM3vS3/vWHVZjrKNs5N4bSJ0EXUm+CvPioYGEghoQJtnpLUf5LUWzwGJb358=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714589498; c=relaxed/simple;
	bh=t7jKREjWjakiLiwbdar7YlSI8HJZhJYEh4cLY02N0Us=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ndQwIdkwt2+Mnk6xmqHQFSjCM3ptvCslMLpm3kZyrom4Vv9fosFPZ7GlWztZHivox+7eIObfYGFK1M/oznIjxdtsaB/3j9Pg5oPrdfx+uu6wdsjEs5xT0yhxaHFjRDhLStcw87iNhdOLhsHaftJ1XSMYfQsA46z7HiFkBfEB4+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gftzcC19; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714589496; x=1746125496;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=t7jKREjWjakiLiwbdar7YlSI8HJZhJYEh4cLY02N0Us=;
  b=gftzcC197RmCUP58QOk3fTN+M96gOfYCmHmk2TGkRA1xGeKWusFiJQTv
   GqjBpmVsBebSSigpdlEbhZjTwLRwjYTpNh4wg62cyCf4pPKbpwJkyLUyN
   VLwVRT+gadA3Y9TweoMfjO6MjlBw40+QTVaCg/TvYHTiLWYU1mq5EroBY
   fvd2/Pb6qMdc8Hj2RKS6BfgbXbB8U29i2Ub7ZCmU88EoSuNcCyH8zoDEO
   /WYPpZnKqZ9ulUM/mjc1N9mThw9yvtfqLmUM3enMrZZ5ogI3EdL5Y+XID
   Cxbh7lv/Kwng1gruuDY+hzyBl7FgfjMpbnh0K0BcWaeULrANwPB+T/3ZS
   g==;
X-CSE-ConnectionGUID: AIY2+YTRT3a+0adg036vUQ==
X-CSE-MsgGUID: XJ3N/W/sSoK2TJz+TBZRag==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="20950534"
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="20950534"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 11:51:35 -0700
X-CSE-ConnectionGUID: uDZ+fjBdQPasxXYQWHtFsA==
X-CSE-MsgGUID: QxYAYEMrQLSrSSFbQju5EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="26888040"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 May 2024 11:51:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 11:51:31 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 11:51:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 1 May 2024 11:51:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 1 May 2024 11:51:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntvsHL6RSbQA5lc4rBKggYH3qTspCt11VzUAOeOZCajxmj81qcq84oL84xdw8awjORHXR3B6mkhMZHfgq8mUPyw4O5iUPjnL2BJWVkJa+pc+vqywaqQghAjYZl5DKEAkcSZSKRmFWxFl7uS9gLFFXrsD+M5o0CErsfZO42MsefUC6jvdYk0IxHOtZrogVFErbC6WxqQfRQqZq/vrdL47ty9i6joph7Ky0ql74MsShMKqeuok7e6j5930QpCOpCg0NTP7w6dJMbKqtYOTLfVK1UvzfAFPwhGNM7hWO1LTFKg8liJw2WyjlOMQnC4LEjBiB1BwyhrXbURTOnywPEAKxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhsUYyVp4+CeqiHil7LseJ9UMUfwV+jcobVe6fOOXKY=;
 b=jSwKfxGolcJIJILrA6N67MYc976DbaB+SDoWE4W0fv9UeWo1VFS96SMDAEsvxSKqzPcSU2PQePae1RTIFTPADw6Vlu8irkTTmDI/PqcQ77nk4dq/e6btKGUKPCihUWPZor/6+MXUKqU9vqwq9ID7wZYdm5GIF1+42lbGC5h7s0TdMw+2x9bUeI5SI8KrVNhkPi6R/GVnONDvbh48rV5odC4+9LxIyvPkdGAMZoqiKCYB/1/5d9H0FH5FcumiQVL/2Y/S2budwWCnJpIIC2gSQ9tMhj7UpAa0UOwn0Twf0j3CbnpBlodkMlJerQW6tXrjMxkVQsAniTUyfZborIxAGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6089.namprd11.prod.outlook.com (2603:10b6:930:2f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 18:51:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 18:51:27 +0000
Date: Wed, 1 May 2024 11:51:24 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "kernel test
 robot" <lkp@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl/cper: Fix non-ACPI-APEI-GHES build
Message-ID: <66328f2caac87_1384629462@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240501-cper-fix-0day-v1-1-c0b0056eafbc@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240501-cper-fix-0day-v1-1-c0b0056eafbc@intel.com>
X-ClientProxiedBy: MW4PR03CA0296.namprd03.prod.outlook.com
 (2603:10b6:303:b5::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e17b1b-526a-41ac-740d-08dc6a0fb4e5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?laYLT/dogmCno6kgD8AO4HytaVbGMvtjRUpwpAFBvsKi4ou9AkOT6Hn74wWv?=
 =?us-ascii?Q?HxZb/VJOxDopj3+lc1P+FXSArU2u8lraoLvaV6bHDn5LYG+wDvx3fAyrxSDL?=
 =?us-ascii?Q?1oDHl3Sw1JMRx1bJdVx+2jrWuHywG2xe/WMcFab7RwcwrEBQwp3r0V4fFd8m?=
 =?us-ascii?Q?K3ZjOOSj6f210IZBepoympBMpeeRJwIW+rNF1f88C8xgR56rb9MvvngqEGUj?=
 =?us-ascii?Q?zUZArPBqVpMzFYedpWRpxsh7iJi4Aa33lRsRFEu0jgHINq9pIw+0li4BTmCR?=
 =?us-ascii?Q?fGdjujq7443wy/0XXEP/66Mp3oiJoLfPlh0RoBmMoMYsUzVkvf9Taj6V3ipN?=
 =?us-ascii?Q?KHyO2U1whhCc3wU6fnAwyBt9ZL7BS8ntTxfxm9qFBHo2FfPYQ//rLNGJmULq?=
 =?us-ascii?Q?/LGReG68TjGNnKpBtRgmAq/nGTb/13FGgR1ybzCJjN7QtJQObMQqHYUlU1HR?=
 =?us-ascii?Q?3VFQUCA4yWvkr2mQvrqqybMP90ZgyuzrtR5gxS59e1Hi7oA+U3Xih3/MM4DL?=
 =?us-ascii?Q?F5ifnw4arshhYPNRph7VnVLeqyptCA9NgDE7aLdXathdu4NZud4hsveej0qi?=
 =?us-ascii?Q?s7jGALzTp8Jv2TlQ/WKJpnnnKTaMRZQ1bv5MIZuuHj7caDfxhAyWYNaaFgFX?=
 =?us-ascii?Q?sfi7bsyhkUjZA6iXs+ZZCZCzOBtwGR7nLjMhpVbCDEOGes8urNlwDV3P5zU8?=
 =?us-ascii?Q?BHiOqPcwAltleGJyQ+kOmyfP+mhXokd5Zgf7xMpALUpnjo+o3/aCUD+QBsf+?=
 =?us-ascii?Q?c6qA8yQddWX4PUpaqXIkxnMGsQkbrUwHi4OlQjEB8hIj7KHKtXB/ljDRQCgc?=
 =?us-ascii?Q?05u3HNoFYBSfUPSM7n7L4GQMLoSRKcZxQafHhJc0oTviaSb/tdMspySnVfj8?=
 =?us-ascii?Q?v9Yv1+61YnettelHhmNynDTyn4XIKLYQign0dWa2Tudc4fLcUU4AmnQZEePN?=
 =?us-ascii?Q?l2yfMZFJpS1HP08EhdU/QIf7PQr+wcAc6vJ2ucgCa0Zdvqht8wy0W4L2q9nJ?=
 =?us-ascii?Q?uO5sHIwVzf8eDXm3BiZKKaCA6mXH1zQAlH7lVAkkPoGwha2i7lQsO0a9psW7?=
 =?us-ascii?Q?M+0fPrKDiiBNpQ4vGVquEcKE3tHZH9giIVtEq4XaE0qQZGu06JvAXU5lYPZ5?=
 =?us-ascii?Q?bXAwXCruPkRWEnSRgeoXw6y0LrLpySpYfzUtOEs2UcgQY6VbH0hmHiuHrsuK?=
 =?us-ascii?Q?1k71p6sl/Ql6393zwn3Yo0BPWlxsJl7x5Bz+VZrADd3fnOqbKG+qFcZpYzw?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X6QHz6oFU8alB8v9poo4u4TCLbiUzadhEt44SkRNIuDCkTtvuY7NOWn/LUiR?=
 =?us-ascii?Q?1n3pTuvLA43gEMgTXfHERKBx9Uh1CSJhh4ck4uhAMiZXi1ZRTCyALl5+F3Gr?=
 =?us-ascii?Q?LuNkc7yinzuSfynZcacQi/EFN667dDOrfXHQALjvHXLrPS3LQsmxRSWLrux3?=
 =?us-ascii?Q?Lob8+k0FZxFPbSPXXEZaezrozh3sfwL2f5rEaAShXmlse3U+pN0RCyI9lfir?=
 =?us-ascii?Q?AAfJUtvhDob/JksDSLg4IoleUDBJiWHWZi6SSln1PyMk2a7RUKlXuXDFTsNt?=
 =?us-ascii?Q?bAFQCw9H6a5X8Tf3pEW65hA0ISwyhmJ5/R4L6o+ConRu/L04LaqVhnM12un9?=
 =?us-ascii?Q?MlGhXVFhJ4gBQ9uzm/tBM9iO6xne/ygv1yARuE7TeWmzMSuduOPFfRygV4AF?=
 =?us-ascii?Q?MBigWDNj4C5Niu4GiQaVX+sisO51Mi51tugd0+4jxeJLgRXg+dUcwSjZRjH+?=
 =?us-ascii?Q?+NDLQoVE739RY2olW6dJuzkHQ17WLidoljX7dkj0C8Bfsxrn5obLouj2NT2b?=
 =?us-ascii?Q?TwWaJ368uPjTd1kpjnZLpoJDMDaYNXtb0vJHnRpNWNSC+excfyt5AmlHmsMU?=
 =?us-ascii?Q?igIc4kjAGyfBiMBfINC3besREpPw7eQfPOiovjJmDI9lcTo/ewNTvjeaoXOT?=
 =?us-ascii?Q?b6CS7ukO0FsFKKSuftUm2WU+eUxI5dxTWElHoAymNNj0wCDMPnXJXU3Fbt2i?=
 =?us-ascii?Q?9NXrISkChst0lEre/K79pItgjdddkslZZqlxOfc7xEnZfUYqfbH43D+1Excy?=
 =?us-ascii?Q?gBLSHh2iRaQB4R+DH7s0BqXeNHxVWh59I/1rEU/xd6ZiMxh9v0W/0vW+IqyA?=
 =?us-ascii?Q?PPYosAuZ4je3CM4SaARE0JIIRuU492WQeXqXn50HwMSQcNAQgGt36ASzGdkp?=
 =?us-ascii?Q?fj2K6ku4/zRV89/RFlPTdxuS/bBI2dpoLev1o9vxYvWOzUuqJW/iZeZsFYBj?=
 =?us-ascii?Q?nnHEpaX8lu/cT4YlK7QEyxsLUEZk7NUs81I+76GpsnKR8BA2+U0cPZhSYQTJ?=
 =?us-ascii?Q?1gSk+y6Cz2eqYXERs0sU479q3448FMCZP49jO5oBk2RWlxIHwMF28mSKWaF2?=
 =?us-ascii?Q?bXsOmYXoJ5ISakEG95aj83BCBk7Nullre96+b5nK+1PMsqVNo9fcQXR+VNje?=
 =?us-ascii?Q?u2I/W2HxLDRgyLo5HUvbIIblHCee5hYG0LAoTMFEFRr4j/Z3uM945yBjPM88?=
 =?us-ascii?Q?D6rcH3tIWWZZd/59TczriO2OaRxo+4Gt8pmX7Gqz4Wxo9AbhewCNuSGPrjfL?=
 =?us-ascii?Q?bXTBaZrXnJ1dvQ0raZA4JUcogn1d6UBnCclu/3ATxKC+OWp6qF2sCvKVLpxt?=
 =?us-ascii?Q?DHC7q5IHw4pb5VO0fIdksJLVcvP27ruG5Au77sJmUpKk0fXU6hwoPzINe+pw?=
 =?us-ascii?Q?mZA68M9LjaieSkUsMncbpxcjUpKvhDFXfD43AZI0HiFisIAs+iDoG8X30Kcy?=
 =?us-ascii?Q?q1+kyz4o9o0nx0IByxgGIE58plRrcimg1GNyDVAHox6VV36QchI0+uO2GR64?=
 =?us-ascii?Q?6KafR1kouzoIc5bMy4z2LiLwGWA+M8pL5eYwFw2H84n5dh+71ykerKE+Eb4t?=
 =?us-ascii?Q?guCV7qOGi2mhQweaUcWTq2/5aCcf7bRVokDLdkif0DBuJLjnPMx26Ac7RG6G?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e17b1b-526a-41ac-740d-08dc6a0fb4e5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 18:51:27.2777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HT46CjtQRXHAkXqOrX/ydy8M5v9WrZagTiL7V4e/0IbYugB8Slf3j4PJN5TrNxCQCkDvtkmmIeRhjFSt12EVrESlET4ExGiUUiwhMB/Skn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6089
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> If ACPI_APEI_GHES is not configured the [un]register work functions are
> not properly declared.
> 
> Fix copy paste error.

Copy paste? I would just say:

0day notices that the cxl_cper_register_work() declaration in the
CONFIG_ACPI_APEI_GHES=n is broken, fix it to be typical nop stub.

> 
> Reported-by: kernel test robot <lkp@intel.com>

Checkpatch asks for Closes: tags these days:

Closes: http://lore.kernel.org/r/202405012230.6kXItWen-lkp@intel.com

With that,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

