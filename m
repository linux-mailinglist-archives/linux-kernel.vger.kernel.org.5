Return-Path: <linux-kernel+bounces-29116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 968EC8308EF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CDDA1F25C36
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6B6210ED;
	Wed, 17 Jan 2024 14:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L2jwe8TL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DBE2030D;
	Wed, 17 Jan 2024 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705503578; cv=fail; b=sEKdl806iOPeuLwhx5em+b3KUmwaEn8bvH2y3qvG3G3UOD/++G33i8kuzvYoe3HO2NAePtING85BypRXcp3l+qji31lYp3UZLan0thjBwIhf2T+70fC+VAZTRu2eXhw0Z9zUeFGb6nGMeCojqqanUzp31rpg9nbEv/ozixpdLuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705503578; c=relaxed/simple;
	bh=qOp11E9AQxrlmwc2f71szfIIxbZ/7s+6VKmfhZ3bei8=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:Received:
	 Received:Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=WVIy/uYvzBA4AOTkK4UMUNRbCFY7/m7dGAddvQ5/d4A9X9xX1YStILiapWd2EnI7V8359Qs01LaZMhKZEHfVY0OHibZn9SAyJ47nfLmk+v/umqnlhHa6zdpVyfTh1UAKDBeEztpJ1NcyZILn6dmfYhPcu7C5FykVxrQz7y+dUp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L2jwe8TL; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705503577; x=1737039577;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qOp11E9AQxrlmwc2f71szfIIxbZ/7s+6VKmfhZ3bei8=;
  b=L2jwe8TL2O4eBIHgTM56Hve0MMI6cGY4X9GCq3qbx3XwpLIJmBWABSg3
   MKPCN6VUh8DLsNzIu1DHxztDAyULMMA1oSXRO/yxTsaEDpTL11bS5LNl6
   pEvq02CC1zers0uuc032okGqbDVFWRWPkyTSexklvgLS3/asZXuPTrsqo
   1olmlBJb+zimPoXaeeku4XE9q2wyDe3qgauZQcuT4uff+TFzsxI7JOXJo
   r2CeuHMXqW1BevP3y7JF6X+Spwio0lb/++HbfN7iqkIw4XIqeyqLG0YnD
   aMEM42oTuOFVO7Opu/8BrtRJuvvG501GW8AVhS/ji6jaKZN+63bCunNuM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="18775878"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="18775878"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 06:59:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="854717620"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="854717620"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2024 06:59:35 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 06:59:34 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 06:59:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jan 2024 06:59:32 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 06:59:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ojh1qjroJbZeJnwX9mR86V8aAUUkwBny/WLHEw9Ihn/oWpFUEu9jtOvNG6HRiktmoEjzLeqXvLU78nSa/zvVTl2l2AK4OZfnv68vJ0ZQ+NWJJL+DGVW1aveayaQxu6czTk/xm+dstdrc8WOGRioMzX2iYeNmcmyT/jZF1aVFSNw+jEeL0LoMMrccHvonS43hbia2gNETjKMl3TpWoX5tKlYgblLchTDarg1ELyjjRMH/UwynzkwmFxdqx0CZrBaLDXWg8m50i5GBJPMgbbw+Ru63Zj/FEaxPcpehg+C57pQx8PW/mip532o9j9ndI+XDlYwsizaFYsvRWknSGWpxCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqwaDby7Fh1yc0Lo/PWPBIXf/ylYhBRLuBvPbNg7opg=;
 b=kYHR3JgE54spvXdur97C55ExOKDqAAFLyLLq2mVCVMjOKjusU05bJuSawotgc8a2xMAw48INVyuo3+P2RhdzQFkj1zoFsdomthhGrkVwM1XuChmOBQ9gso5TONCwi00KuUfMUw3AvZSR7urizKC3mHdLdfCo87adqCYXrxm/1AFz9UA+/c7ovEuiUS3mI2XBWcYvFaBjFZRtB0d9i+twM6gFrGdSLvPEsT6VZFC4zW5roHI0OiNsnvP0xA/nMaC3jHVcw1h6GBq1g2i0ykcRIr1srkeiTsOfyCY/bUaEQFb8dZ1+orlVQVbLtpM+V3G0u+61eK+Aq+vG5A/smkOLig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB7703.namprd11.prod.outlook.com (2603:10b6:a03:4e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.30; Wed, 17 Jan
 2024 14:59:30 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7159.020; Wed, 17 Jan 2024
 14:59:30 +0000
Date: Wed, 17 Jan 2024 22:59:23 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [mhiramat:topic/fprobe-on-fgraph] [function_graph] f2ed0fd5cc:
 WARNING:at_kernel/trace/trace.c:#run_tracer_selftest
Message-ID: <202401172200.c8731564-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: TY2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:404:a6::27) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB7703:EE_
X-MS-Office365-Filtering-Correlation-Id: e7e49e01-c6b3-4e7f-7a8c-08dc176ce850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JKDfDmmN16risys7Y1wW+KHr/0tu5s6+Gh9jVWDCcfAeCETYqbhaBDDEypPRaGZ3HrSJjc5dGmQNV+fSTPWZ5q8NGVHCgHlMJ5r8TU0t5OXbeTZY6cR1yHXZn/eUwonVNvHy0s/cZmy3LMYcY+0V1rocsffZSRl+cxNDXwan0TXOqtqovrk/4cVLaQJb5CfQiasQgG3Kgvm4eTbahr9bx5x2llkkoKWbiqM67GJtdACtjDWnHCoerdVTSy5aVGOHRyi6KY8wnZhp7UmCfSPUrgX56ghqQwyDqdVpRy2ETmL5RWssCaEzTBTFZAvraceRiMemxGHBtWHaBICtUCPmuP6krSSxipoK0cRhD87t6KfMIbdQYZDml0gembYiMKoflTWSdgLoJ6u1rCWOmUupZnWIxt3D1nnALF0iUc67+3Wud0j4KyjZioyipOw00ybcmCCyemETNhiG+OvmiwtCAuAVrcDCpcqQugLnJBXfCjcyWpURl8aBu4wDQabVRWc3NHHx71ivjsH/hSRY0TdyYqjKwPxiOcsXfX1Bbp/seIfpE/8ivvjhm3xFaYnb2+vh3uL38lZcSI/JGd4z1hvxtP83wlQazRF2LinpvhdGX+fTpDVwHkjbcEjkqajcb6WbfYHf4/RELbiYkvack+DccIiNlsGHeaf9oLdDHpc6b2s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(136003)(376002)(230173577357003)(230273577357003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(478600001)(2616005)(107886003)(26005)(1076003)(6666004)(6506007)(6512007)(5660300002)(83380400001)(966005)(2906002)(41300700001)(4326008)(45080400002)(66476007)(66946007)(6486002)(8936002)(8676002)(6916009)(316002)(66556008)(36756003)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nhCENTMI1Gp8GDccpOMLNQzqJiwdQElQAWcY56jBR9Z/VuwTBh3yXgbzYbb5?=
 =?us-ascii?Q?iXx4qEvH0q+YUUWxXuN0v5I/wBudK+320iIEU+LVq6Z7yURIIGth+Opmr/m/?=
 =?us-ascii?Q?5wnEiQXFF3Twek5hBCBoyHZOxFcL+43h+nkc5hKmHKeE4wzjiSSusUMpz9Jl?=
 =?us-ascii?Q?jANtElGOd8vsOTWgJ9QRWkSEUcbCPgVoIvpFzhv9vi5CPRGm88jD5lJeryQZ?=
 =?us-ascii?Q?uze1w83nzhx/J8a1A5XMXm/ZJrNg17g4jUtmFICnpj2LTdXtlhNHRbFNhqUP?=
 =?us-ascii?Q?X3Vb9BP8pnvp0+lYKQFnimJdntuGC8e5q6sxTZFJrKMYWTKBT4tyb0H9K1aH?=
 =?us-ascii?Q?GsyFBwXgjfiNIA9nz0ahrdL0ouIFs9vFjUxfLBK9Wsks0OHyZMtTqyv6nQFT?=
 =?us-ascii?Q?Km3Dcf+q5GUriH38qhKzTy4gp5d96KF0hma5HXsJpglku7l2JQePDOMidy/9?=
 =?us-ascii?Q?179b38hEo3O98PK964CuDW/Jg1DhmR4gQ20zo8AYGayjzx2MNIGsNRUjrzO1?=
 =?us-ascii?Q?koiTZTdTUlgWbdwI7+TRDuUgA+W/5aZzuyGNPkCKwIVIRtiZsYM7TC8yc0V+?=
 =?us-ascii?Q?/9Tx9uk7XGD1Bf9fHalKFVKY68feQsSUzqkmdTzN80OKt5MS2OoGMzpKpggY?=
 =?us-ascii?Q?Wwy9Cw2JQauE7/noTJk+BFgsOeyObZRbdmnOxb/6FUBQGPWQBtI6eN2N2RY0?=
 =?us-ascii?Q?M7SO3vFV5mmitiIIJWyqB4l0MpONeXXn4E1OKM6UOBjrwTVJL7ShT61qLb3N?=
 =?us-ascii?Q?UGGtfQSqb+N+wxqurGL6nmKK6pBRUFrVXWGPqdcO8nQ8wFjSk9bDGDBUjKiv?=
 =?us-ascii?Q?0B0VWz6kVz6AmhZvN4T/WdxKQPQFbPD31Y5nnBpZeRzBybDgKBb6/k8+1jbI?=
 =?us-ascii?Q?T/W6vuqN1aCka7G7myhvXssgFHj644At7rMoZc0edARrqCsf10IVDYeRZXOy?=
 =?us-ascii?Q?W4t30nMctYPwWn2JTFGxyZdkiJeYNJDLgiGn0GU0iJf2Mze2Ls1dOnziS9/h?=
 =?us-ascii?Q?qEOH569btE2VRfNZHAdvVx4XfNQwde2iV7jl7U3ivNvde5gjPlNU3YEjPRL0?=
 =?us-ascii?Q?fli5USqDuRK4dCvLfZ5mbxusf3s2V2hFLZIaeSGKJJHdT3bhN6GOV1pS0bJZ?=
 =?us-ascii?Q?wbOjwIHBjF7qj219j7FJrxuXFJYpaMJr0h+UPxg53Lp+bVmlazpMwkRGlpsW?=
 =?us-ascii?Q?w2b6CHP5lQzeH7cvH3WC60c2CWTvUzWSqsFRKI9FGFhMO1Wc8/7YJLuGfXsR?=
 =?us-ascii?Q?S5bxSI8xpYjpD2cSuWoVfkr5xCCQCuvxtXS0wSDquk+1julKr72v0nLc1H9X?=
 =?us-ascii?Q?fDP1J/B1TAym6h0E7A684dRGTgNv889JTcSGu32ay9UaRw0rXHeY94aT8Zz7?=
 =?us-ascii?Q?kOwGAnif9iV6R/x5S0UNeeIeSH5y7INoU17XVcWYDaBgNWLlmeOfJr49SxUe?=
 =?us-ascii?Q?zZfA0XgyCn4m3J3vx1N3UH1tIJd3MGh/9X/u3kcxzaaCBcPSp9IGHfdqYEMe?=
 =?us-ascii?Q?EOfh3k0bsA+vyd+UVwaeYZa6GndAnK8NE4ZK3i/juSaI+WK411/Ws81U63Vl?=
 =?us-ascii?Q?jx+403qjXvrE0mTaVDogRxntMHHSeyDobcQfsgxHlDwh7vapOfw92BHZz6Kv?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e49e01-c6b3-4e7f-7a8c-08dc176ce850
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 14:59:30.2969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wilYjL7Z5JpQ0o1GfJDtjrj76ZN8fyK2bfhYOiV1scMtojas/WE4dBxsQDB1nYx799tqu9iJe34dYkaqveE/Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7703
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/trace/trace.c:#run_tracer_selftest" on:

commit: f2ed0fd5cc77ca2ad957569c35e76ef08cf93f54 ("function_graph: Add a new entry handler with parent_ip and ftrace_regs")
https://git.kernel.org/cgit/linux/kernel/git/mhiramat/linux.git topic/fprobe-on-fgraph

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------------------+------------+------------+
|                                                      | 2d3653c71e | f2ed0fd5cc |
+------------------------------------------------------+------------+------------+
| WARNING:at_kernel/trace/trace.c:#run_tracer_selftest | 0          | 20         |
| EIP:run_tracer_selftest                              | 0          | 20         |
+------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401172200.c8731564-oliver.sang@intel.com



[    5.535374][    T1] Testing tracer function_graph: .. no entries found ..FAILED!
[    6.645598][    T1] ------------[ cut here ]------------
[    6.646006][    T1] WARNING: CPU: 0 PID: 1 at kernel/trace/trace.c:2045 run_tracer_selftest+0x256/0x26c
[    6.646759][    T1] Modules linked in:
[    6.647062][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                T  6.7.0-rc8-00022-gf2ed0fd5cc77 #1
[    6.647669][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    6.648455][    T1] EIP: run_tracer_selftest+0x256/0x26c
[    6.648871][    T1] Code: 00 00 66 90 8b 15 ec 97 d3 d4 b9 ff ff ff ff a1 28 98 d3 d4 e8 37 68 ff ff e9 26 fe ff ff c7 04 24 90 d6 8c d4 e8 92 68 f6 ff <0f> 0b b8 ff ff ff ff e9 a7 fe ff ff b8 f4 ff ff ff e9 9d fe ff ff
[    6.650343][    T1] EAX: 00000007 EBX: d4e33700 ECX: 00000000 EDX: 00000000
[    6.650884][    T1] ESI: d4e4a8c0 EDI: c101f100 EBP: c138de8c ESP: c138de78
[    6.651422][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010246
[    6.651661][    T1] CR0: 80050033 CR2: ffcb2000 CR3: 14f88000 CR4: 00040690
[    6.652189][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    6.652715][    T1] DR6: fffe0ff0 DR7: 00000400
[    6.653063][    T1] Call Trace:
[    6.653309][    T1]  ? show_regs+0x82/0x90
[    6.653630][    T1]  ? run_tracer_selftest+0x256/0x26c
[    6.654025][    T1]  ? __warn+0x89/0x1bc
[    6.654333][    T1]  ? run_tracer_selftest+0x256/0x26c
[    6.654733][    T1]  ? run_tracer_selftest+0x256/0x26c
[    6.655128][    T1]  ? report_bug+0x1c5/0x23c
[    6.655467][    T1]  ? exc_overflow+0x58/0x58
[    6.655661][    T1]  ? handle_bug+0x28/0x50
[    6.655984][    T1]  ? exc_invalid_op+0x28/0x7c
[    6.656332][    T1]  ? preempt_count_sub+0xc9/0x120
[    6.656706][    T1]  ? preempt_count_add+0x69/0xc8
[    6.657074][    T1]  ? vprintk_emit+0x7a/0x194
[    6.657418][    T1]  ? handle_exception+0x14d/0x14d
[    6.657794][    T1]  ? exc_overflow+0x58/0x58
[    6.658130][    T1]  ? run_tracer_selftest+0x256/0x26c
[    6.658530][    T1]  ? exc_overflow+0x58/0x58
[    6.658865][    T1]  ? run_tracer_selftest+0x256/0x26c
[    6.659262][    T1]  register_tracer+0xe4/0x28c
[    6.659612][    T1]  ? register_trace_event+0xf6/0x180
[    6.659661][    T1]  ? init_graph_tracefs+0x3c/0x3c
[    6.660036][    T1]  init_graph_trace+0x56/0x7c
[    6.660386][    T1]  do_one_initcall+0x70/0x3b8
[    6.660732][    T1]  ? parameq+0x13/0x68
[    6.661039][    T1]  ? parse_args+0x202/0x37c
[    6.661383][    T1]  do_initcalls+0x100/0x228
[    6.661721][    T1]  ? rdinit_setup+0x40/0x40
[    6.662061][    T1]  ? rest_init+0x194/0x194
[    6.662393][    T1]  kernel_init_freeable+0xd3/0x1c4
[    6.662772][    T1]  kernel_init+0x1a/0x1dc
[    6.663096][    T1]  ? schedule_tail+0x60/0x78
[    6.663439][    T1]  ret_from_fork+0x3d/0x48
[    6.663661][    T1]  ? rest_init+0x194/0x194
[    6.663992][    T1]  ret_from_fork_asm+0x12/0x18
[    6.664348][    T1]  entry_INT80_32+0x10d/0x10d
[    6.664702][    T1] irq event stamp: 2172679
[    6.665030][    T1] hardirqs last  enabled at (2172687): [<d3cf0dfe>] console_unlock+0x11a/0x178
[    6.665694][    T1] hardirqs last disabled at (2172694): [<d3cf0de5>] console_unlock+0x101/0x178
[    6.666360][    T1] softirqs last  enabled at (2172316): [<d45fad83>] __do_softirq+0x2f3/0x4b4
[    6.667009][    T1] softirqs last disabled at (2172309): [<d3c17af3>] do_softirq_own_stack+0x37/0x4c
[    6.667661][    T1] ---[ end trace 0000000000000000 ]---



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240117/202401172200.c8731564-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


