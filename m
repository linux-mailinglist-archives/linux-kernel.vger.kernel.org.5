Return-Path: <linux-kernel+bounces-149057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D494D8A8B33
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02DFB1C23D51
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4797F51B;
	Wed, 17 Apr 2024 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YRuOqbkh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAEF8820
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713378914; cv=fail; b=QyNhWm7PU7wvtwiamN9r+7IcOVj1gOWGZWfpMq5TB6Ij/gXfInuaQxK6F+tXx9y3nyb4QCkbzCO3hcR5IgNrCnbQj0/pal0bEOV/33Fs7PqdMa/2sYi26Y5bp/EpoQcfGUfR1Ulkp/gGCe1n6OP3JgYayyhS2M+CPYIZMq2niLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713378914; c=relaxed/simple;
	bh=YCCOyNDI4hRlhNs/ae4465aX3mfJFtNgRDFQEuKGhlY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lleZdXX1+y/wr20r6hGpmGhcBnbQR+WSiyuzM4RKrvBjYZRu56WZXckz4MwaSIA+VyJ827NLF54f3F3tANreXBuVPUbobkMabWf8hbH/2gugC9siqSV8Igy/QLc0z9SCCBg6bsAap4qvEmpj5moawr2PZLixEBoGUXoMKF4y4R8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YRuOqbkh; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713378913; x=1744914913;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YCCOyNDI4hRlhNs/ae4465aX3mfJFtNgRDFQEuKGhlY=;
  b=YRuOqbkhZs/tBBURHdCJ/pYQF2aSIuAz5OXD6Zcl2xlqLgUI946bqmXg
   s+NAT9r8RLjzUkyFxkz0acWs9FDs7QfpYa74vhpszgodHmwKLhUyyRrSF
   pKB3sdcsiIjlHJst7VtW3qq2ESX3PBKmV0MPd9/yzRo2A3Kvtld6MolFH
   FusR8Bffh3cqkZOU7NuJ2FHvxFXiwAPk8tUD67gqJ2fbiiELpeuiBnOWq
   HuA/5MVdVEjuZMahjDSkRYmah3E4tPjzl05ABj5brxPnhJ08REbG+2O4J
   4iglnsVeD1M/lbW9omg9l3OhWHQSxEvjHqVQeF71nnZ1fQJTur/ER9rxT
   Q==;
X-CSE-ConnectionGUID: 4j3AKyN0Q1a4Pl6ChKdSiQ==
X-CSE-MsgGUID: /9b8onkJSZ+TndBw0YrXMQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="12670005"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="12670005"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 11:35:12 -0700
X-CSE-ConnectionGUID: dvRUK3z3TWmlDHWH+G5GBQ==
X-CSE-MsgGUID: C6ErGnYwTrWC4ZVhpR6evg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="22788816"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 11:35:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 11:35:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 11:35:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 11:35:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8EPWBG1GWdkfUDiED11MAurZdM8ZyR8mHWTTlFc6fXf/ctTzrpbAPijs6h9NNKrdh00QrSQPG0a8u8/PYDyvRuSZcH0fbZ2R6kVoAzdJS6QNBCfGmYHrAi5TwKQXNBbwTpqdfC3jkk2WGKvQ0KwcmnQabv3/Z8WAWmlVpzqPhS/kQ9P96RYXDNtjb+6XtCGyTEMeq/NB+WyTcv7ztwWLtisc96KqM4orUguImpPGWJafww0Hy1NF3rNfLIOIxnXoWYmeymGyEczN9UXSewXYNw7Neg0xOxd/J/7bpLwccmV/4Et6hiBFEcaEMEBmUD9Eru9oa6miObSBp4NVEhCfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iwSi9+tN82oLXl35HVmDdqS0Ben2LMeiasRBnjvFBM=;
 b=MRGjZCFiEy+JchZMWyv+rWJnSgZCz5gtgIYQsXRE+qcaXOZm4RbBYsA0fC0XZOPjz3mCByw0yFX1PISNVjz8e18IeXtOG1tXPacxzZA/Ylic3UZwxBpGectEKWpKWlvBnpPqc5B/Y0qL/DG//2qgDvZ4T5iecpLRigZy/mcY+SuzClM7aP4sPBcJXyssvu44HYqceyqfIE04X+1urml/xEmt/M1UYGUIvpPca/ehqP/rUWyNSP1ildI+8r4N8dUEVsyMKZCHI4x8j0xG7YZ7zcYUmvGPHMa8CTr8jrpcdmS5L9G+EN27td1/gRUXJIJzkOx2oINM/J7zuvYaQP6pFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH7PR11MB7480.namprd11.prod.outlook.com (2603:10b6:510:268::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.26; Wed, 17 Apr 2024 18:35:07 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f%4]) with mapi id 15.20.7472.025; Wed, 17 Apr 2024
 18:35:07 +0000
Date: Thu, 18 Apr 2024 02:34:53 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Abel Wu <wuyun.abel@bytedance.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, Tim Chen <tim.c.chen@intel.com>, Tiwei Bie
	<tiwei.btw@antgroup.com>, Honglei Wang <wanghonglei@didichuxing.com>, "Aaron
 Lu" <aaron.lu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, Yujie Liu
	<yujie.liu@intel.com>, <linux-kernel@vger.kernel.org>, kernel test robot
	<oliver.sang@intel.com>
Subject: Re: [RFC PATCH] sched/eevdf: Return leftmost entity in pick_eevdf()
 if no eligible entity is found
Message-ID: <ZiAWTU5xb/JMn/Hs@chenyu5-mobl2>
References: <20240226082349.302363-1-yu.c.chen@intel.com>
 <758ebf4e-ee84-414b-99ec-182537bcc168@bytedance.com>
 <20240408115833.GF21904@noisy.programming.kicks-ass.net>
 <ZhPtCyRmPxa0DpMe@chenyu5-mobl2>
 <20240409092104.GA2665@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240409092104.GA2665@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: SG2PR01CA0158.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::14) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH7PR11MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe472d4-1312-414a-515f-08dc5f0d1b38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sFvYvahc8fXbCwenKD34jgLHTFqefFG0IEdJy3lbzSWcVgwTm83gaZp3dH7xtuwpsqVRG7O89rxnd3bnn3cHHbFy0qV8Ehny4JF02VovLuow8wAtKhdeBQ55Pl12qJ0Z/ufdk6GulPoOsEZX/nr30MDKNnabV0mkSS2jYWHIaiKjwltNSjnsc+v84SKx+bg8Ue+IEe+s0Pj8WXMC7ZFSv+nmOYoOBCQi662KjI9V90KLQvxiDsqkbfa6N802rF0RYd9j1UzlYZnG45GhDPamAKelFi2b8hb6vyfy2Xsmos9tBQFI5zjwqdY3yqKK1O31sfY7fxcJC1YAci6JmKhCfrbAAeUzS1piaetWfDF30tnOnpTypa/Jmg9uToaq9nFiLjQwEs4R1WkSfM7IPHYvJrmUjfW3TlfpWF0APGWdkKyGQMW02V+lt1tWcQwitmGg1aA+AQNuSShSAvOllU4bkxh4SVG8AJqrx3x045xfkVh8AAaTNCSmsyEF3+Wizwerem4KL8VtWDkAvYyakT88EnBft66CbpFeNIehZGfShWiRTx1HTUQezJoIQwxi7WTsqB2ydCQoirqpk4a2lj59Hoxhgl1I8z97VxyZDy2OoZeWpNUA0U7NJU+TQbX3B4miZxrIV8ql7cUemt8QakzoJFLvO4RQv0aqwK9zaFnd0FI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4gOTWPCOAfuv0Kt7+8t1KJIq8zVHL5pQVPur9EbeB30aiexVAI9jEhWYnfIP?=
 =?us-ascii?Q?SlXCEjAWfqODXo5IA2VU2M0aj7DduFMJIqKreqM/CuTQe/AVxPKQo41mDd3T?=
 =?us-ascii?Q?fLugRX5i2SEOEBsxcXVuB3TRkG8+5Eo+QnrgHsRcBzcLA2nH27IhvzNVmQTp?=
 =?us-ascii?Q?hzyZeOqm+cpwM7/xduQzfnt1rfISOlZEZUxslfEqG7o9wcee408lz94Hb+UX?=
 =?us-ascii?Q?v20duCWRlpxFMUYdSxql/xGTHAz/083vJWHSSGAXcDJqISm8qsLcDf+ULcpz?=
 =?us-ascii?Q?ze/gXgO9fxtOnhpTOq2TtsEikKA4INOOpVCP3bf/PEXvCsM+41sdYgDp6yp5?=
 =?us-ascii?Q?HONzebUnlRBK/4orH4/FlfoT+cj9FhftCxnFG6CUf6zRTFifd5RnS74iy9y8?=
 =?us-ascii?Q?5Dsi/NMV5oN6ZKWE35EAYT76OnTcANQNm9La8NdPU0VtwCin3RM4+krVoN8Z?=
 =?us-ascii?Q?VCpry1hXuQSWubMQgU1nO2EjKwDhbIdIDrfoiQmEFfFTqRfBXwjmVGlWcWVA?=
 =?us-ascii?Q?Ykm0BcLVwNKhRo5en/uwxcb/RzTH03xdElmRwLtLZJ7/HzI1IPpYli85mrPg?=
 =?us-ascii?Q?ytwM5zkT2Mb32kl4VYqewRj7pgJ+nqLQV9kFI6xfroLkx7xhS/LYdxLhl16K?=
 =?us-ascii?Q?wdCiT7LKovwoXmtT+vn8KKXcHyA/sSlDjxOTldrSQ5wAJxfRn5WOM5XskXyD?=
 =?us-ascii?Q?pZHdDlUTLcFbtY+0VsmFtk8iscKz1bOa5kvk73vk1CFtUNY8ri558dOc37Em?=
 =?us-ascii?Q?rmFUq3dHsWRo83JkO4gOLa96V+XsLkoxsFVpYPlGy10bh6UK7klsgzqh8NoS?=
 =?us-ascii?Q?KQDqHu8a7UxOdpE0N4sBeuk37mXel4rT0NBWqs9EPndjwcoJguhAbwyNBwIx?=
 =?us-ascii?Q?KMq8019j2SsSCtvoX4UrXKRaQRwBcVxhO46D7CkkijY4OEtgzBlY6AHwxKHn?=
 =?us-ascii?Q?hAH6KdA/tWblZmG8TQJ5k5pAkF0/9m08RCq7Qu0DJbBhrp/OR8MXHPjYkQeR?=
 =?us-ascii?Q?7J1ePP+yKn+yBDDmkpfmaYtpomacjQwdBbIB6a/t+OpWbSOTK4ExmD1WtC6Y?=
 =?us-ascii?Q?RdWNesn2279ouIoqds+gDx3U/mX6htvbRQpZrgxitVe3ujCLRo/xmKKmb6U0?=
 =?us-ascii?Q?mu8mIYR7Y91IDOg18UEA5wzRiUTql86hXEHFNvymJbaieKupHxeOGLcI0LSz?=
 =?us-ascii?Q?c+qPr1TEmebeHOdLdLp7pldKniQGPqujHP161cU4zNbsP+I2c3PNzdDjfMDf?=
 =?us-ascii?Q?No2nJIEPbHXd+q9kClsmfisBSV1QJEpQS1ck+7XkmOO3Y4qdpIbBda88BKYE?=
 =?us-ascii?Q?mcMSgHt8SwR91rkGw0ONkKMpA6qpfiX+zlDrCksLlEB8xk7JGgqwF+NxOcy9?=
 =?us-ascii?Q?0mt5D9p+ICyPgkm/KQF1vXFaWNpLowWaUldxa9EWPuQlgVY4RoIRYg21WO7a?=
 =?us-ascii?Q?wUomwu3GUMIRpGCvkwamBuItF9G5xL9n0KQABxXewSB2c7wPqPje44oezz4u?=
 =?us-ascii?Q?GaUzM7uv82d8jnpzUKENh+1Vj/lmExyC2GI+YYhHUW5TTP3MbLE9ZWMda+/j?=
 =?us-ascii?Q?Id/AQdvbbUlIs2a2jn0zY2Xm0tQiB5CqOZkNgF6D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe472d4-1312-414a-515f-08dc5f0d1b38
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 18:35:07.8559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjAA0Lgr+ndWvKn36bdnbHC4FgzG71lHCAb7JMtV21C6YZws+6AihfVey3kFHdZwdtBhTHQNSjjv4jnP92lKJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7480
X-OriginatorOrg: intel.com

On 2024-04-09 at 11:21:04 +0200, Peter Zijlstra wrote:
> On Mon, Apr 08, 2024 at 09:11:39PM +0800, Chen Yu wrote:
> > On 2024-04-08 at 13:58:33 +0200, Peter Zijlstra wrote:
> > > On Thu, Feb 29, 2024 at 05:00:18PM +0800, Abel Wu wrote:
> > > 
> > > > > According to the log, vruntime is 18435852013561943404, the
> > > > > cfs_rq->min_vruntime is 763383370431, the load is 629 + 2048 = 2677,
> > > > > thus:
> > > > > s64 delta = (s64)(18435852013561943404 - 763383370431) = -10892823530978643
> > > > >      delta * 2677 = 7733399554989275921
> > > > > that is to say, the multiply result overflow the s64, which turns the
> > > > > negative value into a positive value, thus eligible check fails.
> > > > 
> > > > Indeed.
> > > 
> > > From the data presented it looks like min_vruntime is wrong and needs
> > > update. If you can readily reproduce this, dump the vruntime of all
> > > tasks on the runqueue and see if min_vruntime is indeed correct.
> > >
> > 
> > This was the dump of all the entities on the tree, from left to right,
> 
> Oh, my bad, I thought it was the pick path.
> 
> > and also from top down in middle order traverse, when this issue happens:
> > 
> > [  514.461242][ T8390] cfs_rq avg_vruntime:386638640128 avg_load:2048 cfs_rq->min_vruntime:763383370431
> > [  514.535935][ T8390] current on_rq se 0xc5851400, deadline:18435852013562231446
> > 			min_vruntime:18437121115753667698 vruntime:18435852013561943404, load:629
> > 
> > 
> > [  514.536772][ T8390] Traverse rb-tree from left to right
> > [  514.537138][ T8390]  se 0xec1234e0 deadline:763384870431 min_vruntime:763383370431 vruntime:763383370431 non-eligible  <-- leftmost se
> > [  514.537835][ T8390]  se 0xec4fcf20 deadline:763762447228 min_vruntime:763760947228 vruntime:763760947228 non-eligible
> > 
> > [  514.538539][ T8390] Traverse rb-tree from topdown
> > [  514.538877][ T8390]  middle se 0xec1234e0 deadline:763384870431 min_vruntime:763383370431 vruntime:763383370431 non-eligible   <-- root se
> > [  514.539605][ T8390]  middle se 0xec4fcf20 deadline:763762447228 min_vruntime:763760947228 vruntime:763760947228 non-eligible
> > 
> > The tree looks like:
> > 
> >           se (0xec1234e0)
> >                   |
> >                   |
> >                   ----> se (0xec4fcf20)
> > 
> > 
> > The root se 0xec1234e0 is also the leftmost se, its min_vruntime and
> > vruntime are both 763383370431, which is aligned with
> > cfs_rq->min_vruntime. It seems that the cfs_rq's min_vruntime gets
> > updated correctly, because it is monotonic increasing.
> 
> Right.
> 
> > My guess is that, for some reason, one newly forked se in a newly
> > created task group, in the rb-tree has not been picked for a long
> > time(maybe not eligible). Its vruntime stopped at the negative
> > value(near (unsigned long)(-(1LL << 20)) for a long time, its vruntime
> > is long behind the cfs_rq->vruntime, thus the overflow happens.
> 
> I'll have to do the math again, but that's something in the order of not
> picking a task in about a day, that would be 'bad' :-)
> 
> Is there any sane way to reproduce this, and how often does it happen?

After adding some ftrace in place_entity() and pick_eevdf(), with the
help from Yujie in lkp, the issue was reproduced today. The reason why se's vruntime
is very small seems to be related to task group's reweight_entity():

vlag = (s64)(avruntime - se->vruntime);                             
vlag = div_s64(vlag * old_weight, weight);
se->vruntime = avruntime - vlag;

The vlag above is not limited by neither 2*se->slice nor TICK_NSEC,
if the new weight is very small, which is very likely, then the vlag
could be very large, results in a very small vruntime.


The followings are the details why I think above could bring problems:

Here is the debug log printed by place_entity():


[  397.597268]cfs_rq:0xe75f7100
              cfs_rq.avg_vruntime:-1111846207333767
              cfs_rq.min_vruntime:810640668779
              avg_vruntime():686982466017
              curr(0xc59f4f20 rb_producer weight:15 vruntime:1447773196654 sum_exec_ns:187707021870 ctx(0 73)
              leftmost(0xeacb6e00 vruntime:332464705486 sum_exec_ns:78776125437 load:677)
..

[  397.877251]cfs_rq:0xe75f7100
              cfs_rq.avg_vruntime:-759390883821798
              cfs_rq.min_vruntime:810640668779
              avg_vruntime(): 689577229374
              curr(0xc59f4f20 rb_producer weight:15 vruntime:1453640907998 sum_ns:187792974673 ctx(0 73)
              leftmost(0xeacb6e00 vruntime:-59752941080010 sum_ns:78776125437 load:4)


The leftmost se is a task group, its vruntime reduces from 332464705486 to
-59752941080010, because its load reduced from 677 to 4 due to update_cfs_group()
on the tree entities.

Back to reweight_entity():
vlag = avruntime - se->vruntime = 689577229374 - 332464705486 = 357112523888;
vlag = vlag * old_weight / weight = 357112523888 * 677 / 4 = 60441294668044;                      
se->vruntime = avruntime - vlag = -59751717438670;

the new se vruntime -59751717438670 is close to what we printed -59752941080010,
consider that the avg_vruntime() vary.

Then later this leftmost se has changed its load back and forth, and when the load is 2,
the vuntime has reached a dangerous threshold to trigger the s64 overflow in
eligible check:

[  398.011991]cfs_rq:0xe75f7100
              cfs_rq.avg_vruntime:-11875977385353427
              cfs_rq.min_vruntime:810640668779
              cfs_rq.avg_load:96985
              leftmost(0xeacb6e00 vruntime:18446623907344963655 load:2)

vruntime_eligible()
{

   key = se.vruntime - cfs_rq.min_vruntime = -120977005256740;
   key * avg_load overflow s64...
}

As a result the leftmost one can not be picked, and NULL is returned.

One workaround patch I'm thinking of, if this analysis is in the
right direction, maybe I can have a test later:

thanks,
Chenyu

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6e0968fb9ba8..7ab26cdc3487 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3965,8 +3965,13 @@ static void reweight_eevdf(struct cfs_rq *cfs_rq, struct sched_entity *se,
 	 *	   = V  - vl'
 	 */
 	if (avruntime != se->vruntime) {
+		s64 limit;
+
 		vlag = (s64)(avruntime - se->vruntime);
 		vlag = div_s64(vlag * old_weight, weight);
+		/* TBD: using old weight or new weight? */
+		limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
+		vlag = clamp(lag, -limit, limit);
 		se->vruntime = avruntime - vlag;
 	}
 
-- 
2.25.1



