Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32D37D8EA6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 08:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345123AbjJ0G1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 02:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0G1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 02:27:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D851B1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 23:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698388021; x=1729924021;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=AbYA3efBmf211eBy53nGNXqwyluk8559MRTcfmKZBFY=;
  b=KvlT2IlPbbIDOF6a6KKdyoE7BEyPhoK+Q9rfWIgp0BG9tsoxXmSYzkgW
   fb9SJpVCZwQiBnmNvbiLaoNI46CZuiM1x49UIib5abLB+IVLwNrJrLkqb
   eBNWL43JDMbau5vDjZRNvjlTfOBsbhLZqS1v3csym2nKeWmKfcOG0TBQm
   jDdjnYLuajY99zUJxh1Gpx0tZab7c8EMEAxQebjza1e3UOcdgFHEpFEvl
   r9Vemh1Q2hDItu2U1HJFAwEp9NG0zCszRhatCY76BdEGt1sEZrUhALZQc
   xu8Wr6Vi3u+MhTU0MCLTS5nf6n+AJrsNhaQn/kqFOR6AbqLL5G2lFslWd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="418829769"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="418829769"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 23:23:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="850145353"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="850145353"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 23:23:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 23:23:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 23:23:43 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 23:23:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 26 Oct 2023 23:23:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X24x6jcZ5VAdTxdmPc70HxIc2jdc4ZS3hpLx5SP9sM49xc1b3T1fvDipJPZ+vouwfPR+x/j42VhVO+n4HkoBhzlwYJOdpMi5AzZYpC76rm4iZfmI4S6z+/mnvtkhkxj8o1rp+g0tiwmZFJxjTMd8TIsZ+gOWSFASgvcx2rsY4sGu9JQV+vJUzvlbztTDxCAgrVexxrNO2jmUYY8pitovSrQReSgv9shcE+2WIksyu9TFhHD+hOxGSphj6icqtc483QCv7m2YxyHgv0phqfjROkxPNiBXr5X/PYOXQ0ZEbwF4Dx2RdcAtiF2OZHR1mZ7LZARBzZyhHJ/zy8zBM7+z0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbLednyT4lCCltxcem3nBufgwd8U2uU2WGyLu/SzpVA=;
 b=MzgkzjZJJjtl1ATjf5eiAdD1zbC+wmNnbUmmSdAHITr+CB9GQlcVsdrRH1/8zLQzEFqQ3TIcC6u3NSe3tR14+p9ed5O5Zm656slnW9TUQongwO7F0dty51s5z5K9gs10ZpwOsYwAtrOnYGdRyxw0OCumZBRX1JdDe9YgSAdY4plO91h+G2dnIXjCgdhYinbDCRe8UMles8e1q3OEdxL7XyyqHFZF8qKi+0i+rRdXWORZSYsgLcC3Str2nOi4RkYCYsDufJbGhbGHvz28vqwAOuAMatHQYEtsRevVWx/6s52sRK1SAvg84YXrogTmlkAMJwyRyIRSkgl+5iQmIvz/MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DM4PR11MB5567.namprd11.prod.outlook.com (2603:10b6:5:39a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Fri, 27 Oct
 2023 06:23:39 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6%3]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 06:23:39 +0000
Date:   Fri, 27 Oct 2023 14:23:29 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Huang Ying <ying.huang@intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "David Hildenbrand" <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        "Pavel Tatashin" <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, Arjan Van De Ven <arjan@linux.intel.com>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH -V3 3/9] mm, pcp: reduce lock contention for draining
 high-order pages
Message-ID: <202310271441.71ce0a9-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231016053002.756205-4-ying.huang@intel.com>
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DM4PR11MB5567:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a93a50-cc32-45dc-9cbe-08dbd6b54247
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lpdtkEBqB+T8flBZ0TzMcaOm7vnBLIzotON35sV+Sp34Hsz9sP/Fs6vBm8LdfsIFpcNX5D3yQveqqK94gcrBygntYuheR7aFiwNUhOWUxDmrhW99XnW2bi2P29mgzsnF5kZX4CzjT23E0JEZGo3R8x2+AywoTgplIxeD7Kfn0+yUO3d7OrFfde7KlIUvDlU4rzyjJvNKNZkWR8ORV/eSRDF4NAfGoYmbgMIc6XelqJkOMnf5X6/jffNlxDra6y3WcgxBe4Css2s8HF7UBmAE+fXDx1p1EuJWbCEWR2mjQLQiuxgIHfpnritcM+DpjlOtT5b8c96hPCgXNOF9ORTOl2Hdqd94rnEpFD3p4lOErMzVOs9sUxoc9XSwPvgwM29AxIzxWlDhlpNx3HB4GCcI6joJAGAGSTMjvdXnvz+II7s77Q1etpcey+2Qj30yS1Uv7wkaU6QJd+H4htd8vyPgxjBwUaxdFHiLYFaIajjMzOxhh05wdcJSQK7+1DbDNfIO8UXtbSKXNTljVOVrptWWR8HNzg5VUvG+GgdTCSHQdmB5J5cZL60B2xtp89Vb900no3tNiGng8ot9mQ/bbUE3yNR5ML/oRtaWjudcvIrmzE2pxWNjsdDVRJBwixbGy2JhzEv3etVOTkEI7e761xxLuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(230373577357003)(230473577357003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(41300700001)(2906002)(30864003)(38100700002)(6636002)(54906003)(37006003)(6512007)(66556008)(316002)(82960400001)(1076003)(6506007)(2616005)(478600001)(6666004)(6486002)(66946007)(6862004)(83380400001)(966005)(86362001)(7416002)(36756003)(5660300002)(8676002)(4326008)(66476007)(8936002)(26005)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ot8KhLYxwbzO8qUu3pCR4DCllDuxc0bEUHE3HytYJCtnAbwuemQMtsDi/M?=
 =?iso-8859-1?Q?2YHOasQDuG0CYlwbrQyI8/OgqP7hy8pUzlyESpUBTcrXlNnME72dEFJ5tI?=
 =?iso-8859-1?Q?gBKZ2eT0L+8rE8XhrCjIq4Czba9SBHrk5g/moSnUd4lhb7izzohtiRJBeI?=
 =?iso-8859-1?Q?jO4yzzxYCuiN7uS0wXOij0SYZ5kUci39cy6P0m0Sgttq0aDkruJfOsE0m0?=
 =?iso-8859-1?Q?Jd7WJSz9gysJLJrw6HCURoQiiZmjM+uTq1jpKI+5TTRuYItayMFVQVCpTy?=
 =?iso-8859-1?Q?O4bogNn8fv/LZ+uf6ZV1AFh2PUq+3m6y8r9djl01+QNIiLLHGXRhY4FuJU?=
 =?iso-8859-1?Q?q+tW1oAYUqu2k0kUijTNNLoUD/v1xRs3z+KWUWp4mtTw0aElbmS7W0ZC93?=
 =?iso-8859-1?Q?tfVkH1hvNcUB98Zv2GqG2sVRhBgLfbp3JuRndjf0tUr2VA4R09v2+mloXz?=
 =?iso-8859-1?Q?aC6IDBXfbNPtXceYJLfpzhYPUWcdRUI+vdC3ye+VjN9TS+wZbq4hdaxzmG?=
 =?iso-8859-1?Q?FYIrmrWoYs+nJzoGD5P23KV9Y82+dmtfTexA3eoGNkmZNT/94Mg3kjOC5G?=
 =?iso-8859-1?Q?dL9hvcNVACMYRKyl/chjKG3ZQFfupfBtZ6YSTuO6wSXmCsp8uqbKNS8g32?=
 =?iso-8859-1?Q?R2QB0EZZVPcmBDki8s7ZpK4sZEnRIOSb7JbFFxk2Axf9vMuzLaY3ZfJWCv?=
 =?iso-8859-1?Q?oFFMQv+42vDbnkkrBF4xxOxlkS9MsBY2ZvMFtxGfYRNWylXEN6vpjcvBX4?=
 =?iso-8859-1?Q?fnkMZ9vQ0MtFXcbmWNHzLcBNmKMGXqMzAR7PyVDcUnDk1r+4upRnSY7Z6F?=
 =?iso-8859-1?Q?ORb9rLhQ2aQwmgO4d6hhsVgU8zqGOzAnTuDhn2LyGndx9TJGebb9dXpfDE?=
 =?iso-8859-1?Q?ctYcFTjxZwV0IeP5X+cg+bbisXSgp8NlSexYsqvQxcHBIvm27PU8MyAFdg?=
 =?iso-8859-1?Q?06ZrQSHtOlrg7PA9O/EwWnhC0x4tgp14/to8hebLDsUwFBUHKErw8EQ1Um?=
 =?iso-8859-1?Q?ub33qN5Tjj6soTsXm+lxm2FF8Ox1VcuIhQXE4MN4bKn6G1rApj2zxskm0F?=
 =?iso-8859-1?Q?1Mr5PhpXAGm6NBZUXy4SkN5KmuwI/xwrUbL383cltKWF7AVGZaW4Ue4mCZ?=
 =?iso-8859-1?Q?ypOu30GDsTCqSZo1mnN5Ffilr4Sk3UbDGs1XKawY51FAVFEsUlD060BqU7?=
 =?iso-8859-1?Q?XjA3Rfx+otvoZo0O4c1T9KwepIRp6Zb6UhoBO/X4w6FXUHH3xthiL7Tb9g?=
 =?iso-8859-1?Q?wbCqo1izXmah2fiLcR5PzAUhFZa8VBPtjMnN+CKRcM1ZjFLPNo4Mgy71mo?=
 =?iso-8859-1?Q?HurfTSfJn3AuTuIXtiBQUpF7XBPR+XFB1DJGR/y+ZvbbD16lw02PsBtwTw?=
 =?iso-8859-1?Q?CND1B9V5oDt2aGVvYOXhOUO+lkQX4r0aZdiyKS48J78w9iBUe4FnSbCrUF?=
 =?iso-8859-1?Q?h+QbWqMkC5FA5w5QMDI+B3UXpmsiLp6CTr0iVywgrArgAJVB96yl6K1iIM?=
 =?iso-8859-1?Q?z/E/KO2DKfCx8RiYKIYEek2lSRNXZKU3lpSvy78E++x65HRF+MVVGjH9sc?=
 =?iso-8859-1?Q?7JAo0td1Pzp8GqhW73DDyOba9MkTmqu6GNpUyU79+vg5Xp4wchjDoKvFSm?=
 =?iso-8859-1?Q?CronQrmLVHpxmJ1mrVL2Za0DsDl2juwMEzi/apcoPn2EJDguc/Jkg7YQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a93a50-cc32-45dc-9cbe-08dbd6b54247
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 06:23:39.7332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FzAgxPivW+LbKXKWHEZdiNvVBwWU9rmf90eaoptZ8sH3OSWJ3zklwCm+U6n2zE9eIDZGfeRVfFZWsS/Jy+oLaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5567
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a 14.6% improvement of netperf.Throughput_Mbps on:


commit: f5ddc662f07d7d99e9cfc5e07778e26c7394caf8 ("[PATCH -V3 3/9] mm, pcp: reduce lock contention for draining high-order pages")
url: https://github.com/intel-lab-lkp/linux/commits/Huang-Ying/mm-pcp-avoid-to-drain-PCP-when-process-exit/20231017-143633
base: https://git.kernel.org/cgit/linux/kernel/git/gregkh/driver-core.git 36b2d7dd5a8ac95c8c1e69bdc93c4a6e2dc28a23
patch link: https://lore.kernel.org/all/20231016053002.756205-4-ying.huang@intel.com/
patch subject: [PATCH -V3 3/9] mm, pcp: reduce lock contention for draining high-order pages

testcase: netperf
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
parameters:

	ip: ipv4
	runtime: 300s
	nr_threads: 200%
	cluster: cs-localhost
	send_size: 10K
	test: SCTP_STREAM_MANY
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231027/202310271441.71ce0a9-oliver.sang@intel.com

=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/send_size/tbox_group/test/testcase:
  cs-localhost/gcc-12/performance/ipv4/x86_64-rhel-8.3/200%/debian-11.1-x86_64-20220510.cgz/300s/10K/lkp-icl-2sp2/SCTP_STREAM_MANY/netperf

commit: 
  c828e65251 ("cacheinfo: calculate size of per-CPU data cache slice")
  f5ddc662f0 ("mm, pcp: reduce lock contention for draining high-order pages")

c828e65251502516 f5ddc662f07d7d99e9cfc5e0777 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     26471           -11.1%      23520        uptime.idle
 2.098e+10           -14.1%  1.802e+10        cpuidle..time
 5.798e+08           +14.3%  6.628e+08        cpuidle..usage
 1.329e+09           +14.7%  1.525e+09        numa-numastat.node0.local_node
 1.329e+09           +14.7%  1.525e+09        numa-numastat.node0.numa_hit
 1.336e+09           +14.6%  1.531e+09        numa-numastat.node1.local_node
 1.336e+09           +14.6%  1.531e+09        numa-numastat.node1.numa_hit
 1.329e+09           +14.7%  1.525e+09        numa-vmstat.node0.numa_hit
 1.329e+09           +14.7%  1.525e+09        numa-vmstat.node0.numa_local
 1.336e+09           +14.6%  1.531e+09        numa-vmstat.node1.numa_hit
 1.336e+09           +14.6%  1.531e+09        numa-vmstat.node1.numa_local
     26.31 ± 12%     +33.0%      35.00 ± 10%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.sctp_datamsg_from_user.sctp_sendmsg_to_asoc
    229.00 ± 13%     -24.7%     172.33 ±  5%  perf-sched.wait_and_delay.count.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.sctp_datamsg_from_user.sctp_sendmsg_to_asoc
    929.50 ±  2%      +8.2%       1005 ±  4%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     26.30 ± 12%     +33.0%      35.00 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.sctp_datamsg_from_user.sctp_sendmsg_to_asoc
     53.98           -14.1%      46.36        vmstat.cpu.id
     58.15           +17.6%      68.37        vmstat.procs.r
   3720385           +15.6%    4301904        vmstat.system.cs
   1991764           +14.5%    2281507        vmstat.system.in
     53.69            -7.7       46.03        mpstat.cpu.all.idle%
      2.10            +0.3        2.44        mpstat.cpu.all.irq%
      7.25            +1.3        8.58        mpstat.cpu.all.soft%
     35.74            +5.7       41.46        mpstat.cpu.all.sys%
      1.23            +0.3        1.49        mpstat.cpu.all.usr%
   2047040            +2.9%    2105598        proc-vmstat.nr_file_pages
   1377160            +4.2%    1435588        proc-vmstat.nr_shmem
 2.665e+09           +14.7%  3.056e+09        proc-vmstat.numa_hit
 2.665e+09           +14.7%  3.056e+09        proc-vmstat.numa_local
 1.534e+10           +14.6%  1.758e+10        proc-vmstat.pgalloc_normal
 1.534e+10           +14.6%  1.758e+10        proc-vmstat.pgfree
      1296           +16.3%       1507        turbostat.Avg_MHz
     49.98            +8.1       58.12        turbostat.Busy%
 5.797e+08           +14.3%  6.628e+08        turbostat.C1
     53.88            -7.6       46.34        turbostat.C1%
     50.02           -16.3%      41.88        turbostat.CPU%c1
 6.081e+08           +14.5%  6.961e+08        turbostat.IRQ
    391.82            +3.5%     405.41        turbostat.PkgWatt
      2204           +14.6%       2527        netperf.ThroughputBoth_Mbps
    564378           +14.6%     647027        netperf.ThroughputBoth_total_Mbps
      2204           +14.6%       2527        netperf.Throughput_Mbps
    564378           +14.6%     647027        netperf.Throughput_total_Mbps
    146051            +5.9%     154705        netperf.time.involuntary_context_switches
      3011           +16.8%       3516        netperf.time.percent_of_cpu_this_job_got
      8875           +16.6%      10351        netperf.time.system_time
    221.39           +18.0%     261.14        netperf.time.user_time
   2759631            +8.0%    2981144        netperf.time.voluntary_context_switches
 2.067e+09           +14.6%  2.369e+09        netperf.workload
   2920531           +34.4%    3925407        sched_debug.cfs_rq:/.avg_vruntime.avg
   3172407 ±  2%     +36.5%    4331807 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.max
   2801767           +35.2%    3787891 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.min
     45404 ±  5%     +33.3%      60516 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.stddev
   2817265 ± 10%     +40.6%    3961862        sched_debug.cfs_rq:/.left_vruntime.max
    376003 ± 18%     +51.2%     568331 ± 13%  sched_debug.cfs_rq:/.left_vruntime.stddev
   2920531           +34.4%    3925407        sched_debug.cfs_rq:/.min_vruntime.avg
   3172407 ±  2%     +36.5%    4331807 ±  3%  sched_debug.cfs_rq:/.min_vruntime.max
   2801767           +35.2%    3787891 ±  2%  sched_debug.cfs_rq:/.min_vruntime.min
     45404 ±  5%     +33.3%      60516 ± 11%  sched_debug.cfs_rq:/.min_vruntime.stddev
   2817265 ± 10%     +40.6%    3961862        sched_debug.cfs_rq:/.right_vruntime.max
    376003 ± 18%     +51.2%     568331 ± 13%  sched_debug.cfs_rq:/.right_vruntime.stddev
    157.25 ±  6%     +13.3%     178.14 ±  4%  sched_debug.cfs_rq:/.util_est_enqueued.avg
   4361500           +15.5%    5035528        sched_debug.cpu.nr_switches.avg
   4674667           +14.7%    5363125        sched_debug.cpu.nr_switches.max
   3947619           +14.1%    4504637 ±  2%  sched_debug.cpu.nr_switches.min
      0.56            -3.7%       0.54        perf-stat.i.MPKI
 2.293e+10           +14.3%  2.622e+10        perf-stat.i.branch-instructions
 1.449e+08           +15.6%  1.675e+08        perf-stat.i.branch-misses
      2.15            -0.1        2.05        perf-stat.i.cache-miss-rate%
  67409238           +10.2%   74274510        perf-stat.i.cache-misses
 3.199e+09           +15.7%  3.702e+09        perf-stat.i.cache-references
   3765045           +15.6%    4353228        perf-stat.i.context-switches
      1.42            +1.7%       1.45        perf-stat.i.cpi
 1.717e+11           +16.5%      2e+11        perf-stat.i.cpu-cycles
      5094           +51.1%       7695 ±  3%  perf-stat.i.cpu-migrations
      2554            +5.7%       2699        perf-stat.i.cycles-between-cache-misses
  3.28e+10           +14.5%  3.756e+10        perf-stat.i.dTLB-loads
    329792 ± 11%     +37.3%     452936 ± 15%  perf-stat.i.dTLB-store-misses
  2.04e+10           +14.7%  2.339e+10        perf-stat.i.dTLB-stores
 1.205e+11           +14.4%  1.379e+11        perf-stat.i.instructions
      0.71            -1.7%       0.69        perf-stat.i.ipc
      1.34           +16.5%       1.56        perf-stat.i.metric.GHz
    221.29            +7.4%     237.74        perf-stat.i.metric.K/sec
    619.67           +14.5%     709.77        perf-stat.i.metric.M/sec
   7031738           +14.3%    8034255        perf-stat.i.node-load-misses
     79.94            -1.3       78.62        perf-stat.i.node-store-miss-rate%
   3349862 ±  2%      +9.2%    3656880        perf-stat.i.node-stores
      0.56            -3.7%       0.54        perf-stat.overall.MPKI
      2.11            -0.1        2.01        perf-stat.overall.cache-miss-rate%
      1.42            +1.8%       1.45        perf-stat.overall.cpi
      2546            +5.7%       2692        perf-stat.overall.cycles-between-cache-misses
      0.70            -1.8%       0.69        perf-stat.overall.ipc
     79.91            -1.4       78.54        perf-stat.overall.node-store-miss-rate%
 2.286e+10           +14.3%  2.614e+10        perf-stat.ps.branch-instructions
 1.444e+08           +15.6%  1.669e+08        perf-stat.ps.branch-misses
  67192773           +10.2%   74037940        perf-stat.ps.cache-misses
 3.189e+09           +15.7%   3.69e+09        perf-stat.ps.cache-references
   3753095           +15.6%    4339552        perf-stat.ps.context-switches
 1.711e+11           +16.5%  1.994e+11        perf-stat.ps.cpu-cycles
      5078           +51.1%       7674 ±  3%  perf-stat.ps.cpu-migrations
 3.269e+10           +14.5%  3.743e+10        perf-stat.ps.dTLB-loads
    328489 ± 11%     +37.3%     451131 ± 15%  perf-stat.ps.dTLB-store-misses
 2.033e+10           +14.7%  2.331e+10        perf-stat.ps.dTLB-stores
 1.201e+11           +14.4%  1.374e+11        perf-stat.ps.instructions
   7009249           +14.3%    8009170        perf-stat.ps.node-load-misses
   3339511 ±  2%      +9.2%    3645997        perf-stat.ps.node-stores
 3.635e+13           +14.3%  4.155e+13        perf-stat.total.instructions
      4.40 ±  2%      -1.5        2.87        perf-profile.calltrace.cycles-pp.skb_release_data.kfree_skb_reason.sctp_recvmsg.inet_recvmsg.sock_recvmsg
      5.83            -1.4        4.41        perf-profile.calltrace.cycles-pp.kfree_skb_reason.sctp_recvmsg.inet_recvmsg.sock_recvmsg.____sys_recvmsg
      1.92 ±  3%      -1.4        0.55        perf-profile.calltrace.cycles-pp.free_unref_page.skb_release_data.kfree_skb_reason.sctp_recvmsg.inet_recvmsg
     22.33            -1.3       21.03        perf-profile.calltrace.cycles-pp.sctp_recvmsg.inet_recvmsg.sock_recvmsg.____sys_recvmsg.___sys_recvmsg
     22.42            -1.3       21.12        perf-profile.calltrace.cycles-pp.inet_recvmsg.sock_recvmsg.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg
     22.75            -1.3       21.48        perf-profile.calltrace.cycles-pp.sock_recvmsg.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg.do_syscall_64
     23.44            -1.2       22.20        perf-profile.calltrace.cycles-pp.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
     24.65            -1.2       23.47        perf-profile.calltrace.cycles-pp.___sys_recvmsg.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg
     25.14            -1.2       23.98        perf-profile.calltrace.cycles-pp.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg
     25.46            -1.1       24.31        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg
     25.59            -1.1       24.46        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recvmsg
     26.47            -1.1       25.36        perf-profile.calltrace.cycles-pp.recvmsg
      3.57 ±  6%      -0.6        2.93 ±  9%  perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages.__kmalloc_large_node.__kmalloc_node_track_caller
      5.22 ±  2%      -0.4        4.79        perf-profile.calltrace.cycles-pp.__alloc_pages.__kmalloc_large_node.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
      4.76 ±  2%      -0.4        4.33        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.__kmalloc_large_node.__kmalloc_node_track_caller.kmalloc_reserve
      0.96            -0.4        0.59 ±  2%  perf-profile.calltrace.cycles-pp.release_sock.sctp_recvmsg.inet_recvmsg.sock_recvmsg.____sys_recvmsg
      3.16 ±  2%      -0.3        2.84        perf-profile.calltrace.cycles-pp.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb.sctp_packet_transmit.sctp_outq_flush
      3.14 ±  2%      -0.3        2.82        perf-profile.calltrace.cycles-pp.__kmalloc_large_node.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb.sctp_packet_transmit
      3.18 ±  2%      -0.3        2.86        perf-profile.calltrace.cycles-pp.kmalloc_reserve.__alloc_skb.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter
      3.44 ±  2%      -0.3        3.13        perf-profile.calltrace.cycles-pp.__alloc_skb.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm
      1.62 ±  3%      -0.3        1.34 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.rmqueue.get_page_from_freelist.__alloc_pages.__kmalloc_large_node
      1.49 ±  3%      -0.3        1.22 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.rmqueue.get_page_from_freelist.__alloc_pages
      1.46 ±  2%      -0.2        1.25 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__free_pages_ok.skb_release_data.kfree_skb_reason
      1.62 ±  2%      -0.2        1.43 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__free_pages_ok.skb_release_data.kfree_skb_reason.sctp_recvmsg
      1.99 ±  2%      -0.2        1.80        perf-profile.calltrace.cycles-pp.__free_pages_ok.skb_release_data.kfree_skb_reason.sctp_recvmsg.inet_recvmsg
      0.76            -0.2        0.58        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      0.85            -0.1        0.74        perf-profile.calltrace.cycles-pp.__slab_free.sctp_recvmsg.inet_recvmsg.sock_recvmsg.____sys_recvmsg
      0.84            -0.1        0.73        perf-profile.calltrace.cycles-pp.free_unref_page_commit.free_unref_page.skb_release_data.consume_skb.sctp_chunk_put
      1.37            -0.1        1.28        perf-profile.calltrace.cycles-pp.free_unref_page.skb_release_data.consume_skb.sctp_chunk_put.sctp_outq_sack
      2.65            -0.1        2.57        perf-profile.calltrace.cycles-pp.kmalloc_reserve.__alloc_skb._sctp_make_chunk.sctp_make_datafrag_empty.sctp_datamsg_from_user
      2.56            -0.1        2.48        perf-profile.calltrace.cycles-pp.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb._sctp_make_chunk.sctp_make_datafrag_empty
      2.49 ±  2%      -0.1        2.42        perf-profile.calltrace.cycles-pp.__kmalloc_large_node.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb._sctp_make_chunk
      1.92            -0.1        1.85        perf-profile.calltrace.cycles-pp.skb_release_data.consume_skb.sctp_chunk_put.sctp_outq_sack.sctp_cmd_interpreter
      0.62            +0.0        0.64        perf-profile.calltrace.cycles-pp.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.sctp_recvmsg.inet_recvmsg
      0.65            +0.0        0.68        perf-profile.calltrace.cycles-pp.sctp_chunk_put.sctp_ulpevent_free.sctp_recvmsg.inet_recvmsg.sock_recvmsg
      0.89            +0.0        0.93        perf-profile.calltrace.cycles-pp.copy_msghdr_from_user.___sys_recvmsg.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.24            +0.0        1.28        perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.sctp_data_ready
      0.56 ±  2%      +0.0        0.60        perf-profile.calltrace.cycles-pp.sctp_packet_config.sctp_outq_select_transport.sctp_outq_flush_data.sctp_outq_flush.sctp_cmd_interpreter
      1.32            +0.0        1.36        perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.sctp_data_ready.sctp_ulpq_tail_event
      1.29            +0.0        1.33        perf-profile.calltrace.cycles-pp.sctp_ulpevent_free.sctp_recvmsg.inet_recvmsg.sock_recvmsg.____sys_recvmsg
      0.71 ±  2%      +0.0        0.75        perf-profile.calltrace.cycles-pp.sctp_outq_select_transport.sctp_outq_flush_data.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm
      0.61            +0.0        0.66        perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.schedule_timeout
      0.62            +0.1        0.67        perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending
      1.50            +0.1        1.56        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.sctp_data_ready.sctp_ulpq_tail_event.sctp_ulpq_tail_data
      1.58            +0.1        1.64        perf-profile.calltrace.cycles-pp.__wake_up_common_lock.sctp_data_ready.sctp_ulpq_tail_event.sctp_ulpq_tail_data.sctp_cmd_interpreter
      0.70            +0.1        0.76        perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.sctp_skb_recv_datagram
      1.02            +0.1        1.08        perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single
      2.02            +0.1        2.09        perf-profile.calltrace.cycles-pp.sctp_outq_flush_data.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND
      1.86            +0.1        1.93        perf-profile.calltrace.cycles-pp.sctp_data_ready.sctp_ulpq_tail_event.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm
      0.76            +0.1        0.83        perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single
      0.73            +0.1        0.80        perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      0.89            +0.1        0.96        perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.82            +0.1        0.89        perf-profile.calltrace.cycles-pp.__sk_mem_reduce_allocated.sctp_wfree.skb_release_head_state.consume_skb.sctp_chunk_put
      0.95            +0.1        1.03        perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.06            +0.1        2.14        perf-profile.calltrace.cycles-pp.sctp_ulpq_tail_event.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
      3.68            +0.1        3.76        perf-profile.calltrace.cycles-pp.copyin._copy_from_iter.sctp_user_addto_chunk.sctp_datamsg_from_user.sctp_sendmsg_to_asoc
      0.98            +0.1        1.06        perf-profile.calltrace.cycles-pp.__sk_mem_reduce_allocated.skb_release_head_state.kfree_skb_reason.sctp_recvmsg.inet_recvmsg
      1.34            +0.1        1.43        perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single
      1.38            +0.1        1.47        perf-profile.calltrace.cycles-pp.sctp_wfree.skb_release_head_state.consume_skb.sctp_chunk_put.sctp_outq_sack
      1.54            +0.1        1.63        perf-profile.calltrace.cycles-pp.skb_release_head_state.consume_skb.sctp_chunk_put.sctp_outq_sack.sctp_cmd_interpreter
      1.25 ±  2%      +0.1        1.35        perf-profile.calltrace.cycles-pp.__sk_mem_raise_allocated.__sk_mem_schedule.sctp_sendmsg_to_asoc.sctp_sendmsg.sock_sendmsg
      1.28 ±  2%      +0.1        1.38        perf-profile.calltrace.cycles-pp.__sk_mem_schedule.sctp_sendmsg_to_asoc.sctp_sendmsg.sock_sendmsg.____sys_sendmsg
      1.82            +0.1        1.93        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt
      2.00            +0.1        2.11        perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter
      1.39            +0.1        1.50        perf-profile.calltrace.cycles-pp.skb_release_head_state.kfree_skb_reason.sctp_recvmsg.inet_recvmsg.sock_recvmsg
      4.39            +0.1        4.51        perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      2.68            +0.2        2.84        perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      2.98            +0.2        3.14        perf-profile.calltrace.cycles-pp.sctp_ulpevent_make_rcvmsg.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
      1.88            +0.2        2.06        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg
      0.34 ± 70%      +0.2        0.54        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_timeout.sctp_skb_recv_datagram
     10.32            +0.2       10.53        perf-profile.calltrace.cycles-pp.sctp_do_sm.sctp_primitive_SEND.sctp_sendmsg_to_asoc.sctp_sendmsg.sock_sendmsg
      3.60            +0.2        3.81        perf-profile.calltrace.cycles-pp.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg.sock_recvmsg.____sys_recvmsg
      1.94            +0.2        2.14        perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg
      2.20            +0.2        2.41        perf-profile.calltrace.cycles-pp.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg.sock_recvmsg
     10.93            +0.2       11.16        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     10.51            +0.2       10.74        perf-profile.calltrace.cycles-pp.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND.sctp_sendmsg_to_asoc.sctp_sendmsg
      7.26            +0.2        7.50        perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.sctp_recvmsg
     11.17            +0.2       11.42        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      5.40            +0.2        5.64        perf-profile.calltrace.cycles-pp.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv
     11.25            +0.2       11.50        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      7.38            +0.3        7.64        perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.sctp_recvmsg.inet_recvmsg
     20.03            +0.3       20.29        perf-profile.calltrace.cycles-pp.sctp_backlog_rcv.__release_sock.release_sock.sctp_sendmsg.sock_sendmsg
     20.09            +0.3       20.36        perf-profile.calltrace.cycles-pp.__release_sock.release_sock.sctp_sendmsg.sock_sendmsg.____sys_sendmsg
     20.30            +0.3       20.57        perf-profile.calltrace.cycles-pp.release_sock.sctp_sendmsg.sock_sendmsg.____sys_sendmsg.___sys_sendmsg
      8.40            +0.3        8.68        perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.sctp_recvmsg.inet_recvmsg.sock_recvmsg
      8.44            +0.3        8.72        perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.sctp_recvmsg.inet_recvmsg.sock_recvmsg.____sys_recvmsg
     11.85            +0.3       12.14        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     11.22            +0.3       11.52        perf-profile.calltrace.cycles-pp.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND
     13.26            +0.3       13.61        perf-profile.calltrace.cycles-pp.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND.sctp_sendmsg_to_asoc
     13.21            +0.4       13.59        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     13.25            +0.4       13.64        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     13.24            +0.4       13.62        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     13.34            +0.4       13.74        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     15.70            +0.4       16.12        perf-profile.calltrace.cycles-pp.sctp_primitive_SEND.sctp_sendmsg_to_asoc.sctp_sendmsg.sock_sendmsg.____sys_sendmsg
      0.55            +0.5        1.02 ± 19%  perf-profile.calltrace.cycles-pp.__sk_mem_raise_allocated.__sk_mem_schedule.sctp_ulpevent_make_rcvmsg.sctp_ulpq_tail_data.sctp_cmd_interpreter
      0.66 ± 28%      +0.5        1.14        perf-profile.calltrace.cycles-pp.__sk_mem_schedule.sctp_ulpevent_make_rcvmsg.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.sctp_sf_eat_data_6_2.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv.ip_protocol_deliver_rcu
     51.26            +0.5       51.80        perf-profile.calltrace.cycles-pp.sctp_sendmsg.sock_sendmsg.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg
     15.28            +0.5       15.82        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     51.76            +0.6       52.32        perf-profile.calltrace.cycles-pp.sock_sendmsg.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg.do_syscall_64
     53.77            +0.6       54.34        perf-profile.calltrace.cycles-pp.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.06 ±  2%      -2.4        3.68        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      5.94 ±  2%      -2.2        3.75        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      6.84            -1.9        4.97        perf-profile.children.cycles-pp.skb_release_data
      3.64            -1.7        1.92        perf-profile.children.cycles-pp.free_unref_page
      2.04 ±  2%      -1.7        0.34 ±  2%  perf-profile.children.cycles-pp.free_pcppages_bulk
      5.84            -1.4        4.42        perf-profile.children.cycles-pp.kfree_skb_reason
     22.43            -1.3       21.14        perf-profile.children.cycles-pp.inet_recvmsg
     22.67            -1.3       21.39        perf-profile.children.cycles-pp.sctp_recvmsg
     22.76            -1.3       21.50        perf-profile.children.cycles-pp.sock_recvmsg
     23.46            -1.2       22.22        perf-profile.children.cycles-pp.____sys_recvmsg
     24.68            -1.2       23.50        perf-profile.children.cycles-pp.___sys_recvmsg
     25.16            -1.2       24.00        perf-profile.children.cycles-pp.__sys_recvmsg
     26.69            -1.1       25.59        perf-profile.children.cycles-pp.recvmsg
     82.77            -0.5       82.24        perf-profile.children.cycles-pp.do_syscall_64
     83.14            -0.5       82.63        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      5.02            -0.5        4.53        perf-profile.children.cycles-pp.get_page_from_freelist
      5.46            -0.5        4.98        perf-profile.children.cycles-pp.__alloc_pages
      5.96            -0.5        5.50        perf-profile.children.cycles-pp.__kmalloc_node_track_caller
      6.21            -0.5        5.76        perf-profile.children.cycles-pp.kmalloc_reserve
      3.86            -0.5        3.41        perf-profile.children.cycles-pp.rmqueue
      5.88            -0.5        5.44        perf-profile.children.cycles-pp.__kmalloc_large_node
      7.47            -0.4        7.07        perf-profile.children.cycles-pp.__alloc_skb
      0.65 ±  3%      -0.3        0.30 ±  5%  perf-profile.children.cycles-pp.sctp_wait_for_sndbuf
      1.91            -0.3        1.58        perf-profile.children.cycles-pp._raw_spin_lock_bh
      1.78            -0.3        1.46        perf-profile.children.cycles-pp.lock_sock_nested
      4.43            -0.2        4.22        perf-profile.children.cycles-pp.consume_skb
      6.00            -0.2        5.80        perf-profile.children.cycles-pp.sctp_outq_sack
      5.82            -0.2        5.62        perf-profile.children.cycles-pp.sctp_chunk_put
      2.00 ±  2%      -0.2        1.82 ±  2%  perf-profile.children.cycles-pp.__free_pages_ok
      1.20            -0.2        1.04        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.27            -0.1        1.16        perf-profile.children.cycles-pp.__slab_free
      0.39            -0.1        0.32 ±  2%  perf-profile.children.cycles-pp.__free_one_page
      0.86 ±  2%      -0.1        0.79        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.42            -0.1        0.36 ±  2%  perf-profile.children.cycles-pp.__zone_watermark_ok
      0.45 ±  2%      -0.1        0.40 ±  2%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.54            -0.0        0.51        perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.65 ±  2%      -0.0        0.62        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.47 ±  2%      -0.0        0.44 ±  2%  perf-profile.children.cycles-pp.__kmalloc
      0.25 ±  3%      -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.24 ±  4%      -0.0        0.22 ±  3%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.24 ±  3%      -0.0        0.22 ±  3%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.15 ±  5%      -0.0        0.13 ±  4%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.11 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.sctp_assoc_rwnd_increase
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.ct_idle_exit
      0.12 ±  3%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.get_pfnblock_flags_mask
      0.42            +0.0        0.44        perf-profile.children.cycles-pp.free_unref_page_prepare
      0.14 ±  2%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.check_stack_object
      0.13 ±  2%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.27            +0.0        0.28        perf-profile.children.cycles-pp.update_curr
      0.22            +0.0        0.24 ±  2%  perf-profile.children.cycles-pp.__switch_to_asm
      0.16 ±  2%      +0.0        0.18 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.29 ±  2%      +0.0        0.30        perf-profile.children.cycles-pp.sctp_outq_flush_ctrl
      0.42            +0.0        0.44        perf-profile.children.cycles-pp.free_large_kmalloc
      0.13 ±  2%      +0.0        0.15 ±  7%  perf-profile.children.cycles-pp.update_cfs_group
      0.40            +0.0        0.42 ±  2%  perf-profile.children.cycles-pp.loopback_xmit
      0.24 ±  3%      +0.0        0.26 ±  2%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.45            +0.0        0.47        perf-profile.children.cycles-pp.dev_hard_start_xmit
      0.20            +0.0        0.23 ±  3%  perf-profile.children.cycles-pp.set_next_entity
      0.63            +0.0        0.65        perf-profile.children.cycles-pp.simple_copy_to_iter
      0.13 ±  3%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.sk_leave_memory_pressure
      0.30            +0.0        0.32 ±  2%  perf-profile.children.cycles-pp.sctp_inet_skb_msgname
      0.54 ±  2%      +0.0        0.57 ±  2%  perf-profile.children.cycles-pp.__copy_skb_header
      0.31            +0.0        0.34        perf-profile.children.cycles-pp.___perf_sw_event
      0.27 ±  3%      +0.0        0.30 ±  2%  perf-profile.children.cycles-pp.security_socket_recvmsg
      0.24 ±  3%      +0.0        0.26        perf-profile.children.cycles-pp.ipv4_dst_check
      0.42 ±  2%      +0.0        0.44 ±  3%  perf-profile.children.cycles-pp.page_counter_try_charge
      1.30            +0.0        1.33        perf-profile.children.cycles-pp.try_to_wake_up
      0.42            +0.0        0.45        perf-profile.children.cycles-pp.__mod_node_page_state
      0.79            +0.0        0.82        perf-profile.children.cycles-pp.__skb_clone
      0.44            +0.0        0.48        perf-profile.children.cycles-pp.aa_sk_perm
      0.30            +0.0        0.33 ±  4%  perf-profile.children.cycles-pp.accept_connection
      0.30            +0.0        0.33 ±  4%  perf-profile.children.cycles-pp.spawn_child
      0.30            +0.0        0.33 ±  4%  perf-profile.children.cycles-pp.process_requests
      0.36            +0.0        0.40        perf-profile.children.cycles-pp.prepare_task_switch
      0.28 ±  2%      +0.0        0.31 ±  5%  perf-profile.children.cycles-pp.recv_sctp_stream_1toMany
      0.66            +0.0        0.70        perf-profile.children.cycles-pp.sctp_addrs_lookup_transport
      0.69            +0.0        0.72        perf-profile.children.cycles-pp.__sctp_rcv_lookup
      0.39 ±  3%      +0.0        0.43        perf-profile.children.cycles-pp.dst_release
      1.36            +0.0        1.40        perf-profile.children.cycles-pp.autoremove_wake_function
      0.77            +0.0        0.81        perf-profile.children.cycles-pp.kmem_cache_alloc_node
      1.31            +0.0        1.35        perf-profile.children.cycles-pp.sctp_ulpevent_free
      0.92            +0.0        0.96        perf-profile.children.cycles-pp.try_charge_memcg
      0.64            +0.0        0.69        perf-profile.children.cycles-pp.dequeue_entity
      0.83            +0.0        0.88        perf-profile.children.cycles-pp.sctp_packet_config
      2.48            +0.0        2.53        perf-profile.children.cycles-pp.copy_msghdr_from_user
      0.61 ±  3%      +0.1        0.66 ±  2%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_skmem
      0.66            +0.1        0.71        perf-profile.children.cycles-pp.enqueue_entity
      1.56            +0.1        1.61        perf-profile.children.cycles-pp.__wake_up_common
      1.39            +0.1        1.45        perf-profile.children.cycles-pp.kmem_cache_free
      1.02 ±  2%      +0.1        1.08        perf-profile.children.cycles-pp.sctp_outq_select_transport
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.pick_next_task_idle
      1.64            +0.1        1.70        perf-profile.children.cycles-pp.__wake_up_common_lock
      0.86 ±  3%      +0.1        0.92        perf-profile.children.cycles-pp.pick_next_task_fair
      0.58            +0.1        0.64        perf-profile.children.cycles-pp.update_load_avg
      1.56            +0.1        1.62        perf-profile.children.cycles-pp.__check_object_size
      0.71            +0.1        0.77        perf-profile.children.cycles-pp.dequeue_task_fair
      0.86            +0.1        0.93        perf-profile.children.cycles-pp.sctp_eat_data
      1.92            +0.1        1.99        perf-profile.children.cycles-pp.sctp_data_ready
      1.05            +0.1        1.12        perf-profile.children.cycles-pp.ttwu_do_activate
      0.26 ± 32%      +0.1        0.33 ±  4%  perf-profile.children.cycles-pp.accept_connections
      2.16            +0.1        2.22        perf-profile.children.cycles-pp.sctp_ulpq_tail_event
      0.76            +0.1        0.83        perf-profile.children.cycles-pp.enqueue_task_fair
      0.78            +0.1        0.86        perf-profile.children.cycles-pp.activate_task
      0.98            +0.1        1.05        perf-profile.children.cycles-pp.sctp_sf_eat_data_6_2
      0.97            +0.1        1.04        perf-profile.children.cycles-pp.schedule_idle
      3.22            +0.1        3.30        perf-profile.children.cycles-pp.sctp_outq_flush_data
      1.78            +0.1        1.85        perf-profile.children.cycles-pp.mem_cgroup_charge_skmem
      1.48            +0.1        1.56        perf-profile.children.cycles-pp.sctp_wfree
      1.38            +0.1        1.46        perf-profile.children.cycles-pp.sched_ttwu_pending
      3.80            +0.1        3.89        perf-profile.children.cycles-pp.copyin
      3.92            +0.1        4.00        perf-profile.children.cycles-pp._copy_from_iter
     10.14            +0.1       10.24        perf-profile.children.cycles-pp.sctp_datamsg_from_user
      1.87            +0.1        1.97        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      4.48            +0.1        4.59        perf-profile.children.cycles-pp.sctp_user_addto_chunk
      2.04            +0.1        2.15        perf-profile.children.cycles-pp.__sysvec_call_function_single
      6.96            +0.1        7.09        perf-profile.children.cycles-pp.__memcpy
      7.57            +0.1        7.71        perf-profile.children.cycles-pp.sctp_packet_pack
      3.20            +0.1        3.34        perf-profile.children.cycles-pp.sctp_ulpevent_make_rcvmsg
      1.85            +0.2        2.00        perf-profile.children.cycles-pp.__sk_mem_reduce_allocated
     12.41            +0.2       12.56        perf-profile.children.cycles-pp.sctp_rcv
      2.74            +0.2        2.90        perf-profile.children.cycles-pp.sysvec_call_function_single
      2.41            +0.2        2.57        perf-profile.children.cycles-pp.__sk_mem_raise_allocated
      2.48            +0.2        2.65        perf-profile.children.cycles-pp.__sk_mem_schedule
     13.86            +0.2       14.04        perf-profile.children.cycles-pp.__do_softirq
     13.28            +0.2       13.45        perf-profile.children.cycles-pp.process_backlog
     13.31            +0.2       13.49        perf-profile.children.cycles-pp.__napi_poll
     13.45            +0.2       13.63        perf-profile.children.cycles-pp.net_rx_action
      2.04            +0.2        2.21        perf-profile.children.cycles-pp.schedule
      2.28            +0.2        2.46        perf-profile.children.cycles-pp.schedule_timeout
     12.53            +0.2       12.71        perf-profile.children.cycles-pp.ip_local_deliver_finish
     13.05            +0.2       13.23        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
     12.51            +0.2       12.69        perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
     29.73            +0.2       29.92        perf-profile.children.cycles-pp.sctp_outq_flush
      3.63            +0.2        3.84        perf-profile.children.cycles-pp.sctp_skb_recv_datagram
     13.78            +0.2       13.98        perf-profile.children.cycles-pp.do_softirq
      5.68            +0.2        5.89        perf-profile.children.cycles-pp.sctp_ulpq_tail_data
     13.98            +0.2       14.20        perf-profile.children.cycles-pp.__local_bh_enable_ip
      3.22            +0.2        3.44        perf-profile.children.cycles-pp.skb_release_head_state
      2.90            +0.2        3.13        perf-profile.children.cycles-pp.__schedule
     36.67            +0.2       36.90        perf-profile.children.cycles-pp.sctp_do_sm
     36.13            +0.2       36.36        perf-profile.children.cycles-pp.sctp_cmd_interpreter
     10.99            +0.2       11.22        perf-profile.children.cycles-pp.acpi_safe_halt
      7.30            +0.2        7.54        perf-profile.children.cycles-pp.copyout
     14.37            +0.2       14.61        perf-profile.children.cycles-pp.__dev_queue_xmit
     11.01            +0.2       11.26        perf-profile.children.cycles-pp.acpi_idle_enter
     14.53            +0.2       14.78        perf-profile.children.cycles-pp.ip_finish_output2
      7.40            +0.3        7.65        perf-profile.children.cycles-pp._copy_to_iter
     15.04            +0.3       15.29        perf-profile.children.cycles-pp.__ip_queue_xmit
     11.26            +0.3       11.52        perf-profile.children.cycles-pp.cpuidle_enter_state
     11.33            +0.3       11.59        perf-profile.children.cycles-pp.cpuidle_enter
     29.10            +0.3       29.37        perf-profile.children.cycles-pp.sctp_sendmsg_to_asoc
      8.41            +0.3        8.69        perf-profile.children.cycles-pp.__skb_datagram_iter
      8.45            +0.3        8.73        perf-profile.children.cycles-pp.skb_copy_datagram_iter
     11.94            +0.3       12.25        perf-profile.children.cycles-pp.cpuidle_idle_call
      9.15            +0.4        9.52        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
     13.25            +0.4       13.64        perf-profile.children.cycles-pp.start_secondary
     13.32            +0.4       13.71        perf-profile.children.cycles-pp.do_idle
     13.34            +0.4       13.74        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     13.34            +0.4       13.74        perf-profile.children.cycles-pp.cpu_startup_entry
     16.00            +0.4       16.41        perf-profile.children.cycles-pp.sctp_primitive_SEND
     52.23            +0.6       52.80        perf-profile.children.cycles-pp.sock_sendmsg
     52.14            +0.6       52.72        perf-profile.children.cycles-pp.sctp_sendmsg
     54.28            +0.6       54.87        perf-profile.children.cycles-pp.____sys_sendmsg
     56.24            +0.6       56.85        perf-profile.children.cycles-pp.___sys_sendmsg
     56.83            +0.6       57.45        perf-profile.children.cycles-pp.__sys_sendmsg
      6.05 ±  2%      -2.4        3.68        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.97            -0.2        0.81        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.26            -0.1        1.14        perf-profile.self.cycles-pp.__slab_free
      1.22            -0.1        1.14        perf-profile.self.cycles-pp.rmqueue
      0.40            -0.1        0.35 ±  2%  perf-profile.self.cycles-pp.__zone_watermark_ok
      0.46            -0.0        0.42        perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.18 ±  4%      -0.0        0.16 ±  4%  perf-profile.self.cycles-pp.__free_one_page
      0.15 ±  5%      -0.0        0.13 ±  4%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.10 ±  3%      +0.0        0.11        perf-profile.self.cycles-pp._copy_to_iter
      0.31            +0.0        0.32        perf-profile.self.cycles-pp.sctp_v4_xmit
      0.24            +0.0        0.26 ±  2%  perf-profile.self.cycles-pp.__sys_sendmsg
      0.06 ±  7%      +0.0        0.08        perf-profile.self.cycles-pp.dequeue_task_fair
      0.07 ±  5%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.newidle_balance
      0.40            +0.0        0.42        perf-profile.self.cycles-pp.sctp_skb_recv_datagram
      0.19 ±  3%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.menu_select
      0.11 ±  4%      +0.0        0.13 ±  4%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.37            +0.0        0.39        perf-profile.self.cycles-pp.__check_object_size
      0.78            +0.0        0.80        perf-profile.self.cycles-pp._raw_spin_lock_bh
      0.22 ±  2%      +0.0        0.24 ±  2%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.21            +0.0        0.23        perf-profile.self.cycles-pp.__switch_to_asm
      0.27            +0.0        0.30        perf-profile.self.cycles-pp.___perf_sw_event
      0.38            +0.0        0.40 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.12 ±  3%      +0.0        0.15 ±  6%  perf-profile.self.cycles-pp.update_cfs_group
      0.35            +0.0        0.38        perf-profile.self.cycles-pp.____sys_recvmsg
      0.05            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.schedule
      0.20            +0.0        0.22 ±  2%  perf-profile.self.cycles-pp.update_load_avg
      0.28 ±  2%      +0.0        0.31        perf-profile.self.cycles-pp.sctp_inet_skb_msgname
      0.23 ±  3%      +0.0        0.25        perf-profile.self.cycles-pp.ipv4_dst_check
      0.12 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.sk_leave_memory_pressure
      0.58            +0.0        0.61 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc_node
      0.41            +0.0        0.44 ±  2%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.36            +0.0        0.39 ±  2%  perf-profile.self.cycles-pp.aa_sk_perm
      0.27 ±  3%      +0.0        0.30 ±  5%  perf-profile.self.cycles-pp.recv_sctp_stream_1toMany
      0.78            +0.0        0.82        perf-profile.self.cycles-pp.sctp_recvmsg
      0.71            +0.0        0.74        perf-profile.self.cycles-pp.sctp_sendmsg
      0.38 ±  3%      +0.0        0.42 ±  2%  perf-profile.self.cycles-pp.dst_release
      1.36            +0.1        1.42        perf-profile.self.cycles-pp.kmem_cache_free
      0.51 ±  2%      +0.1        0.58 ±  2%  perf-profile.self.cycles-pp.__sk_mem_raise_allocated
      0.63            +0.1        0.70 ±  2%  perf-profile.self.cycles-pp.sctp_eat_data
      0.47 ±  4%      +0.1        0.55 ±  3%  perf-profile.self.cycles-pp.__sk_mem_reduce_allocated
      3.77            +0.1        3.86        perf-profile.self.cycles-pp.copyin
      6.90            +0.1        7.03        perf-profile.self.cycles-pp.__memcpy
      7.30            +0.2        7.45        perf-profile.self.cycles-pp.acpi_safe_halt
      7.26            +0.2        7.49        perf-profile.self.cycles-pp.copyout




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

