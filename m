Return-Path: <linux-kernel+bounces-151284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0278AAC6A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BED0E1F22848
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DD67C0A9;
	Fri, 19 Apr 2024 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YG3aAaZ5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0E27C089
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713521088; cv=fail; b=mvUtXmdqYAsNoOliW3C+f3tYV/vmwgWuiXy1VexcvEb3WGFduszCDUPiRKjTL+YtUnsrhPWXEacyq4OsC9P02TW+3z5lbNxfl+hdAgtY9kRCb9JuNHvemIYmxxGWGORMHtBVLmjvXlbWmyuTxfZFxUHiQe2bv9W3ZDxT32wKnAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713521088; c=relaxed/simple;
	bh=4t05lCnfdvll7IDBK+Yk+PCUvMqNNSb8NbDhFtjVnaE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RruKpcMOBAmZdIPCml2HzXWO43c9pP14ZTjU89JXwQXMVAYu3noBKNiTO040LxJf1dE1owae4VjfvjWhijZ+tDWBwVXy4JHgBqoz1SeWfFaJZHozXoM1fkZducX6JF0mTYLVHdcG2DQImIlDqF0LUm6vKnjgcbuFJpvkzI0cMV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YG3aAaZ5; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713521087; x=1745057087;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4t05lCnfdvll7IDBK+Yk+PCUvMqNNSb8NbDhFtjVnaE=;
  b=YG3aAaZ5Rzdfn0ovYIwuunTp9Xr0jcsZp3+2sOKwAb75crPkFISM35Fb
   BXfaUPr3KeENk0BSgpY5w31S82RjgRLJBPI2VEcEKOKZhWjLPJXvH6+c5
   LBvUMC8ZpjTOpG6vdlJW0PF0Ws37vHzMykDM2Yt23jdDWqslYVxegtKHW
   xQj4cjzGazowgyGHTqSWKzPXHl+L44yO0z7tCVqrrqmNpI4AGTVTcYZhH
   Z/L24YbgcTp9yFppmtTBqhETiBnCx0E1SuHs1NkeSRBIhVnclht/+3/3j
   CtxgGafSeFCC3fAMlzeF5gbrY1049inhAPOgftWKDmdNNGZaNBxAEaby/
   w==;
X-CSE-ConnectionGUID: 7+6i/n/3SfSjC2kimDX1CA==
X-CSE-MsgGUID: QUzg24zCTwq2lWC0rHyN9Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="9039508"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="9039508"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 03:04:46 -0700
X-CSE-ConnectionGUID: I/Y7cSXIS7GIlsFJZQHeTA==
X-CSE-MsgGUID: +YoM4qLKQ1yCF0F60BhYsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="27835985"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Apr 2024 03:04:45 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 03:04:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Apr 2024 03:04:44 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 03:04:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNNg1WGt9JvEba7nLaVPuhKVOd4UHM1MQUqfeQZCuQDuB9tEZbECgwAeBx5kUt+CAYHO9qtWGe/4bkjKPZwicSzrLD9mkOblFg1+h7cd0Tkkojfs7ZguKLB3RDJk50Z8LGpXrctjL89fHMDVElYUjMzNEXYQQXpJrL6N2mnVX8QukAWBlrxmT7VfS8SGKGAj7Oju6JLgaixv6scw+kJbUAa9jskoU7DyOPE6qNtp0N8+nictwyBsI7AmzHzcSpgfXYWjpE2HMJHmOXXaaqyUUVEVuV/9SSsqh8ZRctrjoiz5PUaM8tGnIbYE0tT7ZqXla/KY5gjV/NtjmEJjzbFAxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Le6ornF5In+B9wajnc2DLdOyPG+DoCQV0E19dbLkQYQ=;
 b=iy5vfuQvp+KnxMf9rwm/lFpS9e+cEAKQuCCi8HvfmUgqWmpdAe8bj8R0arDHZvt+dzYNNX+h0uyJIs4yP0XhlVc5OhEMy8AGkBk3AKaAP9K4bTEB5vqpp/JYMGiYjvfOsHEQs2x6HbGBn3I0lxCAhVaILqMEEKqBT5WGHPiTItbxK6YnMFYnrKgLfqdFDMhPbsBd9iljqAcJhVi2Y6WRw1VlEmhfqgi97p4LaqpL+JxpkmgZp5smBWR01Q3fqiGNMcvAOtVt5Z6sHJ4hqhPLK3Mwt/dR5be+Jzk1nm5HcqgQVK+usnFwe3iJzguRmNOOW/ehg7Q0UoGXwSaYAO13vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SA1PR11MB8256.namprd11.prod.outlook.com (2603:10b6:806:253::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.12; Fri, 19 Apr
 2024 10:04:42 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f%4]) with mapi id 15.20.7519.010; Fri, 19 Apr 2024
 10:04:42 +0000
Date: Fri, 19 Apr 2024 18:04:25 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Xuewen Yan <xuewen.yan94@gmail.com>, Abel Wu <wuyun.abel@bytedance.com>,
	Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>, Tim Chen <tim.c.chen@intel.com>, "Tiwei
 Bie" <tiwei.btw@antgroup.com>, Honglei Wang <wanghonglei@didichuxing.com>,
	Aaron Lu <aaron.lu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, Yujie Liu
	<yujie.liu@intel.com>, <linux-kernel@vger.kernel.org>, kernel test robot
	<oliver.sang@intel.com>, Tianchen Ding <dtcccc@linux.alibaba.com>
Subject: Re: [RFC PATCH] sched/eevdf: Return leftmost entity in pick_eevdf()
 if no eligible entity is found
Message-ID: <ZiJBqRafMdBi+wCV@chenyu5-mobl2>
References: <20240226082349.302363-1-yu.c.chen@intel.com>
 <758ebf4e-ee84-414b-99ec-182537bcc168@bytedance.com>
 <20240408115833.GF21904@noisy.programming.kicks-ass.net>
 <ZhPtCyRmPxa0DpMe@chenyu5-mobl2>
 <20240409092104.GA2665@noisy.programming.kicks-ass.net>
 <ZiAWTU5xb/JMn/Hs@chenyu5-mobl2>
 <CAB8ipk-fejQ41Jgk6z52+T6CP+impwbaOAfhA9vG_-FB9BeRyw@mail.gmail.com>
 <ZiEaKOQwiNEglYtS@chenyu5-mobl2>
 <20240419082440.GB6345@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240419082440.GB6345@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SA1PR11MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 944d5f99-5227-487f-a5ce-08dc60582208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: mNQ3OAKq5KDT8jYAxcO1crWnST5tIMTKNfecixTUzYCllfLX+P0aDACNLGMjGXQKRck4B566icLM9MYdy61vtvln8DleQpxvKq6yXUcadJkCYTWh3yYcEyPzCVGE8SHdnfE0TMi0I3wHNXjh9j1SV6lsEmzzUhrDUvqc+ASvi3A19XgXLVlJRDVC3vwhSTGy0T2gn/6JHwTnE93OhEUQBChH5uUVkoFaPVfAQQKqohRxMkkNvXPf5f35qwH0Xw26Oo1BSwqMmvxPoDQETsi1koiPGT1sCnb2zviG66g+OeksahX8Q5H0LIOk+KIitwCF2fclVL07FbIracMyUJBI01eZJ0reGoEZKCGKMezYD3ARa9QmKc/UQQ9coZmDMttoofgRglbnCE+eEwurcLqbUL3n6QsMlNViYjQIS2srAp9VBrvcxTnnOZbRLDjgJ8iKU3S21vjzHzQnSFnnsyOifwcXtCFRJokeL2vOdVXqTMa+MBFri8i6mNoLgeM7d5+0G0KC9Qk7PdJ6NAtgSf0hXD1lN5onxoJK93QYhLw3deSOC7GwgwUWetTxVeefZqHQopUgzKQ4CI6tBSRGqqJMZ/goVUP8yKzkPTPlS+7vOYE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JPt4PkC33i/VJwDedBguY+NsV5KbPGq3v6pA34NU3HyPLcMTsJAXNAIHzzBn?=
 =?us-ascii?Q?9e0CJckT0Cmmuao2ZdqsQcHHyDv1LJ+IfCjvw0204Pzk91UADmgz0k3d8atX?=
 =?us-ascii?Q?XgzPEPuvlofALFZFhFckYj/rTM2kjUb+bh5+wYomkHz0o4qYvKEhGHoyWW0I?=
 =?us-ascii?Q?szt6lD2MwMU8eeTcD3+Hvw5hz49RahYz4EwYd5lW3pbE+UYySSxOrOwIwHMd?=
 =?us-ascii?Q?OEh60dzXfA1OgfAkThAUWZGydVW5+mYymyATBiTXjhfthNtxtzuK+5QkOfZo?=
 =?us-ascii?Q?scdTSnDldArWcr/ezH99CBj2pHeZviP670byofAFaquEr26tly0GwgDKbxEM?=
 =?us-ascii?Q?9p5oZBWkR+S4O9hLBFJE8c/OA+cv2eY+lqjYSF0P4G12dVrgkwWSvzum6Idr?=
 =?us-ascii?Q?lbztTsTnqwZZ6JAXHskw7YEdm6aTkwfh7NNlwP6pQZLcmkblE7XklyVbq0Kv?=
 =?us-ascii?Q?loZQAavte/cwdaHiQiZtpj7RPtX7eQpGY2ezXtv3F/AiGXr5CWy5Nd3t89Yn?=
 =?us-ascii?Q?d7TYb3mm+NwNzNkvhIH0IqDXuLqTJ3qcjZcjRUO5ulxX7YPRXDq95iPFmksw?=
 =?us-ascii?Q?2qVxm/KFebd8uCukSQUzXaGjROeS9qt3spLtBxa9u2LSOV2sv/6veztFSAdi?=
 =?us-ascii?Q?VloDJXDgRhBO+VS2j9VW/yv2WRzRWY/53IpencA72Glxo4LPVDv74GbXQ4t+?=
 =?us-ascii?Q?98ZxqGDnLByQgjnb/0AlNjiYHdJBZOXQtU4Xt4xmmgGUBR8P11WHWMggCoBL?=
 =?us-ascii?Q?oAjPFE4TH4gaDQs3z2G2E0BA5FixBqPJW5MHzOlMF/lCP+wO2k4weBI7UOms?=
 =?us-ascii?Q?cTQGIeKhRE3VOYnEFHNht7RxOAcZfSe9tbHqLaXekq2E5Qr2jVsAWvW87VEF?=
 =?us-ascii?Q?4L7ek6yfeCQqAjrNTwGxbnWBiwfhRekx2w7PNiRaRVVS7ufRI1KQbLrygbpB?=
 =?us-ascii?Q?nokgC8kqh8pQJQbM6lG57/Lz9u0rF8fWuEt4joSn/3YCarSZ4LYedKDTdy95?=
 =?us-ascii?Q?ErhkgCv4I6ab7kCzOHSftpLcYeVDh6fto4eWKG2xHdqCYsRiITTBDeHoUjhc?=
 =?us-ascii?Q?jQVwVLsG7V7916VWYAe5sCO81ACfrTAEN3+R4QMHpwzgmHNWy86wb2IRkK2i?=
 =?us-ascii?Q?BThdMBfuE17luFxW1k0hHRAuyiC9ffeAo/TqB3SwKTNDSQbN1Z65g9JuK34i?=
 =?us-ascii?Q?wVJmR23bTI6Ag6BFXsFpTs9I1/RhxJP1guJPB9d+ZHpqH0yj+cP4ACO9tnIu?=
 =?us-ascii?Q?WUa2hJprkJ6GO96gEvaRflCFxdS6rPvg8HFFyJfyMasfrhZL6LseDpJbpDu5?=
 =?us-ascii?Q?RRQwIl1gEUFNMZnjCtmzLbvdkX0F1yWywk4lYzw3/mySkz88dA3G2m+8C7hJ?=
 =?us-ascii?Q?nhIsZYONa75cF25bBv6WALrJV/gaHHGf6SwGqAK8n56w9uuEKmXO6dnkKK9U?=
 =?us-ascii?Q?ohZMclEyvyINnlKrAQhKj/Yu0Dy3Sx2gAC+NXurCQPikw2/cguO1riwFL4Hu?=
 =?us-ascii?Q?gGSwzuQqwh4gt+NHuk+EfvkEHXacII22bkkSlDjhK0LjXp28oSvYBp+pPJrY?=
 =?us-ascii?Q?6pbJFGyAw67S3u4MAm/NU2oQrw02QC3KR2sPLOLp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 944d5f99-5227-487f-a5ce-08dc60582208
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 10:04:42.6690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2o82NVqoKtowbmk+9WrREQflnEw2o3e1gtZrEbM44ZBZDoEpWyt2h9cNsFtqwjminaXYN7+TjbDTj+rmH6Q3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8256
X-OriginatorOrg: intel.com

On 2024-04-19 at 10:24:40 +0200, Peter Zijlstra wrote:
> On Thu, Apr 18, 2024 at 09:03:36PM +0800, Chen Yu wrote:
> 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 31bca05c3612..9f203012e8f5 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -696,15 +696,23 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
> >   *
> >   * XXX could add max_slice to the augmented data to track this.
> >   */
> > +
> > +static s64 limit_entity_lag(struct sched_entity *se, s64 lag)
> > +{
> > +	s64 limit;
> > +
> > +	limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
> > +	return clamp(lag, -limit, limit);
> > +}
> 
> Right, helper makes sense.
> 
> > @@ -3721,6 +3729,7 @@ static void reweight_eevdf(struct cfs_rq *cfs_rq, struct sched_entity *se,
> >  	if (avruntime != se->vruntime) {
> >  		vlag = (s64)(avruntime - se->vruntime);
> >  		vlag = div_s64(vlag * old_weight, weight);
> > +		vlag = limit_entity_lag(se, vlag);
> >  		se->vruntime = avruntime - vlag;
> 
> So the !on_rq case has clamping in update_entity_lag() which is before
> scaling. And that makes more sense to me, because putting a limit on
> vlag before the multiplication *should* ensure the multiplication itself
> doesn't overflow.
>
> But now you allow it to compute garbage and then clip the garbage.
> 

Yes, there is possibility to get multiplication overflow. Clamp first should
be better.
(BTW for !on_rq case in this patch, it is also scaled before the clamp).

> >  	}
> >  
> > @@ -3768,6 +3777,9 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
> >  
> >  	update_load_set(&se->load, weight);
> >  
> > +	if (!se->on_rq)
> > +		se->vlag = limit_entity_lag(se, se->vlag);
> > +
> 
> Except you now add clamping after scaling too, but in a really weird
> place. Should this not go right after the div_s64() that scales?
>

The reason to put this after update_load_set(&se->load, weight) is because
we want to clamp the vlag based on the latest load, although for reweight_eevdf(),
it uses the old load to clamp it, unless we add new parameter to the calc_delta_fair() to
use the new load rather than the current se->load.
 
> Unlike the reweight_eevdf() case, there might be an argument for doing
> it after scaling in this case. Namely, you can have multiple reweights
> stacking their scale ops.
> 
>

Yes, I saw that your patch which clamp the vlag before scaling, I'll have a try
on that patch. Xuewen should post that v2 if everything works well.
 
> Also, could you put a few words in on how often these clips are hit? I
> suspect it's fairly rare (but crucial when it does).

Everytime it happens a subsequent NULL pointer exception usually happens.
The trace data was posted here: 

https://lore.kernel.org/lkml/ZiAWTU5xb%2FJMn%2FHs@chenyu5-mobl2/

"
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
vlag = vlag * old_weight / weight = 357112523888 * 677 / 4 = 60441294668044;        <-------- ouch!
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
   key * avg_load                        <--------------------- OVERFLOW  s64
}
"

