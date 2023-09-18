Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFAD7A5517
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 23:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjIRVcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 17:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIRVcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 17:32:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DDD8E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 14:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695072756; x=1726608756;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=++DsZXe82KwhHD7B78HG2bk01/BLmeUCNtemDeE+BEI=;
  b=CnI8kvUKpny3Ab68Z16QO65iZJU6UUsB86eeskelVgkKT3oM85Lt0US6
   gJkJhufb7cJruiJ01sArpSdMe/15LDEh5JC6oXWHC+C/vbNdncu1QVCsL
   Coqy36qmJFmTgKLAmbznVztdq+9Q1/KIwCw65aeqSKtmlRaOz/M6Z1ePl
   G/xzTvtIyyUuP6Uln9dlKWZrhCt/vo6q93hbcTfgzuHlwetC5G1Z8PWns
   mPfyLrpKgd5Mh2JjWCf8TBR9W8Vat9/6km0QIrt6i9Cpie08zL6E9VOn/
   l3o6fRd628XMWgeYhBXMUltYCQko5Unhd+PbED60QBVXw1AOc0W22CSaw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="383596386"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="383596386"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 14:32:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="1076731280"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="1076731280"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2023 14:32:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 14:32:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 14:32:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 14:32:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AC61Q9izcyNFw1NNXXTyglc45P0PmHkMevf3dRi97deAnzTYQJbUUss2i8+DoATG9vfKYVc3B4IDYrN3qB6H+8wT2K7XgM5jWooDynwBkAr6oCxXFBRSk6vVritj4B6hl2KbvTU5YdUEh9j3pWOSR7dU02InUIsLK9g9fPUlKvaiT5FZeqVzMHbXh4V7iaLKypZAM5A5ksANFcWIMsQ8TgLeZaSJ5rKjiD7k+wbAHE0qbh9Zxf2JJ8lrDp4VdLs1LdrOt4b8dtfdOrBBHgLs4IGXSY1WpnZt/bplK854UpO3r+nW0/XQUe689b/euaqk9zPo84/TCa7AB4eftUGsxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVcOVsQqSdvBC+QpDyPfT2O5KMHTDJ5sYjTnbdZxqws=;
 b=eWNRmzIG2EODGs3f1S9ZnuglqPVtM4L19n6wnmzrPWGPOcpfS/gx/srrQud7tjVOIqqG6DhhHMrCqMkv5sPi/rvV7UUyBofZ/x938Ea50tu/kYJfbib3DWEIkwSay56nhTtjv33km+jgK9J9iATlwVwo0ank7Hd9pGlexea3D7TMUNTbl2yKPtsl3qW1Hyo50YIHy6ErKWJC76z39gTAGRIgywRkwl05GcMB6MY/s3DaNRIHeN6OiXJmZyUU0WGHca3swXSqkzAAWC0GKjuTGNd9gkISMboGzF1DxwxtjkVltE1PB9fLjggsuqHWNBfK23casyYsslLmq7fOQ+wJHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS7PR11MB5992.namprd11.prod.outlook.com (2603:10b6:8:73::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 21:32:33 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 21:32:32 +0000
Date:   Mon, 18 Sep 2023 14:32:30 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Tomas Glozar <tglozar@redhat.com>, Ira Weiny <ira.weiny@intel.com>
CC:     =?utf-8?B?VG9tw6HFoQ==?= Glozar <tglozar@gmail.com>,
        <nvdimm@lists.linux.dev>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nd_btt: Make BTT lanes preemptible
Message-ID: <6508c1ee9595a_3947ba29473@iweiny-mobl.notmuch>
References: <20230912082440.325189-1-tglozar@gmail.com>
 <65036a57ea900_35db10294ec@iweiny-mobl.notmuch>
 <CAP4=nvTKFWHZgrMmfWtRmsjBZ8gijktyJ3rpsNyspqZhL8+Fzg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP4=nvTKFWHZgrMmfWtRmsjBZ8gijktyJ3rpsNyspqZhL8+Fzg@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS7PR11MB5992:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db451b2-328c-4035-9ea2-08dbb88ec49d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QgIy2CL8RiB7PC9oeFT9e5gJ5NhTjM6AuDjHmBYkmwDZE75QuZDDEWzDpl/ouJpLzq9NyY21CFROUYGH+D8bOE7l7teodIZI2YoIa/8Fkosj4qFo7m7nBdKuJC0PIkq04Z2q8bwoiPeJat7ugn9EMGx+6m/dRO4TsD7yMDvJu68gxft6WZMirUKZc1txSf3xFinAxngK9Dbo0rxtZb4RctGv/ntd+tNVJVu0WwRXutOlgOGV/bX6LtxID8IDwavqxCljV47DJZwPiWpA48/lzoQtwi1XGS9krO1SmmNLuPOenFxoJ0RjKkekePwrPghDdPfgKa/T1UyB+uMD5nFt8Q4dblSr8jMI/+vm3DfGm/HcbMpIQ8hPXoMrITpRv7STogqv/4BK8bOpdyLnqtMf6W3RZnsLNu4/w7kJdG7lgBgYEysIsPv1za+jBorPxKsPzpQdLTj/ZURGyGOfRd7FuoBNzrnViRYUS3LIGHY/yUKvo3FfggQlp4H26QZ5yMBwcKGx1GKN9ygVt3bKhI5QlIBdCULgLvR+wR2ja1mUIXZlBBmGSF3VjbYRuL2qJify
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199024)(186009)(1800799009)(82960400001)(38100700002)(86362001)(6506007)(478600001)(2906002)(66556008)(66946007)(66476007)(5660300002)(4326008)(8676002)(44832011)(66574015)(6512007)(9686003)(83380400001)(8936002)(110136005)(41300700001)(316002)(6486002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEJIQVkrOG15bzBUVk9EdnpBcnZtME82TEpwSDVuSmxQTWlLWG5Gcy9ac1I0?=
 =?utf-8?B?QmxndUlnQU94N1VTL09Xc2xsT1BTaTVJcFhZdUlDWUo2T015ejVkckdxNXpD?=
 =?utf-8?B?ZjcraFRiWWJtTjh1ejRxbTNGeGhleEkwdDVZb2FNVFpCcERzUGhvZmpuc2pG?=
 =?utf-8?B?THVuaUNpSGFickhKSmMxWGh5K3BrNGdHWFFQWFgrVWlobEZVSW1UMFcyOEVW?=
 =?utf-8?B?UFFuMytaSGxKRTA3TGF3WHhSQ2h2eEJDdkZtTDFMM2Y3SUozZ2FFWVVhWmVl?=
 =?utf-8?B?YS9XMWJySWxJc09vL2ZiVXBGN0QxclpFUHJHcUZ6OWhzM1h5Z1ppRzVGM05Q?=
 =?utf-8?B?VzVwRGhDTDQ0TjcwQnZQTUkvUWpJTEhmOGRjZFVtRFBtUVU1QUxFdTZwT2M3?=
 =?utf-8?B?dkxjMDZOT2lnUjB1SzA5TUJhdUpSYWZPV3NwK25MVlFiTWpuTEJrbFlqMnR0?=
 =?utf-8?B?OWtEYXNGdnIxbEpnQnpZT01ndmdSZDArSXlGZ2QwSDd1dWRwQ0l6c1ZsaElt?=
 =?utf-8?B?b0F5Y3Z3NzErQXJLVjBYRXJVdnVmNGUxY21GZlZiSE5mbjhnSVpKc0NGSWVl?=
 =?utf-8?B?MkpLUVhSNk1WamU2TUpTRjR4Qmp3aWFXTzR1QlhlejJ3UFplNEsvVTVUWEpj?=
 =?utf-8?B?RzNFNFFYWFNlcEVvVkJwUTZTb3dSdDB0UnhNRmFCam02ZzBXWDF1a010Nk1Z?=
 =?utf-8?B?dTVKQk5hcW9ZeGtic2dWNksxUVU3QW1acnNhbnp1TWxTM3kwTzFoa1YrQ2RU?=
 =?utf-8?B?dVpacy9sU3lHVWRDNUxRSXdUTGFEb3NBMVg2NGVvZXE5d0s0SkdUWjNZZ1ZU?=
 =?utf-8?B?Q3dwb2p2NHdBdWVSQ1Q2Z3lCUEI0VWltc2ljNzRiY1VpVmRTZ1U0MnZWYTMz?=
 =?utf-8?B?MXlieVVJYWpiREpNNzZOaERmVHdQelJEOG1waVhvRDRDd1NFMi9aMzhLQUhP?=
 =?utf-8?B?RzBEaXlIUkNmL1lFRXRrR1dqZGhOSXdKVnNrSld1WFRTNmpsM3JrUWhEMDhC?=
 =?utf-8?B?SnArdkFsdUovWDJ5VFpIZ0liRHdMSFFGdHd5VFFvVnl6aU9mdFlqZkJ1NDRM?=
 =?utf-8?B?WWRVK3BWUXRQeS8zcVRZWjN5dy9RVFlNVmROVTR5cDQxSkxsZWFvQ0hGSEtu?=
 =?utf-8?B?TmQwYVNwWjdNY1RCWGxpOGt6eUdkNS9SbEdQV1V5Q0wwdFJCdmovaEovTWxl?=
 =?utf-8?B?TmgzaFpDWmpwTldBYmo0TXpvakp1dFoxQkQvL3FPaThUNXkvSjM4Vm1sVm5a?=
 =?utf-8?B?R2N5M2thQXhmYjNvaCt4ZzVkK0ZCbVZXTFhGV2p1N3hob3JJL1lHMHFDcGhG?=
 =?utf-8?B?VzVROTR5eFZaZWcwOVFaWUtKQ0lSazRnTXJ3Q1pLTWdnSEhPMGx4a3JqYXVq?=
 =?utf-8?B?bEx2bjBLN2YyTCtPUEloSVFWRzVXdHl1SEcxeVZKRWlqYVdzTHRReU4wbmk5?=
 =?utf-8?B?Y2FmNzBnNDE0cnhUM292Y1ZLME1ORmEzTWQrd0R1aXBOTnFsTzQvSXVkR29Z?=
 =?utf-8?B?SFJUamdDV0ZDMktwb05pczRXSmZac25sSGViRmxpMkxoTWtnTUdLUjg3NW5B?=
 =?utf-8?B?YVlVT3NrbFphY3JXN3ZJT3NON3FvZlZHUS9WM25DRU5hWHdCWHhzUmUxNWRS?=
 =?utf-8?B?NTZCZEpHYnVqOGZ4eEtTODZFL0VnRWhuV0lZSW5UTldYbmVJQU1TYWlsSVBJ?=
 =?utf-8?B?WkNDRzBwbFAxbHN0SG1GYlpRYmUwUVZFbThKUCtEQmFYU0hYbmZnQTZJTjJm?=
 =?utf-8?B?U3kwWkMxT0dXZ0VCSVhzL3BsR0lzclJKellHbmJBSUhDNjNqT2R6VHpyL1Jm?=
 =?utf-8?B?WmQvaW1vMTNuSksyWVpnd1RpV2p6U0JIRFZ0SU5lQlEzNGU5WFJ4b256dGp2?=
 =?utf-8?B?UnhvSHQ5SWZGYWdqc3hPcjR0a3daNENxOHNadlZnMno2UWpJYUt4bStsZFZ4?=
 =?utf-8?B?U3FzVHpMUzFVN2hrcEQwcTIzSW93dHJTQmJBZmVEKzhsS3FVSU0yRis3T0JG?=
 =?utf-8?B?MWdqTGovVG8wc3BWeVh4N2pZQmh1bGQ3ODhrR1JGVnVQdTh1MUJXN21icVgr?=
 =?utf-8?B?OHl4QUxncjdOMFFzUnNjR0lFRWFqdm40RlVWUjhid293VWZwS1hRTDl5cHAy?=
 =?utf-8?Q?j7Cx76492WeucUfs0KET3FQhV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db451b2-328c-4035-9ea2-08dbb88ec49d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 21:32:32.8885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5nUmQKrmbsCylnGXye9fABKvAX3vdwTFDwg7Df96D+kRR0HEQ8XQLRmR3FTa2OAj+1tR3//rGgk+cb8wGZjujA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5992
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Glozar wrote:
> čt 14. 9. 2023 v 22:18 odesílatel Ira Weiny <ira.weiny@intel.com> napsal:
> > Is the bug in 1 of 2 places?
> >
> > 1) When btt_write_pg()->lock_map() (when the number of lanes is < number
> >    of cpus) and the lane is acquired is called?
> >
> > *or*
> >
> > 2) When nd_region_acquire_lane() internally trys to take it's lock?
> >
> > A copy/paste of the BUG observed would have been more clear I think.
> >
> 
> The BUG was observed on btt_write_pg()->lock_map(), but I assume the
> BUG will also happen on the lock in nd_region_acquire_lane, since that
> is also a spin lock, i.e. a sleeping lock on RT.
> 
> BUG observed in dmesg when running ndctl tests on RT kernel without the patch:

Thanks for clarifying.  Could you respin the patch with the text below?
That would have saved me a lot of time digging to see what the code path
was.

...
	BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
	in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 4903, name: libndctl
	preempt_count: 1, expected: 0
	RCU nest depth: 0, expected: 0
	1 lock held by libndctl/4903:
	 #0: ffff8c184a270060 (&arena->map_locks[i].lock){+.+.}-{2:2}, at: btt_write_pg+0x2d7/0x500 [nd_btt]
	Preemption disabled at:
	[<ffffffffc1313db5>] nd_region_acquire_lane+0x15/0x90 [libnvdimm]
	Call Trace:
	 <TASK>
	 dump_stack_lvl+0x8e/0xb0
	 __might_resched+0x19b/0x250
	 rt_spin_lock+0x4c/0x100
	 ? btt_write_pg+0x2d7/0x500 [nd_btt]
	 btt_write_pg+0x2d7/0x500 [nd_btt]
	 ? local_clock_noinstr+0x9/0xc0
	 btt_submit_bio+0x16d/0x270 [nd_btt]
	 __submit_bio+0x48/0x80
	 __submit_bio_noacct+0x7e/0x1e0
	 submit_bio_wait+0x58/0xb0
	 __blkdev_direct_IO_simple+0x107/0x240
	 ? inode_set_ctime_current+0x51/0x110
	 ? __pfx_submit_bio_wait_endio+0x10/0x10
	 blkdev_write_iter+0x1d8/0x290
	 vfs_write+0x237/0x330
...

With a respin including this trace:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
