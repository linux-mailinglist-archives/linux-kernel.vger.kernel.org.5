Return-Path: <linux-kernel+bounces-164225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019F78B7AE6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABACA2867FB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188FC143732;
	Tue, 30 Apr 2024 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jizZdnBI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC1C143734
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489267; cv=fail; b=GJh3XSssOj1Rer8rwMexjTzKiDadhXh+9AmQOiuwQgiZNvXYjluUiDqSAniDmLjy6B4ZlUwFozDDhkUDODAP7Q4lqRh7DchbSQfZh7f1uxjaXYqaicSiYvbyJ4J47Cnngu6MrkCh4vjtWsiHopD6/poYNFKat49qdMWo9kCgVVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489267; c=relaxed/simple;
	bh=+FBQzf0xmmSKeU1h+T+AcA5mbgSmzh11qou+Sq7tZG0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=O+JdyqS0NpceubRV9bpHD+IS6W11ocnUs3h4o7xzNO5naE7M7m4caDGOxedxYmiQ13H+QG8NEzMvSGUUhE7dOfemJK0fJlypEiBwJUq6SDXam/tsEsl9k95YGKCqXZmVXaeN6C+ZpDS+oK9Ocp+Rz4M2orgxnoi9kcYXgRU9JQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jizZdnBI; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714489264; x=1746025264;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+FBQzf0xmmSKeU1h+T+AcA5mbgSmzh11qou+Sq7tZG0=;
  b=jizZdnBIAkHQ2ZTDR5A0lml0gP6kpg4f3+Es0fX90IUSS2iGWOwQ+QhL
   LFRhmvDKYE6rX6g1oyxLUxPcgS4KrMbONlvEpVvqZ6g8lz9lwEMANf1so
   4J1fkLp30wGDxEKQ/HNFNy8La7aHogn8EMFNuh/JiHYrd6Kti6h8kl99F
   RTcvDD99uoG+hLi1plrnbJGIa3IoRHqSPMlMBIVmRN6rdexHc3O/qJO2O
   UmHkd1q7GP/4U/ORSCM0X/2spdWlv+ZH0aoKK3u6tjPbpjlyUWGyrkQYA
   ksI5YsT240kCZF8vswp3L8uViltR47asisBYvk7Cqi8RNXQUXQjHlX/AK
   A==;
X-CSE-ConnectionGUID: qxserFZ2RNe8TrP0yiYmDg==
X-CSE-MsgGUID: k1AAzbPVSIeB7zLQs02ZgQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="20814703"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="20814703"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 08:01:04 -0700
X-CSE-ConnectionGUID: m1BAUofIT1uCYCWc5p9zFg==
X-CSE-MsgGUID: R6fedMXSQfuAVMs+/3ywjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26498936"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 08:01:04 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 08:01:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 08:01:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 08:01:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mzqy9kQxN2PJRGewiHektTXOPsshbIpHvChtymugNplgc1DBBFCySLz0spDL5acKKMqBhWhesdLWyZFBn5Q8EnbKd8kHXfxAWnFJSEY69i5XgzMSAwmYRqbcfIYZxjRdCzQ2tkyy9SEpjH6Y5ebO7yGbd0J9Bp0su1CXGvdeUA9klEbnbPu+KKBDP+s6tChBmkbbYx/R4mXWLnjS54PlI1eACi7HJSDfcSi2V+v0V9qXNoLUjDmiIDMqgJ6+JxJzfFbmMahgHrYUXBuE5xugxL6RnRsPf+wWLRUJRA03853F7UJU+s3WLQG2vRUQYM3PQXDPAqenMDFoxLRij4YIfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OB6IkdCLBdy83m3o3jlrriccyOpXqGamDITBzPIHznM=;
 b=VoN7ZAevzESldw0TrQaUqjtjYHJu7UYvHlbrXcoAl3WXI0zvfIBCcoVtLn3ZPr5AdBkDGEOleWz62EgcxR0cmSJX2vnglgXAY5diKuFEwEYrHcOf4T4+1QyXFihhBGNbcOyGYjn4I/wNJjrSZQZ3Ggvb9Ml7WY4EKostzODqtJF5wA6PfzXgecInP+pus2z9AsZd543eWl+DNW5WFLR7wnZadQZ9vkcd5hJdi+FQuU4Lu2GrlxNyxLrZ+cUMIDx1y8ls0jhGeTPz+aKNKSSXshYt3zquhxCnCrZkeJw57Ccd8NPCtKasyPvIXKN5Xa0vEozAWSKC6GBF6aIoOZmihw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB5108.namprd11.prod.outlook.com (2603:10b6:303:92::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 15:01:00 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 15:01:00 +0000
Date: Tue, 30 Apr 2024 23:00:52 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Ingo Molnar <mingo@kernel.org>, Srikanth Aithal
	<sraithal@amd.com>, <oliver.sang@intel.com>
Subject: [tip:x86/alternatives] [x86/alternatives] ee8962082a:
 WARNING:at_arch/x86/kernel/cpu/cpuid-deps.c:#do_clear_cpu_cap
Message-ID: <202404302233.f27f91b2-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a2b81a8-17db-4b69-4e85-08dc692658fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v/vCH0VihrL01V6/T1euSn0hVLe/yxOMpNFh9KyzBEB/rK4RCBADpRcLJWMh?=
 =?us-ascii?Q?MMeBEq7K9iyxq1BgLMuX9PAKGDlLQh/H2kiSM3Y4xFqTiE5NcprjEKAh0wS9?=
 =?us-ascii?Q?WdLHywP/eIfCEXl1jtMoIb82oMKNuCKIT7dI6uIhLokgnk+C2f8Q9TRf/463?=
 =?us-ascii?Q?aYNbWNChQKIaYHuJ+1KwNxC74vHYHNULp7/NJo42/YSILk1UJ2iyXTTpCfhR?=
 =?us-ascii?Q?gKvuukfXyoHl9i0KtazPKHXoWlK/OnVk3E8sZRDqjRNCgmYtDMKLqoANrtMV?=
 =?us-ascii?Q?8Cvh2PFffJoksIHXyRqJs1rdg1VbQugbtGRSphl4bfaUN5atkeZis/nsQzTP?=
 =?us-ascii?Q?dpQRJe01wl7HFtWmgCs6QtqLzS+cy8p2CY2C89SsiWt2vvWoF4WiYWY6K5Rp?=
 =?us-ascii?Q?NdWbOINEjognN31rkC3sNPTtpc6tUGOnTAlg/BdCzzc7y+TiNLaWP9XWY7uC?=
 =?us-ascii?Q?F74e4I/345wz/5PBlqheDVqvKM1ea2iQCeBmr9NZoZl76z0gcldpIDa5mBRL?=
 =?us-ascii?Q?B08OZ+aG9zGO/+MbOb5h2y94ZfDTfcj08M3fhUwankMKabYtJ+Tw4YShzaDv?=
 =?us-ascii?Q?Nr1FmoTGhX8+ofSMbBq1lgmP4CPs+P+dLOkyuZYn39hhZxz65djaewCgyeKK?=
 =?us-ascii?Q?MGmHUL3vzCmwSqT9VBvNYUuE4x0bgNcv1RYgye7ldZ145Y1h1qH7Qlo+3OG4?=
 =?us-ascii?Q?t/T6eOSwcilwzYqyDXeGpXKlWHClqHQBp4YH6KDz9dJuMHJ0OaSDpJBZjbH4?=
 =?us-ascii?Q?/1mdOoZKYTlBtq4R2AW55nEOOhQBR/DPnpd2njwyYGCFIeJxqorMhxZEOpEW?=
 =?us-ascii?Q?6BSLZZtAtoQDeJt884OaY3SqDPreud9IBJObOrOKEaCSikXDZMiPEZ3FTSRj?=
 =?us-ascii?Q?Byppk/a3Araau9zAdmH4JcoqjwhqebE182V3HIe0ARd6AapO6pJ00XZIPkJK?=
 =?us-ascii?Q?H+QpwI4scPIoPsJHL67lUJtD7yPbGMj1Wgy3x8NcIEAtWArQDEvPgViNlNy0?=
 =?us-ascii?Q?kx7QQXqb2SgAIDGmiYE6hisSxOaqAmk6lvsN8tDhitARIVAERXsxbCOIUfbb?=
 =?us-ascii?Q?z/2H0tPZY+/EhCNlL/B1/uWiKwy55fGdwpYvVPLTSJGv/CIBL3epvPs6T+3P?=
 =?us-ascii?Q?22BdnfdCfJVGUhnTNZBFkEZXvvH0iNN5x2sUKh7+8lUThhWFh7EcaiaVMJMR?=
 =?us-ascii?Q?WOHex1jsURz98JLT5CUD5wQLTpQbb2g5FPnRmKE76lUV9L/fCAZ4zJ9E7Ho?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QLKcg/M034iVbjJJETBVvGoe6vjciaooaXOYbhnJ8Epb8eoAZhqK+ZABLmAI?=
 =?us-ascii?Q?OZ5Gy495BdovUkkXw4jRQZso+hxUC6rmmlBmSJlyQtTwl4nx8DpvJbl4Tp2h?=
 =?us-ascii?Q?fI2D7dLWbIYDML6+uo/uILj9vwQMFQKVEZYMRqFxS6KpjBHRq74x6Qv+LGbL?=
 =?us-ascii?Q?nTAGhDNGLw2z7nsAu3HcL0RHg1b7n4mri/DQO7bKPzRmZ9tyyLEH1L9SyAZH?=
 =?us-ascii?Q?hE2XHm7W7ewN1v5I8uI+s+ti9O0auNktr5L+LsjwfLlOug1Es5tIBeGMyfRT?=
 =?us-ascii?Q?tcR+tvlSG9TeQRbQYH+D6dR3pfccgQz1F7bOv5qKZsMdd7xuxItMVlhNNRcr?=
 =?us-ascii?Q?/FEmh0CefARwxWZNNXHAxYYOMjES/jqAPDyZa7RXl7F9VhsCCqlwi3feHIl/?=
 =?us-ascii?Q?fwZW7WIwBPwK1MedsPwvFwwnsnbc2LiyvL5n1XRuOtQY+rXUXILITRsvqqDX?=
 =?us-ascii?Q?+ObNSSFnByqXXtzTkge8aa0t+2MWN3Hz7JfkDZN8BtWGFHJ4ESA9ZEhwT8mZ?=
 =?us-ascii?Q?EKgMSKF4zSY3SWJ/qmm8twRm65ddeWZD+x9TcYt2A1jPlWlozVCZL4t7mo0i?=
 =?us-ascii?Q?XYupL58yANsKRA7tGqkZgL6S8cO4hP5cWdTj1wgLOvy2LlgkF8ftq9BNA+go?=
 =?us-ascii?Q?Mn3ydLHu3A/Ru+SLfemoiIKbSmG8UedWyQcwXzi8YYGX64EQaVxS1LS/bhNv?=
 =?us-ascii?Q?Kawel++4ZG+R3mjlWv4cSxyQ5USuvFHkchzpdBtr8WGp26i2QRyYnclz415C?=
 =?us-ascii?Q?aEnCwcySJtweJykFo6bdxQLQveVR7+ObVSajSbEC2Be7knuv3+Yn6uEc0QTG?=
 =?us-ascii?Q?y4MvkejkQ0zSK/zCWmBD5Med/SmJAG8Gi51eKM/CSXU4HWluL6gWp47cwyc7?=
 =?us-ascii?Q?kBPYyEdzfaKS6s6SrWGVizZHwQqVQs3hY/c52lj+pB1SwAl//JGGla65oAUe?=
 =?us-ascii?Q?fE2/cD4rtWRu6yf3aV1olwL9F09OdzaYb6hzrSDsJbIdSI83CrLV0S0CeA3V?=
 =?us-ascii?Q?j7mavxtp4uTk9MBk78FHOBE7hlc7jlMfwmlkMS93pNTZIN0bIyZx3qTUDWpi?=
 =?us-ascii?Q?Z4LXAhf4849L8q5nxYrNC48AGxwieS/rPd0eAtWqflY+3/nWjgnaOAwyNKzv?=
 =?us-ascii?Q?orIkHkqBwKN2oGmF4AuF/JpfDK9iiGfxkNRi44aydckM8a/TWO9bT1RY2/AD?=
 =?us-ascii?Q?Bdmme8KFQCq6Kaj2UBYCkiLyqsxf5r8hYcgqoc/bklutCpmMWiFl6LNh1M9j?=
 =?us-ascii?Q?ir18VYHS1uUSTWkef73rZ1AHhB0U+MUHkcRgh+vfZIYkSCI+HuptibJz4qg4?=
 =?us-ascii?Q?pnJvHDHZCqlIvtSYRrbbr+8xCo8LOpcA2ThkV44hIKsZ2SDZLAWhvijVNrl2?=
 =?us-ascii?Q?LTXHp5zPBjYJvZnopgroZov6oSVnq/0A2zxw3+lOZApNagX/X9sYa2W8Z+Jl?=
 =?us-ascii?Q?am6QOHIf2zQzgXqnta1W4BM6Ds2wKbSr+nBtrl4NTNaBnHblPE5BygklG8MP?=
 =?us-ascii?Q?Ik9QOGXUlCjNXkvP6f9NmxPawN5eVpE2Jqk9DQbin4/D+eF/F2mUzKLvDcLH?=
 =?us-ascii?Q?QU6qO8iDffk8/w4bTcpFBGEsvMqDILEyAI52lMmjT7EaQoZQbnXRC6FusSkG?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2b81a8-17db-4b69-4e85-08dc692658fb
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 15:01:00.5952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 34d3BR+92jOvY6zJGWdWybN/3qEz8eZUlO/83NOxxaUiZO5gtVfCfGdZYHpKUBDnRn0Po56m+abYWElWmx+4kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5108
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_arch/x86/kernel/cpu/cpuid-deps.c:#do_clear_cpu_cap" on:

commit: ee8962082a4413dba1a1b3d3d23490c5221f3b8a ("x86/alternatives: Catch late X86_FEATURE modifiers")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/alternatives

[test failed on linux-next/master bb7a2467e6beef44a80a17d45ebf2931e7631083]

in testcase: lkvs
version: lkvs-x86_64-b07d44a-1_20240401
with following parameters:

	test: xsave



compiler: gcc-13
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404302233.f27f91b2-oliver.sang@intel.com


[    0.055225][    T0] ------------[ cut here ]------------
[ 0.055225][ T0] WARNING: CPU: 1 PID: 0 at arch/x86/kernel/cpu/cpuid-deps.c:118 do_clear_cpu_cap (arch/x86/kernel/cpu/cpuid-deps.c:118 (discriminator 1)) 
[    0.055225][    T0] Modules linked in:
[    0.055225][    T0] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.9.0-rc3-00001-gee8962082a44 #1
[    0.055225][    T0] Hardware name: Gigabyte Technology Co., Ltd. X299 UD4 Pro/X299 UD4 Pro-CF, BIOS F8a 04/27/2021
[ 0.055225][ T0] RIP: 0010:do_clear_cpu_cap (arch/x86/kernel/cpu/cpuid-deps.c:118 (discriminator 1)) 
[ 0.055225][ T0] Code: 89 c1 83 e0 07 48 c1 e9 03 83 c0 03 0f b6 14 11 38 d0 7c 08 84 d2 0f 85 b7 00 00 00 8b 15 f4 f7 7c 04 85 d2 0f 84 f2 fd ff ff <0f> 0b e9 eb fd ff ff 48 c7 c7 c0 eb 89 85 e8 41 fd ff ff 49 8d bf
All code
========
   0:	89 c1                	mov    %eax,%ecx
   2:	83 e0 07             	and    $0x7,%eax
   5:	48 c1 e9 03          	shr    $0x3,%rcx
   9:	83 c0 03             	add    $0x3,%eax
   c:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
  10:	38 d0                	cmp    %dl,%al
  12:	7c 08                	jl     0x1c
  14:	84 d2                	test   %dl,%dl
  16:	0f 85 b7 00 00 00    	jne    0xd3
  1c:	8b 15 f4 f7 7c 04    	mov    0x47cf7f4(%rip),%edx        # 0x47cf816
  22:	85 d2                	test   %edx,%edx
  24:	0f 84 f2 fd ff ff    	je     0xfffffffffffffe1c
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	e9 eb fd ff ff       	jmpq   0xfffffffffffffe1c
  31:	48 c7 c7 c0 eb 89 85 	mov    $0xffffffff8589ebc0,%rdi
  38:	e8 41 fd ff ff       	callq  0xfffffffffffffd7e
  3d:	49                   	rex.WB
  3e:	8d                   	.byte 0x8d
  3f:	bf                   	.byte 0xbf

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	e9 eb fd ff ff       	jmpq   0xfffffffffffffdf2
   7:	48 c7 c7 c0 eb 89 85 	mov    $0xffffffff8589ebc0,%rdi
   e:	e8 41 fd ff ff       	callq  0xfffffffffffffd54
  13:	49                   	rex.WB
  14:	8d                   	.byte 0x8d
  15:	bf                   	.byte 0xbf
[    0.055225][    T0] RSP: 0000:ffffc900001f7cd0 EFLAGS: 00010002
[    0.055225][    T0] RAX: 0000000000000003 RBX: ffff888817ca9020 RCX: 1ffffffff0b13da3
[    0.055225][    T0] RDX: 0000000000000001 RSI: 0000000000000085 RDI: ffffc900001f7d68
[    0.055225][    T0] RBP: ffffc900001f7d08 R08: 0000000000000000 R09: fffffbfff0962288
[    0.055225][    T0] R10: ffffffff84b11443 R11: 0000000000000001 R12: 0000000000000085
[    0.055225][    T0] R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff8683dee0
[    0.055225][    T0] FS:  0000000000000000(0000) GS:ffff888817c80000(0000) knlGS:0000000000000000
[    0.055225][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.055225][    T0] CR2: 0000000000000000 CR3: 000000089c85a001 CR4: 00000000003706b0
[    0.055225][    T0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.055225][    T0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.055225][    T0] Call Trace:
[    0.055225][    T0]  <TASK>
[ 0.055225][ T0] ? __warn (kernel/panic.c:694) 
[ 0.055225][ T0] ? do_clear_cpu_cap (arch/x86/kernel/cpu/cpuid-deps.c:118 (discriminator 1)) 
[ 0.055225][ T0] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 0.055225][ T0] ? handle_bug (arch/x86/kernel/traps.c:239 (discriminator 1)) 
[ 0.055225][ T0] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
[ 0.055225][ T0] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 0.055225][ T0] ? do_clear_cpu_cap (arch/x86/kernel/cpu/cpuid-deps.c:118 (discriminator 1)) 
[ 0.055225][ T0] ? __pfx_do_clear_cpu_cap (arch/x86/kernel/cpu/cpuid-deps.c:109) 
[ 0.055225][ T0] init_ia32_feat_ctl (arch/x86/kernel/cpu/feat_ctl.c:181) 
[ 0.055225][ T0] init_intel (arch/x86/include/asm/msr.h:146 arch/x86/include/asm/msr.h:300 arch/x86/kernel/cpu/intel.c:583 arch/x86/kernel/cpu/intel.c:687) 
[ 0.055225][ T0] identify_cpu (arch/x86/kernel/cpu/common.c:1824) 
[ 0.055225][ T0] identify_secondary_cpu (arch/x86/kernel/cpu/common.c:1949) 
[ 0.055225][ T0] smp_store_cpu_info (arch/x86/kernel/smpboot.c:333) 
[ 0.055225][ T0] start_secondary (arch/x86/kernel/smpboot.c:197 arch/x86/kernel/smpboot.c:281) 
[ 0.055225][ T0] ? __pfx_start_secondary (arch/x86/kernel/smpboot.c:231) 
[ 0.055225][ T0] common_startup_64 (arch/x86/kernel/head_64.S:421) 
[    0.055225][    T0]  </TASK>
[    0.055225][    T0] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240430/202404302233.f27f91b2-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


