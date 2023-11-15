Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917697EBB5D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 03:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbjKOC6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 21:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKOC6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 21:58:08 -0500
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A445ACF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 18:58:03 -0800 (PST)
X-AuditID: a67dfc5b-d6dff70000001748-6f-655433b81be6
Date:   Wed, 15 Nov 2023 11:57:55 +0900
From:   Byungchul Park <byungchul@sk.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel_team@skhynix.com, akpm@linux-foundation.org,
        namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
        david@redhat.com, peterz@infradead.org, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Subject: Re: [v4 0/3] Reduce TLB flushes under some specific conditions
Message-ID: <20231115025755.GA29979@system.software.com>
References: <20231109045908.54996-1-byungchul@sk.com>
 <87il6bijtu.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87il6bijtu.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsXC9ZZnoe4O45BUg2kf9C3mrF/DZvF5wz82
        ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeL6roeMFsd7DzBZ
        bN40ldni9w+gujlTrCxOzprM4iDg8b21j8VjwaZSj80rtDwW73nJ5LFpVSebx6ZPk9g93p07
        x+5xYsZvFo+dDy095p0M9Hi/7yqbx9Zfdh6fN8l5vJv/li2AL4rLJiU1J7MstUjfLoEr40jL
        ZNaCl/oV186+YGxgPKzYxcjBISFgItG2LqyLkRPM7Hv2lgXEZhFQldj78y0ziM0moC5x48ZP
        MFtEQEPi08Ll7F2MXBzMAm+YJE43b2MFSQgLuEvsOnUHrIhXwELiwrc/7CC2kECmxI3OrawQ
        cUGJkzOfgC1gFtCSuPHvJRPIDcwC0hLL/3GAhDkF7CSed34DGyMqoCxxYNtxJpBdEgKr2CU2
        rnvFDHGopMTBFTdYJjAKzEIydhaSsbMQxi5gZF7FKJSZV5abmJljopdRmZdZoZecn7uJERiD
        y2r/RO9g/HQh+BCjAAejEg9vw8zgVCHWxLLiytxDjBIczEoivOZyIalCvCmJlVWpRfnxRaU5
        qcWHGKU5WJTEeY2+lacICaQnlqRmp6YWpBbBZJk4OKUaGFnu+U44WbK8se5mzCaL397ry5dk
        ej8zX7uxeP2KxROPipyUaXJl3mq4SH/HhimZ+ZsrjnI7iW7+zf6Ub4Ks4E7OO4UrrTY46T4K
        v1C85PXNspVxN9b7heSYSNpaev19kux77BhPQK3JvYTnaz/kBm66sYWXk5uh/POGA1c0nNnd
        fs14/vf38RIlluKMREMt5qLiRABrauzpvQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsXC5WfdrLvDOCTV4MELdYs569ewWXze8I/N
        4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfVdDxkt
        jvceYLLYvGkqs8XvH0B1c6ZYWZycNZnFQdDje2sfi8eCTaUem1doeSze85LJY9OqTjaPTZ8m
        sXu8O3eO3ePEjN8sHjsfWnrMOxno8X7fVTaPxS8+MHls/WXn8XmTnMe7+W/ZAvijuGxSUnMy
        y1KL9O0SuDKOtExmLXipX3Ht7AvGBsbDil2MnBwSAiYSfc/esoDYLAKqEnt/vmUGsdkE1CVu
        3PgJZosIaEh8WricvYuRi4NZ4A2TxOnmbawgCWEBd4ldp+6AFfEKWEhc+PaHHcQWEsiUuNG5
        lRUiLihxcuYTsAXMAloSN/69ZOpi5ACypSWW/+MACXMK2Ek87/wGNkZUQFniwLbjTBMYeWch
        6Z6FpHsWQvcCRuZVjCKZeWW5iZk5pnrF2RmVeZkVesn5uZsYgTG1rPbPxB2MXy67H2IU4GBU
        4uFtmBmcKsSaWFZcmXuIUYKDWUmE11wuJFWINyWxsiq1KD++qDQntfgQozQHi5I4r1d4aoKQ
        QHpiSWp2ampBahFMlomDU6qB8bpZwsvmGRFbzwU+fF7uveXzsefmNnFtBmr3Pd4pM/wTPbtX
        yMrlhcVH9R0fO7K2VU/W9X1v877cM0M+Y1OAXcS5Gd17TIyXTJsxUd/95vFPH36+2y7Tsmu9
        w77qLQKrU6NiHr59lSl5pu9dx6G76RuyN04TK7Ryv8MutUWKV+aR7Cp2l3JBSSWW4oxEQy3m
        ouJEAKSl6GqlAgAA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 01:20:29PM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > Hi everyone,
> >
> > While I'm working with CXL memory, I have been facing migration overhead
> > esp. TLB shootdown on promotion or demotion between different tiers.
> > Yeah.. most TLB shootdowns on migration through hinting fault can be
> > avoided thanks to Huang Ying's work, commit 4d4b6d66db ("mm,unmap: avoid
> > flushing TLB in batch if PTE is inaccessible").
> >
> > However, it's only for ones using hinting fault. I thought it'd be much
> > better if we have a general mechanism to reduce # of TLB flushes and
> > TLB misses, that we can apply to any type of migration. I tried it only
> > for tiering migration for now tho.
> >
> > I'm suggesting a mechanism to reduce TLB flushes by keeping source and
> > destination of folios participated in the migrations until all TLB
> > flushes required are done, only if those folios are not mapped with
> > write permission PTE entries at all. I worked Based on v6.6-rc5.
> >
> > Can you believe it? I saw the number of TLB full flush reduced about
> > 80% and iTLB miss reduced about 50%, and the time wise performance
> > always shows at least 1% stable improvement with the workload I tested
> > with, XSBench. However, I believe that it would help more with other
> > ones or any real ones. It'd be appreciated to let me know if I'm missing
> > something.
> 
> Can you help to test the effect of commit 7e12beb8ca2a ("migrate_pages:
> batch flushing TLB") for your test case?  To test it, you can revert it
> and compare the performance before and after the reverting.
> 
> And, how do you trigger migration when testing XSBench?  Use a tiered
> memory system, and migrate pages between DRAM and CXL memory back and
> forth?  If so, how many pages will you migrate for each migration

It was not an actual CXL memory but a cpuless remote numa node's DRAM
recognized as a slow tier (node_is_toptier() == false) by the kernel.
It's been okay to me because I've been focusing on TLB # and migration #
while working with numa tiering mechanism and, I think, the time wise
performance will be followed, big or little depending on the system
configuration.

So it migrates pages between the two DRAMs back and forth - promotion by
hinting fault and demotion by page reclaim. I tested what you asked me
with another slower system to make TLB miss overhead stand out.

Unfortunately I got even worse result with vanilla v6.6-rc5 than
v6.6-rc5 with 7e12beb8ca2a reverted, while the 'v6.6-rc5 + migrc'
definitely shows far better result.

Thoughts?

	Byungchul

---

   Architecture - x86_64                                               
   QEMU - kvm enabled, host cpu                                        
   Numa - 2 nodes (16 CPUs 1GB, no CPUs 8GB)                           
   Kernel - v6.6-rc5, NUMA_BALANCING_MEMORY_TIERING, demotion enabled
   Benchmark - XSBench -p 50000000 (-p option makes the runtime longer)

   CASE1 - mainline v6.6-rc5 + 7e12beb8ca2a reverted
   -------------------------------------------------
   $ perf stat -a \
	   -e itlb.itlb_flush \
	   -e tlb_flush.dtlb_thread \
	   -e tlb_flush.stlb_any \
	   -e dTLB-load-misses \
	   -e dTLB-store-misses \
	   -e iTLB-load-misses \
	   ./XSBench -p 50000000

   Performance counter stats for 'system wide':
   
      190247118     itlb.itlb_flush      
      716182438     tlb_flush.dtlb_thread
      327051673     tlb_flush.stlb_any   
      119542331968  dTLB-load-misses     
      724072795     dTLB-store-misses    
      3054343419    iTLB-load-misses     
   
   1172.580552728 seconds time elapsed      
   
   $ cat /proc/vmstat
   
   ...
   numa_pages_migrated 5968431                  
   pgmigrate_success 12484773                   
   nr_tlb_remote_flush 6614459                  
   nr_tlb_remote_flush_received 96022799        
   nr_tlb_local_flush_all 50869                 
   nr_tlb_local_flush_one 785597          
   ...

   CASE2 - mainline v6.6-rc5 (vanilla)
   -------------------------------------------------
   $ perf stat -a \
	   -e itlb.itlb_flush \
	   -e tlb_flush.dtlb_thread \
	   -e tlb_flush.stlb_any \
	   -e dTLB-load-misses \
	   -e dTLB-store-misses \
	   -e iTLB-load-misses \
	   ./XSBench -p 50000000
   
   Performance counter stats for 'system wide':
   
      55139061      itlb.itlb_flush      
      286725687     tlb_flush.dtlb_thread
      199687660     tlb_flush.stlb_any   
      119497951269  dTLB-load-misses     
      358434759     dTLB-store-misses    
      1867135967    iTLB-load-misses     
   
   1181.311084373 seconds time elapsed      
   
   $ cat /proc/vmstat
   
   ...
   numa_pages_migrated 8190027                  
   pgmigrate_success 17098994                   
   nr_tlb_remote_flush 1955114                  
   nr_tlb_remote_flush_received 29028093        
   nr_tlb_local_flush_all 140921                
   nr_tlb_local_flush_one 740767                
   ...

   CASE3 - mainline v6.6-rc5 + migrc
   -------------------------------------------------
   $ perf stat -a \
	   -e itlb.itlb_flush \
	   -e tlb_flush.dtlb_thread \
	   -e tlb_flush.stlb_any \
	   -e dTLB-load-misses \
	   -e dTLB-store-misses \
	   -e iTLB-load-misses \
	   ./XSBench -p 50000000

   Performance counter stats for 'system wide':

      6337091       itlb.itlb_flush      
      157229778     tlb_flush.dtlb_thread
      148240163     tlb_flush.stlb_any   
      117701381319  dTLB-load-misses     
      231212468     dTLB-store-misses    
      973083466     iTLB-load-misses     

   1105.756705157 seconds time elapsed      
   
   $ cat /proc/vmstat
   
   ...
   numa_pages_migrated 8791934                  
   pgmigrate_success 18276174                   
   nr_tlb_remote_flush 311146                   
   nr_tlb_remote_flush_received 4387708         
   nr_tlb_local_flush_all 143883                
   nr_tlb_local_flush_one 740953    
   ...
