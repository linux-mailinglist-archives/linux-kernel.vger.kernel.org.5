Return-Path: <linux-kernel+bounces-133876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0816289AA31
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 498AFB23BB4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 09:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D4B22EF4;
	Sat,  6 Apr 2024 09:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U5dVUWgY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB0F28E22
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 09:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395432; cv=fail; b=BiSojhq2EeozgZRJ6J/xC20Ebc2Aq4jrbhDMZOnvz20CSDHWObHVeCHK+t0bE8uyfdZY2qR6eXWmt75n/xdm/v+gwvgxVL42EQH+78psjb/331ZamyacUr/LUL3oNIUJceTZttiirY0ZkMx7fOkI/9HtaxMwc9ps28VSPy/p4qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395432; c=relaxed/simple;
	bh=uJTeqPMq2zGBgEzB5l3y7hOdVoa/TL4SPNZq0qf7kO8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k1lAT/OUcQ9CvELHOy2DlwST8hP3BPOXn4IC6KWsv9mHCQA2IiWCpE7T0FoFHFALGk7Xw4QLAaPtN/y4a3HnzSqH+SFRX9zimS3G3/xGoJbWsvr2eWWdZTFg0F+FXq025QtVps6GoKO4HirEGOeAdjzpE8ZxubjUPCecByB6pDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U5dVUWgY; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712395431; x=1743931431;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uJTeqPMq2zGBgEzB5l3y7hOdVoa/TL4SPNZq0qf7kO8=;
  b=U5dVUWgYyJxfxo5Z4nIdkIY2XwEYSDQisps1TykmeQdv0faxfcKPK2YP
   28/z/+GVDS7fLhQoFVOpMaRRtYBYikPjinNndH52N5HjvKcIxaevlu+IK
   7GMLuik6VwkcPRz8zDK/KJU7u2nkwykYAHiz11SrBhhChEAZyPNK8BMcC
   l1Kyzvn5BQi9yo/ppznZ4NpDAYvegD3AkXn2oYz16NYFpolmVicxVREuh
   OoguXrNfE80DMZs0ABCUw+l+SLBv34seJ3fjxswCO1HygmbQe9pj72+5V
   ktVEIHUcpkubAIZQn4NH4n3P5xwAOZJnIqzeXR3q55yEgq9Tl+RS4fZPQ
   Q==;
X-CSE-ConnectionGUID: 1kl1QJ50Q/yHyIgIwuURtw==
X-CSE-MsgGUID: n/lsnd+GRsGUZPmRtmajyg==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="11499283"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="11499283"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2024 02:23:50 -0700
X-CSE-ConnectionGUID: NAbM+haTR76ZP0w/k3LHzA==
X-CSE-MsgGUID: S4m/lpmZTtq3WKcFUW6pxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="23879412"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Apr 2024 02:23:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 6 Apr 2024 02:23:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 6 Apr 2024 02:23:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 6 Apr 2024 02:23:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SL7Tw7YF78/P+vqqsFb+2cOJ8qFK3TSI7anfcUuYvjH9UDH9YCR0Zt/j0D51UOgXzsOBLPwRwj0uQojudDX4q/xXzdjqs6MIi8SWSIGnyzzg2lgCmX0oN/WdQTWCe8sstRCpJRnmgSu8F7jUzTIfPs6advfhWpMVjP8SPIzMtXowChhTn+urZ4p5q0ZIUAF0V4aSQyuSrsKrnnzjH0TWWc/8BdIx6WU+3tM0+d+U0ETSMAxKM/dYXV94NMTXjpS09snmmV9cqJh4kaExJJAl13bpm9MEuZzAh5cnPDPw/1QUmhe8mt8d7LqlGgu4J9C2eo8nDcnzcnMEmB6z7CIVAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/I1zGqi7mglIlukDTD6IXTWsV8mOEINDeMHGMD+ui8=;
 b=UUjpt/gw0o6SIHMSCK9Ot2/TpTl7h15vrSSBZHBbgeoimlbTCCHiG6sZ5n/sK97dPLNM3ElHZssfCGafJYTqRP4K4uEaVZ819KDXfoWQaAt6/F+6WShvvxdPv/n5AxzjGdm0kCe9MS4BmNwgfGr2/R0P5L0Hagi68mafZAb2kOY6zImjcLX4NOw5bDzn3Z57s0m+qQsgiG7dqVPil7EgrN73vJOKf0+p70NUFIySTLFOwJ9e1Q8FTo4Nq83eCUXsv4AWJavTOaiT3KSUoP8FKWF9qBJcMdrxrPEi6F09TMmVln2/Lg/aKip3Hpvgjfqo63E1qIF+9nwFpqmgSTqljg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SA2PR11MB5161.namprd11.prod.outlook.com (2603:10b6:806:fa::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.26; Sat, 6 Apr 2024 09:23:41 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f%4]) with mapi id 15.20.7452.019; Sat, 6 Apr 2024
 09:23:41 +0000
Date: Sat, 6 Apr 2024 17:23:25 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <mingo@redhat.com>, <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
	<linux-kernel@vger.kernel.org>, <kprateek.nayak@amd.com>,
	<wuyun.abel@bytedance.com>, <tglx@linutronix.de>, <efault@gmx.de>,
	<yu.chen.surf@gmail.com>
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
Message-ID: <ZhEUjX1Nw0y2eJ1o@chenyu5-mobl2>
References: <20240405102754.435410987@infradead.org>
 <20240405110010.631664251@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240405110010.631664251@infradead.org>
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SA2PR11MB5161:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hPrxvfaLp4xgwYas3u2BHSnAjpGSwEuOkrA9J7wCShdyZn+iP5t7CidTSqGy75yIQYJAMaHEpQ2Op8+chGXy3KvmDXw6WPliXcpERVDSh72ACkCLdlRAVDYx2MGgUvDtcAIvhaiz3jeE0jj4LlL8bgr9tKNXfrlQAPjYrfvr4ZguYx6TlWwNTcP2uGmQvVUFmrUDAGB8CJ6ZFywDATyk9a4T+CLgVyFflyYqdQHw/XdGj/ecNJFkMLXsKl9d9kyaKc07B+rfl6GSyc1zBNctrpYdCicXSYGXE6lKEc8Uip5clgBLA8q3z7+6AdGfnBav86/nZcz4TgdlyhgzkNiJQ5DoTE5PMLBUifGzAmGmVIP99c7l44xmDX5FB7+3d1Fx3yWR7aYi9fQNVMC9IcHoIPcfEDVsR1HVHd/I4qDgN+1Vwj4N9nsLjtlYHo21J+0+VCNod5hHtYoa+ZHYI3sZgiYHIQpsrXXzDIwIK+jVf+FbHe7UhBF2IPXTzuCOWehjPOXs+FnGW1NCR65XBL5SqXnbV0lQ0mDkkNNBoQ1lsulSXnjp2FqqAR+DSHhMJudJcaL8lOfu7c1YNP8z+J8h1IU7p1LJj/XeGcVTR1RJEDiq36H/y0goGqsS8qr6WJ2P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?amLTLOecezdgY4rq0OfTWohYdSqabTRBGhjVFtSKZutvOZODe1p9XoulIq9/?=
 =?us-ascii?Q?pX9KDm3xpnT8PgxEWuiXVCHgrQO4nGfELuwmk7Cz/vCA9oh/baYPUHsY5gTV?=
 =?us-ascii?Q?sWqainEXMaZnYyLmt13LIj/5LgvWybsDp8vV1VLGqyS+uhbhy7fpBuMSKYUh?=
 =?us-ascii?Q?xWZ9K6FJaK3ARMpTkO922g9m2aWC/mn2fAWpsvXRl7JMA3OC6+Mdoqz4C49t?=
 =?us-ascii?Q?0r8rZwLvCyGm7BS3rTP8VE3I/QjsrfqL7fQVJTbEEr2F+33iIPHeKg6ZwsrD?=
 =?us-ascii?Q?6jyQ+EgBf5EjyAQ5pqHOVKY3dU3SDauWQv+ti9fxlmHPJT/ktOyPzEYjrwV2?=
 =?us-ascii?Q?IThkSieq9s8vOxi36Cox8zj5JYTD2lUTPLVm4B1B6E3nKN1esyXJr1IzlGTp?=
 =?us-ascii?Q?TTBSgWf9JimO+b/jq6mlU6hyBJbCtYQsD5Xn1JQgZA2tM7XdYj3IZJDB/B9g?=
 =?us-ascii?Q?bq7jouRSBsODdS2GIBthUOn6kQILR33ooRgVioy3UjTNvU6//hd/Crwll9cd?=
 =?us-ascii?Q?WVOWVVlIezGm5Q56Ut/rClqvhVC+IaQrbhozU2PKugmDCVzGq/qSqzy8HRUj?=
 =?us-ascii?Q?3KafJByK6XHuCmetOc471A6XRVDLuUbk9cdSlJgfP3AFvvoAacrR2s94SObI?=
 =?us-ascii?Q?jP8kRwCtqKT9pRy25VOfXn5+82xYMuh8nHG0AupKDrcXvTTwwSzXwV6KvvWQ?=
 =?us-ascii?Q?XqKsLBqC5IIZe7sKn7lXqV2+nmH5gHMIL3h1dsNVf4JVWGKhzQbYqojqKoGd?=
 =?us-ascii?Q?+cBu5JWntVkzKfzGYV18gDfRPdAp7+YeObzjWD6PV6I2tVaT1CtOOiZLOE0T?=
 =?us-ascii?Q?FaWq1v+1hJSRzrVMMtQeVA0IydDKn5xg4oPPQMSK2nWcw+LmJ40GEOVNKZ8R?=
 =?us-ascii?Q?dRNgw++/CwZjWXJIM3TamRJG60hncYXdySxw53iMOrn3gkqhUWyaefJ7kBaZ?=
 =?us-ascii?Q?VNnXwy8Vc7TqwOPzcVHGUwIgrlmfYtuVzZSp+0trJqDxkYcVMlSADn0+UUnf?=
 =?us-ascii?Q?beyqrfo6uXqXZv875az+af2z3ArmO/Mm23Z9QEdP3sIK9mATq2SL2jYeumFY?=
 =?us-ascii?Q?m2moBxn9N+EjwXybXsjMecJVsvSYY0lvPJ05RG+qKQAPt/ZOkVZ/NlKPWygJ?=
 =?us-ascii?Q?G1qkFPjSVU/D15GurPoXVZ7KHUFQgkQdxPpWSL7APpJjPMkLIjXJUoMyveYK?=
 =?us-ascii?Q?8rAeouqH9k6r6F7hCgs3RpfrUHh8LaYgTu1vtawY9Y5HOOm/PB0eKViBZKuj?=
 =?us-ascii?Q?O3guzsXrKl1G1kxhgypQpzvkqxR8bfobS/14o0ekn3gvKkMy3cUBy3ptC3j9?=
 =?us-ascii?Q?TxtvveKSDuV9DyA8+rjIT7D+XKmAHgyVTgZyi8IeJUQ3C2q/fFkKbLVK3JGo?=
 =?us-ascii?Q?vNLC52qyunhkgtsghYhBvHjZxh9cyUdjUYx2dYh9K7ZehhfRFSv/XjxwDQD3?=
 =?us-ascii?Q?1qz1GW85tS5aaMTl8aeOERJAGCWBJL7c9dzj+HHqOonhCvb+DETuZoHtXwm9?=
 =?us-ascii?Q?hodY3KQ89WXAhvgknB/AkF9HCyQHyJbweicxqqJhxjX5xKa70836mqGLPKH9?=
 =?us-ascii?Q?BnKuZHZahWD+eHtL44U9HtaEmieFFYfZrKpB3yMJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50598d8b-1794-4121-1a59-08dc561b3f85
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2024 09:23:41.3279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+CSzoR4e/qulZWDv3VaOWPzsfYrwKTP+5od0O4u8bD7s/d2myzWRRWn0VSrw+LFR7tn87JFcNNym0ICZLo3uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5161
X-OriginatorOrg: intel.com

On 2024-04-05 at 12:28:02 +0200, Peter Zijlstra wrote:
> Extend / fix 86bfbb7ce4f6 ("sched/fair: Add lag based placement") by
> noting that lag is fundamentally a temporal measure. It should not be
> carried around indefinitely.
> 
> OTOH it should also not be instantly discarded, doing so will allow a
> task to game the system by purposefully (micro) sleeping at the end of
> its time quantum.
> 
> Since lag is intimately tied to the virtual time base, a wall-time
> based decay is also insufficient, notably competition is required for
> any of this to make sense.
> 
> Instead, delay the dequeue and keep the 'tasks' on the runqueue,
> competing until they are eligible.
> 
> Strictly speaking, we only care about keeping them until the 0-lag
> point, but that is a difficult proposition, instead carry them around
> until they get picked again, and dequeue them at that point.
> 
> Since we should have dequeued them at the 0-lag point, truncate lag
> (eg. don't let them earn positive lag).
> 
> XXX test the cfs-throttle stuff
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

Tested schbench on xeon server, which has 240 CPUs/2 sockets.
schbench -m 2 -r 100
the result seems ok to me.

baseline:
NO_DELAY_DEQUEUE
NO_DELAY_ZERO
Wakeup Latencies percentiles (usec) runtime 100 (s) (1658446 total samples)
	  50.0th: 5          (361126 samples)
	  90.0th: 11         (654121 samples)
	* 99.0th: 25         (123032 samples)
	  99.9th: 673        (13845 samples)
	  min=1, max=8337
Request Latencies percentiles (usec) runtime 100 (s) (1662381 total samples)
	  50.0th: 14992      (524771 samples)
	  90.0th: 15344      (657370 samples)
	* 99.0th: 15568      (129769 samples)
	  99.9th: 15888      (10017 samples)
	  min=3529, max=43841
RPS percentiles (requests) runtime 100 (s) (101 total samples)
	  20.0th: 16544      (37 samples)
	* 50.0th: 16608      (30 samples)
	  90.0th: 16736      (31 samples)
	  min=16403, max=17698
average rps: 16623.81


DELAY_DEQUEUE
DELAY_ZERO
Wakeup Latencies percentiles (usec) runtime 100 (s) (1668161 total samples)
	  50.0th: 6          (394867 samples)
	  90.0th: 12         (653021 samples)
	* 99.0th: 31         (142636 samples)
	  99.9th: 755        (14547 samples)
	  min=1, max=5226
Request Latencies percentiles (usec) runtime 100 (s) (1671859 total samples)
	  50.0th: 14384      (511809 samples)
	  90.0th: 14992      (653508 samples)
	* 99.0th: 15408      (149257 samples)
	  99.9th: 15984      (12090 samples)
	  min=3546, max=38360
RPS percentiles (requests) runtime 100 (s) (101 total samples)
	  20.0th: 16672      (45 samples)
	* 50.0th: 16736      (52 samples)
	  90.0th: 16736      (0 samples)
	  min=16629, max=16800
average rps: 16718.59


The 99th wakeup latency increases a little bit, and should be in the acceptible
range(25 -> 31 us). Meanwhile the throughput increases accordingly. Here are
the possible reason I can think of:

1. wakeup latency: The time to find an eligible entity in the tree
   during wakeup might take longer - if there are more delayed-dequeue
   tasks in the tree.
2. throughput: Inhibit task dequeue can decrease the ratio to touch the
   task group's load_avg: dequeue_entity()-> { update_load_avg(), update_cfs_group()),
   which reduces the cache contention among CPUs, and improves throughput.


> +	} else {
> +		bool sleep = flags & DEQUEUE_SLEEP;
> +
> +		SCHED_WARN_ON(sleep && se->sched_delayed);
> +		update_curr(cfs_rq);
> +
> +		if (sched_feat(DELAY_DEQUEUE) && sleep &&
> +		    !entity_eligible(cfs_rq, se)) {

Regarding the elibigle check, it was found that there could be an overflow
issue, and it brings false negative of entity_eligible(), which was described here:
https://lore.kernel.org/lkml/20240226082349.302363-1-yu.c.chen@intel.com/
and also reported on another machine
https://lore.kernel.org/lkml/ZeCo7STWxq+oyN2U@gmail.com/
I don't have good idea to avoid that overflow properly, while I'm trying to
reproduce it locally, do you have any guidance on how to address it?

thanks,
Chenyu

