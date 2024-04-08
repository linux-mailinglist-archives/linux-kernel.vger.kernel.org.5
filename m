Return-Path: <linux-kernel+bounces-135413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 107B789C109
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBAA128313B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47F37E0E9;
	Mon,  8 Apr 2024 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OUBD97kc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBC56F53D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581918; cv=fail; b=rMIjkk1SQdBLm4/N5Zg+vzgYAZgpIx1QGmWU0Q85aOPYz/yXHW5TEzjdmX4E3sFgx4UizgeVjbyaGI1yQbmehx0OlP3+IZyqNwOOWsP41/Z7mz9Mt/of5FTK3DRivPngpO9Tb1EET5H5o9rJiSSwaeZGDNhvwf4XNIXcAQMGVhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581918; c=relaxed/simple;
	bh=6F7qO5p1NMmq+U10eUz8PLgsZzBFRxTRzg5KIndTB1g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xy2wovzshEUUDzHbFs/yCOPz4BW7zdb93JB4pYBAeT2i2KwkKzj2QSfHBI4JmqpPbIFiYCVVW4AkEXz8LPKz0Z+CERr/hrdBT7x9yn+o5jATmA6YKiTCb2A7YYnYnltekb1P3I+yLJBa0h4dv0cjebO/Bb5o9zB6069Hp8T30u8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OUBD97kc; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712581916; x=1744117916;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6F7qO5p1NMmq+U10eUz8PLgsZzBFRxTRzg5KIndTB1g=;
  b=OUBD97kcnBSN0H1Vhw4AdFFtdJE/JyBQgtPZwiv+OgVhR1Y6U8M2s8bg
   sl2Z6khcPrGmS1j6hZ6ArYTReD4q/VW9K1k69qh4NLy68SmdU/1ZyYkll
   mu6Po6+fiQVnTPQGEICqAEEKlfboxh3j2P4exBQzgryfQZf1IgdpqTS1H
   PlI/sq0L7BN6Kl1yB/2Yjewi4BNA9bV5H+6Gf8QlU3s9+Lj3c7Mu2l+Ho
   HyV7zGcZ+wncUEQTFivSMI5FCIvCfJiGld7VIGyI+QJFXbsUpfdJR8AqA
   7M1dh5UPmTwEQtoi5dyned+AIn6aG1raGAG7QOOaF1JsT75a5UhXp1ikb
   w==;
X-CSE-ConnectionGUID: yofUmoMqS0Cvp231qbY8hw==
X-CSE-MsgGUID: w0jg3HOgRbe0oWO0h7gKoA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="11689379"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="11689379"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 06:11:55 -0700
X-CSE-ConnectionGUID: ol5ZsAEwQ3SGsrXRm/QJ7Q==
X-CSE-MsgGUID: /GLQ06mOQ4OjvWe5UY+2tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="19835516"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 06:11:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 06:11:54 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 06:11:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 06:11:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 06:11:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FS2QMMnhmlseN7e7xEiNetg3kVbtt/2VFsSLpkTHQWLpx75v4ldruoyG75LbqX66Ko3ckrGjsN1Nhr1Lcja0Uv8LtFR53limjpqrszNwXDjL55P4PCVPx2Ayp15+vc04Da4qJReIft5zmfp9YgmLevdiP4XOklVn1ZJLnlYjfM25cYSXTTpmShmeUcNhspAWtG2rqcw6GsbzSgtCUXNCZYWCbBbXUu+Ao317HnkxBFs9y/jWIr32wBfVvg4s0EFjSKDfgs/74PbpoUQyeffJtcOotUadKpVc78erNBDCiF3W1RiwRlW+HECGGY/DUXD1ROwwwj28GkQVOQscF/dzvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsVrKSSZkYh4akPqMcN9pCeh9dLGNdIDmHlct9pcTSc=;
 b=HiVHuWNYT84ktQrnIVXsKhFMfjKvR6AWZZ3Lb3coZ1SY9tRBKcy+gHCOq/zPVYyrrXEpXxvPjJ6u59YFIwHac9U6cikHh9XNwoDfbwovmGdo3t4LmMiflsX7I37xt//iRKF20sl4BI17JVF/YOf/8XSiHVyO92OY3og+QXRgRMTKuyUJJ01ZaZ7nnZBvmxT2JIAG940eICyjJhW0B220CwwcNi3327eteqiNsmIBoJHFFFKyoyl+S8FBX1xLcV6fs5QNdQGQ0o65lADreY20tki7xNmad58FnbOfi0/uqq3gIF1KHK0UGG1UC9NTFFt4EffKPjgU7S9uJvfT/VV9tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SA1PR11MB6781.namprd11.prod.outlook.com (2603:10b6:806:25d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Mon, 8 Apr
 2024 13:11:52 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f%4]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 13:11:52 +0000
Date: Mon, 8 Apr 2024 21:11:39 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Abel Wu <wuyun.abel@bytedance.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, Tim Chen <tim.c.chen@intel.com>, Tiwei Bie
	<tiwei.btw@antgroup.com>, Honglei Wang <wanghonglei@didichuxing.com>, "Aaron
 Lu" <aaron.lu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>,
	<linux-kernel@vger.kernel.org>, kernel test robot <oliver.sang@intel.com>
Subject: Re: [RFC PATCH] sched/eevdf: Return leftmost entity in pick_eevdf()
 if no eligible entity is found
Message-ID: <ZhPtCyRmPxa0DpMe@chenyu5-mobl2>
References: <20240226082349.302363-1-yu.c.chen@intel.com>
 <758ebf4e-ee84-414b-99ec-182537bcc168@bytedance.com>
 <20240408115833.GF21904@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240408115833.GF21904@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: SG2PR04CA0194.apcprd04.prod.outlook.com
 (2603:1096:4:14::32) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SA1PR11MB6781:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yYwKIuNakZx2ZN4hXAmLvRDGjMwxX2EwxBZjzvPB9x1+z6RyWIOURl3fvWxWFyfea99z0zCyIc6F0XDuoFp0bU3vMBVPcR9YrB1sp5g8cFBMqBbhRevyDEVT3i3V7CqSk7Jtpi3rKrlRpKbum+4lzXWg4VZ2/UeGQYsompoG7mLFf7VsmSfIxCllYjJh8pQtDhK9byFpdJO5f0cqshbFJXoBoUzgP9mjrxA6VRK7legQ2ephHFStFWw4oGno8ATqjFk1BBCpIcpGgr/fr3hMos5ESozbKeL+EHjHxV69LZUcKGl3lWQBbIgGUHEEOHLpxs1xpIReMY/HM5A9X3skfF/mo2XH/oNSu4I7QejYIVxyCFySAscwoGSTAll/SF9FYddMPBOhJ8gvGU9/NVkxvfP3zQI2IZrAcKWJEVshrBQWKv/JRB0I1W4jv37Dg8I4Itm4V+k2JOpUSWexugr03AdDIMLdSLv67CsYjjrxYWSg18PLA8X358o0rto5gbC0ImDQDrrno48EWsqXqNF9NDahu0Vwju/J0GaaRL/BnOQvHBnF/lzf10hahoFlEedQgURotozxfMOPOP9ojqCthTCE37hiMHUVAzlkG8eoD2hO3Mf9VnxRq1+XWMoDh7oKyI6GXrG1aw0ZmMFM7EzoZRgwcqc5ijmCHKYtgzIzxeU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nJs/Vmmn6onbrF0u2WREIykgbnflyj/sPmGv60Ugd/xTtsQ8ypy/+ksAXHZJ?=
 =?us-ascii?Q?stBhdKrelIuBFziBX4kFYZSHil2Jh+GM9NpJW249yX+4+f/4nS341ZgoJ/a1?=
 =?us-ascii?Q?QvVhcqMeq/ohwzpgd1mJpxqeDbiuzkRwYYNbPkpQ3rMNAxcWyoQNDC8sahuy?=
 =?us-ascii?Q?YfeDujNZq/wC9/nWD3cJXscWGfrm7GC2q28Pbf52MYHmWJLblekMjvPjbFI8?=
 =?us-ascii?Q?cjkEZFzICSp0jWmoieonPmiKsYAtkfByNteJhb+InMOudmUGYiGIP+7b1xv5?=
 =?us-ascii?Q?GU0cKPSI9uB3IJHlA/o+LyC1H3dciGl4BHW2DTwp75gSK4MMgSOkYqeFytol?=
 =?us-ascii?Q?+NYZwGB6RqPo4EbNRO+jbMkmAbya2vd8VXD0qbu0SDl/4yiqGwB86zjLWvEG?=
 =?us-ascii?Q?XJSJA7MLqG6MK4ZKnIch0EVpiwmR3Ty06r87AsAH8D+jl5ohBSPm9l3qx3Vb?=
 =?us-ascii?Q?4CbZfC9feDqfbLzK+31X/BMXSV3j/uwz3wNiOSbWyBK7mCEeFugnu5IIyURt?=
 =?us-ascii?Q?yjYV8F9ShnNu1kp54X5Bn2nAGHcJKOlvTPqb3Tzj9dnOnGfBnnrHWNa5AOxn?=
 =?us-ascii?Q?UrUtsnFj3KgbWrEDbza9thMIKSL8h70ozTc58bZq2DRP8y5PCAx1jJ1MKkJo?=
 =?us-ascii?Q?jBRXi70dVqNyb2U8nrWwX8hrRGB76LVto5QJTbpXcT31uAq4Vt8X3KobsNbz?=
 =?us-ascii?Q?Chzfe7UCr8yCwe1EBBdG5GzD5p0GGkg9cwMtJPFkeAsWGDusS3Tqa8M7dvLk?=
 =?us-ascii?Q?FXc0+8/84F8cpgqta9wMkz+hBgLht3BKanNw9oChSYJWvPcKMhgTwxpkI8Yw?=
 =?us-ascii?Q?tGk4qn7Gtzs9ozrDAAo3aIKqJ2tzEJDyHUdi7m2U6iWvFc0d24vyRcUXNCfs?=
 =?us-ascii?Q?wd03kGv3cH6/HXyRl44ny2QzI5O7j89d6nOVsRyaHY938X0+1TNKUzC3D1T8?=
 =?us-ascii?Q?xHj1NIEcEnIuVCvrdLSJbmYwfvIHuisMTFSbYUQsPvBu0hQR7YYeMrkaBnvV?=
 =?us-ascii?Q?ix2NY8kefHTYOf+yQGcPC8g2b/yi1xiXoyzouFQCVh52IyIF+8d87UuJahSh?=
 =?us-ascii?Q?kpg6RaCigsEmqOsQLQUzfVdo0xiHu85BhCCxg2eJNeb1RtQC1boFyY8jMIVS?=
 =?us-ascii?Q?CBBO5iFZ4v3SKxnp7KNDSGknBXcJ4MrmMceT6FpQ1gDu0nbwEiDNWTbdrfmw?=
 =?us-ascii?Q?YESygU4tyyLr25jstQh++1H5F0I6QWKMbd7hY7ngmS2vAx6JDNa9DJsXBhgu?=
 =?us-ascii?Q?BzXjnLYtTOY1mOOVPT3wFSd0YFaLmtjHkiPsWyhIiPDpBBFlCcfEoAdUlQn2?=
 =?us-ascii?Q?upbFw+OeH+zBopHZyN2GLjBu7UawLGYJydKcGQyw4URvcz/soKv+c/y+AdUw?=
 =?us-ascii?Q?ALKs0nAPEKyO0gfAQLTOFgHadyI6MVhb+nO8ezAc1e4g2GzbD2frGfGkl5Xg?=
 =?us-ascii?Q?k7Y+4YsMeFjr/FEThIhgrJ1OlnoJ7/cbQ5lDFz8E8i796gsFooTasWK6o3Hd?=
 =?us-ascii?Q?u2Lu1T976dj876eq6KUUB4HzhkxnkSEYhOOii5gJersyI6UBIksjoUA2G0zy?=
 =?us-ascii?Q?luEu/upl5UhOeGwZ6EiBgNtR1i/PHdgRWe5oJviH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2010802-571c-4724-1c8a-08dc57cd74b3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 13:11:51.9061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDkRB312q5BYySTiK3qIQXHPNNuUUJUvMixfQJwjM9sKT+e4jJtzT2n5hyiuGIrLybR9GZj/OABTHkiPeFT7aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6781
X-OriginatorOrg: intel.com

On 2024-04-08 at 13:58:33 +0200, Peter Zijlstra wrote:
> On Thu, Feb 29, 2024 at 05:00:18PM +0800, Abel Wu wrote:
> 
> > > According to the log, vruntime is 18435852013561943404, the
> > > cfs_rq->min_vruntime is 763383370431, the load is 629 + 2048 = 2677,
> > > thus:
> > > s64 delta = (s64)(18435852013561943404 - 763383370431) = -10892823530978643
> > >      delta * 2677 = 7733399554989275921
> > > that is to say, the multiply result overflow the s64, which turns the
> > > negative value into a positive value, thus eligible check fails.
> > 
> > Indeed.
> 
> From the data presented it looks like min_vruntime is wrong and needs
> update. If you can readily reproduce this, dump the vruntime of all
> tasks on the runqueue and see if min_vruntime is indeed correct.
>

This was the dump of all the entities on the tree, from left to right,
and also from top down in middle order traverse, when this issue happens:

[  514.461242][ T8390] cfs_rq avg_vruntime:386638640128 avg_load:2048 cfs_rq->min_vruntime:763383370431
[  514.535935][ T8390] current on_rq se 0xc5851400, deadline:18435852013562231446
			min_vruntime:18437121115753667698 vruntime:18435852013561943404, load:629


[  514.536772][ T8390] Traverse rb-tree from left to right
[  514.537138][ T8390]  se 0xec1234e0 deadline:763384870431 min_vruntime:763383370431 vruntime:763383370431 non-eligible  <-- leftmost se
[  514.537835][ T8390]  se 0xec4fcf20 deadline:763762447228 min_vruntime:763760947228 vruntime:763760947228 non-eligible

[  514.538539][ T8390] Traverse rb-tree from topdown
[  514.538877][ T8390]  middle se 0xec1234e0 deadline:763384870431 min_vruntime:763383370431 vruntime:763383370431 non-eligible   <-- root se
[  514.539605][ T8390]  middle se 0xec4fcf20 deadline:763762447228 min_vruntime:763760947228 vruntime:763760947228 non-eligible

The tree looks like:

          se (0xec1234e0)
                  |
                  |
                  ----> se (0xec4fcf20)


The root se 0xec1234e0 is also the leftmost se, its min_vruntime and vruntime are both 763383370431,
which is aligned with cfs_rq->min_vruntime. It seems that the cfs_rq's min_vruntime gets updated correctly,
because it is monotonic increasing.

My guess is that, for some reason, one newly forked se in a newly created task group, in the rb-tree has not
been picked for a long time(maybe not eligible). Its vruntime stopped at the negative value(near (unsigned long)(-(1LL << 20))
for a long time, its vruntime is long behind the cfs_rq->vruntime, thus the overflow happens.


thanks,
Chenyu

> > > So where is this insane huge vruntime 18435852013561943404 coming from?
> > > My guess is that, it is because the initial value of cfs_rq->min_vruntime
> > > is set to (unsigned long)(-(1LL << 20)). If the task(watchdog in this case)
> > > seldom scheduled in, its vruntime might not move forward too much and
> > > remain its original value by previous place_entity().
> > 
> > So why not just initialize to 0? The (unsigned long)(-(1LL << 20))
> > thing is dangerous as it can easily blow up lots of calculations in
> > lag, key, avg_vruntime and so on.
> 
> The reason is to ensure the wrap-around logic works -- which it must,
> because with the weighting thing, the vruntime can wrap quite quickly,
> something like one day IIRC (20 bit for precision etc.)
> 
> Better to have the wrap around happen quickly after boot and have
> everybody suffer, rather than have it be special and hard to reproduce.

