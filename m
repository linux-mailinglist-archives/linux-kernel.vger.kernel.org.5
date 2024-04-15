Return-Path: <linux-kernel+bounces-144721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C21F8A49AF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB07A1F225DF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66372D051;
	Mon, 15 Apr 2024 08:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OSWpEx/3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5950F2C1B6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168208; cv=fail; b=h3hpCC+w5jvF0EgwpiMcKnM1rWg4+mi1CUC1MjmK5TaeQhDOLGbRO2F2IAySiYkGbVFGu/tapPG701DQYzcsTgkeRjMh0JSAMdaQT2/SOIwBctlmEPXl8Ynce1aFRsrMwhkMMCXjQ3vLE8K0RJJO9VQwRAmD1RfUWo1vCEbdV7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168208; c=relaxed/simple;
	bh=nRKVmuA6uWpuIItMMSXJOfR7yguj5lYGVRqFFPQqRY0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BUfNEu2k2wP/3Sh8LsPkq2BMkcsudlzaOIYjatQoyvwQ9tx8gNYiH9IGgjkMPWfApsKFQHaZeuQoxTNGorP29O5gnEx4npTFoxOX5HjU4xSUK6HkkXmEW8IZCs6uXXbQIizb9dT7lCzD9/587vgHLcKUgpbtaBrUpB1IoKb37Ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OSWpEx/3; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713168207; x=1744704207;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nRKVmuA6uWpuIItMMSXJOfR7yguj5lYGVRqFFPQqRY0=;
  b=OSWpEx/3/DQnCqZovYIhf5GZywQwEyk7VKivXceyeTyuR8BYNTLQoH5Q
   qH38b7m7RSBK6ipdy0I4YTTi+PxAuRg6l63Jj6ZZpnwavAzIiH7O0le56
   HcWTQfHIUDAvkS7vQv25GaUJxQwN1FQgVhcV/Y3FxcGPnckkBEx4gmy+o
   8GqrMY00j/gI3NXFag5Evi92Mf/qVYkJJXrLcprYbIgmegdUjF4iqueQ/
   +oVGcaB9vNvPeNci9rjpXPNgG2NOb5Q73+iZCct0b0YNN5BLGgD+JSCEj
   8Jy3ePfZqJo8cQocUtZeVzo4D1JyQc0sKc8IvlthcE5O+Jz5JwNk1U9fK
   A==;
X-CSE-ConnectionGUID: M+ytf4EjSHyfrDqn3TrjdQ==
X-CSE-MsgGUID: dbd5JsnqTSuwZT3bR8qNwg==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="19934963"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="19934963"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:03:26 -0700
X-CSE-ConnectionGUID: Jrdn7cwfSeaGA0BHa22iuw==
X-CSE-MsgGUID: Ny86vBXPT3WNJc0TrgTfWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="52790988"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 01:03:26 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 01:03:25 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 01:03:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 01:03:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LujR2X+jh9jYBI1eNqUYQ9XFQKJtt06/sA65LkAN7hY4qsY+IGKkmv0JD/54rrpDkSq8W3u6SYhf8nNErylTaaVbkxel8SH+DnxiYDAZsN564qQy8zvMEoe/ZR/OKlB6BB/YOxhVw7/l0ye9QznDGRUDe0yZaUJc1JRnbktAkMYmvv2hFTAwiL0gCOe9nytsFAo+OawiIQXvp+YHSNZMnkKDTL9fVip0xGWqbdk/Sj1TGLNyPMqrGrnq1pC5mf8NmLf2DMoNsAw5/5/vtU1Vxjq8V/6LMObM9nHcl28CJqZ1HDfD0EYBmTjmbAIGHQ2gGejsnIpPHkb5BRXdmZ33gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akcoKBsiOnMeoAOwkPfx99w02f03Qmyij5xBjY2+lLM=;
 b=bWl6oo5ri+wIkki2TyE9BiIwG3SSqk/Bq0vbRuaQSRSMR1LMeV12dssEhmDblKJl7KNmMWJ73Dry9KTlHqiAt3vleVuj2rG/yErJGfd5iwLwHFLAWVAwV7Sp92btlxizpVCLlcd6CEhHaP09Ol1WfCZqLsZq6Y+0tKj1j+9/viVIeRu5avT2h36+QpzmnuidrFjOaiDGpHOCtp6e4HW58aOyAo5e7ZxwIEmX9pSbmB3m6/m/UEZjfguh8HsC+HLDY1e4vtrjWfyt7zxhVlkg+iPR9wM4TWh/x8jmCCWfM0y9JjXGu/I0PTaKtk2PXs1EYPzgcgVL1KXYfsSSIOd2gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH7PR11MB5766.namprd11.prod.outlook.com (2603:10b6:510:130::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.43; Mon, 15 Apr 2024 08:03:18 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f%4]) with mapi id 15.20.7472.025; Mon, 15 Apr 2024
 08:03:16 +0000
Date: Mon, 15 Apr 2024 16:03:01 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Abel Wu <wuyun.abel@bytedance.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, Tim Chen <tim.c.chen@intel.com>, Tiwei Bie
	<tiwei.btw@antgroup.com>, Honglei Wang <wanghonglei@didichuxing.com>, "Aaron
 Lu" <aaron.lu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, Breno Leitao
	<leitao@debian.org>, <linux-kernel@vger.kernel.org>, kernel test robot
	<oliver.sang@intel.com>
Subject: Re: [RFC PATCH] sched/eevdf: Return leftmost entity in pick_eevdf()
 if no eligible entity is found
Message-ID: <ZhzfNU0rsscFnTm4@chenyu5-mobl2>
References: <20240226082349.302363-1-yu.c.chen@intel.com>
 <758ebf4e-ee84-414b-99ec-182537bcc168@bytedance.com>
 <20240408115833.GF21904@noisy.programming.kicks-ass.net>
 <ZhPtCyRmPxa0DpMe@chenyu5-mobl2>
 <20240409092104.GA2665@noisy.programming.kicks-ass.net>
 <20240415072251.GA12673@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240415072251.GA12673@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH7PR11MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: c29e97f3-0a71-4293-2d50-08dc5d2281b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0KXDDr1X2iYtRxNgBE/zC8OmdLie9naiuqfIJb3WRlXl2v2hItDcz3IbBtzttNyTFYyzSY0m3vgYjNi9O1C45mi6FUj5gvWJYYzdEqhAYqx8DJ+sZX7C/GRFeallnFHdX7a4vlPrzhEOqjLhuBls7mqr7jMOhZMYRvnj2a2jQIJG00mGnbWEJrn1BM45XnIea+eLCfvVok5EoShiY9f1Q2koeemyqOThyL7kA90CXilBM2r7h7KgKsQIPSH/nffBM4kMXHFJIUCp1EVseQaTJxDMnLWOjVePQN0zCZc18C/SOCX/fFe/T3bkJ1ZBX/IYd+Vrp4cjObMVlu+b37JTdSs1OwGuhO3l1X7lqe+ed/2P6XuyDa8lUiZgOqjixWVeb1aDGAQCexaEukIaaRjEibDTFBwxP+M/ub8aLeXt73XkvYdQRw5KVOiRpjBZ8VTLFmthqFCbPOBgTf46q1dt34lafG05OacQNpc4iOFyFfv0Q5ten0bos+DCnjv8VsO/7ZoiTXRrqdnBzaCl9eUwnLxz1eDyrK9U50NPSDkqB2Zv75H5QuG6inkvbUiUq2R78qDzvUPIWZzKlM/I3mGo2M152so41+yJu1nUtOezwRQfnTjdRu9/2iQk7q/b+GDqUytQ+kXpB5rIWIUmAwkg4nJxVuaZ62cAbkqV5SEfC/U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gr6gTEwZ4ACTZVGJKLQ+MeBS0sxKpZD4kDz47/p21aKcB1371kDx78Mj7d8E?=
 =?us-ascii?Q?HlnoI2+aA1CoXI23tXtCh6D7/TTvXnU5qRyivl1zqj/asPnNnW9bzzEaXHxS?=
 =?us-ascii?Q?mzvs8dtdnObFDEQKrFwjTvNyIs0VMKuWz6qkSRiNSBhWq3vzGjEPVm86Llx/?=
 =?us-ascii?Q?vYqCleWZZWbG0w8EoR3ABgcvHJxepGx+vERVbZsW0topx5kaw3NYG6U7fjPW?=
 =?us-ascii?Q?0b6AFdTpQ7BH3WZRO+DDXK/L4eaHzlKuGNZhOZSWV17GPRrMqa94JVY5MYLV?=
 =?us-ascii?Q?+cXnDP6OHgCjccqK9haZTjKpIAB8Sgmr5tlwc7uFwH4EgpcBqOMRYfXP9hUa?=
 =?us-ascii?Q?FNKUsfCb85UDXhzoloddcpEX+5fnmeX6fodKj7JMCMEk8E7b6QtDR0D/7J1K?=
 =?us-ascii?Q?pevs82FGUGHB65+ZXbPgF1hSB3E/xjKdhopqnVrQBPqFKVonrVPAGWN2eLAs?=
 =?us-ascii?Q?lWXCBDd5kOe4UtkkvTJqoukPi9yOHTl/mU6x4k9cWYT6NYRm2abVjW2lxRBI?=
 =?us-ascii?Q?5YzM98Gi703VAFnqe2tfiJDq8mec+hm4YbTvlingOW4KSlRl+4JNTtzdto3O?=
 =?us-ascii?Q?HNgp3wPQSL1kGLvmhOq4/tfzJtyGanPDHcZAyRdwJ+BXchxMmOOMuL5N+etA?=
 =?us-ascii?Q?gqoHTwnMUceehlrV78dUO3rqcNQzZ2tW3mCkBuBsn38oQKFmJfh8GzdAdI75?=
 =?us-ascii?Q?nHaZLgKHrUq84OqPoV5FQ2vVPpe0IfgWVZ1Zpw64eaqA/EuiNmiOUVxVivpa?=
 =?us-ascii?Q?J++4WrGfpGCdCta7j6xPWJGuqATnzYHpb5c1zCzk2NlJu335Gt0kB0xi/YHc?=
 =?us-ascii?Q?0cXhLQOJlHRHZwphDElNwgqvUbiWLZSaqMv9ysHohWstjvCP6e34oTRxWXp+?=
 =?us-ascii?Q?n0I34KTOBzmtTdfHG+Y9Tn2P/6pJ5c+Zz10Vat5HYNVfmk2V7j8H5qabYaPZ?=
 =?us-ascii?Q?4rgtlaAmlXmA4+ijBoDeUI2VMcM1k/Renb22eyij7TrgAbACv2e/rMzk+EOo?=
 =?us-ascii?Q?4ZfGh9ezlWuEdXLH1VEnbnycr5jiaYqhXVBZtajKTThOUiFEidA4XvUqAjyL?=
 =?us-ascii?Q?w6kbYx/M8ckAzPa+Hx03sDwWZOYszX0wUlLGjfXktsArhOpSVznGFaacEMr9?=
 =?us-ascii?Q?hR2uvg/AiFZ8zfK7SBIMr03tcmzYkr9QBvVESJtXzlkQ9JY7MxOi68025471?=
 =?us-ascii?Q?0a70pC9FRak/F0dHKlO1z9hubv3vCEYeaO6h7L/AhmVKUfJXJDB8WTp5e1NY?=
 =?us-ascii?Q?xkeqxpJqABWBpTVNpf7aYli1pZgYHqf7Otr1V+MWfznoT9oUQ/XO6sV6fRCG?=
 =?us-ascii?Q?ctHEgbiQwRl8yR6/1LSvSO1vngSpK/wavG1sBPT7912vNHgrEI8Ng89hOm7R?=
 =?us-ascii?Q?w7FLY0PbLYJvbxqAZ6eXcjh36DuaRcehuUwZHFCqssTOAYjNeKO1WOgCHGgQ?=
 =?us-ascii?Q?WmurvY1+WUfoofX4lvoEw/a821JB/9YokWUPS7/Kzn9YM3XLTotYEIFNfkq9?=
 =?us-ascii?Q?GlIH3AZm488GNt3PYKnRoDrv46QYMxDfBD7KC+n85VzIopV13YnN5IklINcw?=
 =?us-ascii?Q?NRwW/HIsEkEIgvoOUD/JnLnjbyqsCDvdFz94NnTv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c29e97f3-0a71-4293-2d50-08dc5d2281b5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 08:03:16.7637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Cr0dsSgjn/YqeJThWTU38WUiIRALrWzat1FHZUJg0fpsOH8xsJMwqWTKTowcvvLvPaIeY0hA0fOnT/J3xB5JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5766
X-OriginatorOrg: intel.com

On 2024-04-15 at 09:22:51 +0200, Peter Zijlstra wrote:
> On Tue, Apr 09, 2024 at 11:21:04AM +0200, Peter Zijlstra wrote:
> 
> > Is there any sane way to reproduce this, and how often does it happen?
> 
> This, how do you all make it go bang?

It was reproduced in lkp's environment, and originally reported here:
https://lore.kernel.org/lkml/202401301012.2ed95df0-oliver.sang@intel.com/

It is a trinity test on a vm guest, and seems like be triggered after some futex
test.  And it was reproduced at a rate of 23/999 according to that report.
Previously I could not reproduce it locally, so lkp has helped test my debug
patch in their environment and got the clue that it was broken by s64 overflow.

Breno told me that he has reproduce this issue with KASAN on and using:
'stress-ng -a 20', but I can not reproduce it locally neither.

I'm thinking of creating a debug patch to trace all the changes related to
cfs_rq->avg_vruntime in avg_vruntime_add()/sub().
To see how cfs_rq->avg_vruntime gets far behind the cfs_rq->min_vruntime, which
caused the overflow. My understanding is that, the se's vruntime is got from
cfs_rq->avg_vruntime in place_entity(), if the se's vruntime gets an extrem
smaller value than cfs_rq->min_vruntime, then it might indicate that there could
be something wrong with the update of cfs_rq->avg_vruntime.
Then lkp could help us to further debug.

Or do you have any suggestion/suspect that how to narrow down this, I could
try as you suggest.

thanks,
Chenyu

