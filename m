Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9891E7764DE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjHIQSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjHIQR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:17:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98C3CE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 09:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691597879; x=1723133879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=EMcSYxXoBTloQoFV7nwbsCh2Jiwl9DO9dn0OyzjQgdQ=;
  b=CvvTfySKPXXSMdUWD95Vuk90607J66E7USsZC8hMQXignxUVI3AUxxFo
   XfZEG7Sv8g10PrGs3DuavFubHJgOhZ8AU8fubsUeB3BmqnkEeY6bTLtlk
   OuqwXrXY+q8qCVW7nlDWtn5hwyEUD643p6QBDWSGQL8vWPyxk4RbdOxQh
   jqFfilHkLkAixtEEBuMu8vaSBxkZcburUeBY+COX8datuiWrGZaxfLnKc
   c0806UPtR+FQ9MUm2tQZ8JNgfJQrqECa4t1r1O8GRw2s141IMjHxABygQ
   kRHxxxavD264RaVjnyJeBCP63oYYKf1ih/TN2XFLDHeyYStfFJ727FOmH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="351470797"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="351470797"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 09:12:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="797243839"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="797243839"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 09:12:28 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     tglx@linutronix.de
Cc:     andrew.cooper3@citrix.com, andy@infradead.org,
        arjan@linux.intel.com, dimitri.sivanich@hpe.com,
        feng.tang@intel.com, jgross@suse.com, kan.liang@linux.intel.com,
        kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, paulmck@kernel.org, ray.huang@amd.com,
        rui.zhang@intel.com, sohil.mehta@intel.com,
        thomas.lendacky@amd.com, x86@kernel.org, qiuxu.zhuo@intel.com
Subject: Re: [patch 00/53] x86/topology: The final installment
Date:   Thu, 10 Aug 2023 00:12:19 +0800
Message-Id: <20230809161219.83084-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230807130108.853357011@linutronix.de>
References: <20230807130108.853357011@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

> From: Thomas Gleixner <tglx@linutronix.de>
> ...
> Subject: [patch 00/53] x86/topology: The final installment
> ...
> 
> The current series applies on top of 
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-cpuid-v3
> 
> and is available from git here:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-full-v1

Test Machine
------------
I tested the 'topo-full-v1' branch on a Sapphire Rapids server with 2 sockets,
each containing 48 cores, resulting in a total of 192 threads.


Test Results
------------
The following test results (same result either w/ or w/o [1]) show that
this branch worked well on this server. Based on the test results,
  
  Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

[1] https://lore.kernel.org/all/20230808221039.GH212435@hirez.programming.kicks-ass.net/


Logs (hyper-thread enabled)
---------------------------
1.1 dmesg | grep "CPU topo" :

    CPU topo: Max. logical packages:   2
    CPU topo: Max. logical dies:       2
    CPU topo: Max. dies per package:   1
    CPU topo: Max. threads per core:   2
    CPU topo: Num. cores per package:    48
    CPU topo: Num. threads per package:  96
    CPU topo: Allowing 192 present CPUs plus 0 hotplug CPUs
    CPU topo: Thread    :   192
    CPU topo: Core      :    96
    CPU topo: Module    :     2
    CPU topo: Tile      :     2
    CPU topo: Die       :     2
    CPU topo: Package   :     2

1.2 cat /sys/kernel/debug/x86/topo/domains :

    domain: Thread     shift: 1 dom_size:     2 max_threads:     2
    domain: Core       shift: 7 dom_size:    64 max_threads:   128
    domain: Module     shift: 7 dom_size:     1 max_threads:   128
    domain: Tile       shift: 7 dom_size:     1 max_threads:   128
    domain: Die        shift: 7 dom_size:     1 max_threads:   128
    domain: Package    shift: 7 dom_size:     1 max_threads:   128

1.3 <1st socket, 1st core, primary thread>
    cat /sys/kernel/debug/x86/topo/cpus/0
    online:              1
    initial_apicid:      0
    apicid:              0
    pkg_id:              0
    die_id:              0
    cu_id:               255
    core_id:             0
    logical_pkg_id:      0
    logical_die_id:      0
    llc_id:              0
    l2c_id:              0
    amd_node_id:         0
    amd_nodes_per_pkg:   0
    num_threads:         96
    num_cores:           48
    max_dies_per_pkg:    1
    max_threads_per_core:2

    <1st socket, last core, primary thread>
    cat /sys/kernel/debug/x86/topo/cpus/47
    online:              1
    initial_apicid:      5e
    apicid:              5e
    pkg_id:              0
    die_id:              0
    cu_id:               255
    core_id:             47
    logical_pkg_id:      0
    logical_die_id:      0
    llc_id:              0
    l2c_id:              94
    amd_node_id:         0
    amd_nodes_per_pkg:   0
    num_threads:         96
    num_cores:           48
    max_dies_per_pkg:    1
    max_threads_per_core:2
    
    <2nd socket, 1st core, primary thread>
    cat /sys/kernel/debug/x86/topo/cpus/48
    online:              1
    initial_apicid:      80
    apicid:              80
    pkg_id:              1
    die_id:              1
    cu_id:               255
    core_id:             0
    logical_pkg_id:      1
    logical_die_id:      1
    llc_id:              128
    l2c_id:              128
    amd_node_id:         0
    amd_nodes_per_pkg:   0
    num_threads:         96
    num_cores:           48
    max_dies_per_pkg:    1
    max_threads_per_core:2
    
    <2nd socket, last core, primary thread>
    cat /sys/kernel/debug/x86/topo/cpus/95
    online:              1
    initial_apicid:      de
    apicid:              de
    pkg_id:              1
    die_id:              1
    cu_id:               255
    core_id:             47
    logical_pkg_id:      1
    logical_die_id:      1
    llc_id:              128
    l2c_id:              222
    amd_node_id:         0
    amd_nodes_per_pkg:   0
    num_threads:         96
    num_cores:           48
    max_dies_per_pkg:    1
    max_threads_per_core:2

    <1st socket, 1st core, secondary thread>
    cat /sys/kernel/debug/x86/topo/cpus/96
    online:              1
    initial_apicid:      1
    apicid:              1
    pkg_id:              0
    die_id:              0
    cu_id:               255
    core_id:             0
    logical_pkg_id:      0
    logical_die_id:      0
    llc_id:              0
    l2c_id:              0
    amd_node_id:         0
    amd_nodes_per_pkg:   0
    num_threads:         96
    num_cores:           48
    max_dies_per_pkg:    1
    max_threads_per_core:2
    
    <1st socket, last core, secondary thread>
    cat /sys/kernel/debug/x86/topo/cpus/143
    online:              1
    initial_apicid:      5f
    apicid:              5f
    pkg_id:              0
    die_id:              0
    cu_id:               255
    core_id:             47
    logical_pkg_id:      0
    logical_die_id:      0
    llc_id:              0
    l2c_id:              94
    amd_node_id:         0
    amd_nodes_per_pkg:   0
    num_threads:         96
    num_cores:           48
    max_dies_per_pkg:    1
    max_threads_per_core:2

    <2nd socket, 1st core, secondary thread>
    cat /sys/kernel/debug/x86/topo/cpus/144
    online:              1
    initial_apicid:      81
    apicid:              81
    pkg_id:              1
    die_id:              1
    cu_id:               255
    core_id:             0
    logical_pkg_id:      1
    logical_die_id:      1
    llc_id:              128
    l2c_id:              128
    amd_node_id:         0
    amd_nodes_per_pkg:   0
    num_threads:         96
    num_cores:           48
    max_dies_per_pkg:    1
    max_threads_per_core:2
    
    <2nd socket, last core, secondary thread>
    cat /sys/kernel/debug/x86/topo/cpus/191
    online:              1
    initial_apicid:      df
    apicid:              df
    pkg_id:              1
    die_id:              1
    cu_id:               255
    core_id:             47
    logical_pkg_id:      1
    logical_die_id:      1
    llc_id:              128
    l2c_id:              222
    amd_node_id:         0
    amd_nodes_per_pkg:   0
    num_threads:         96
    num_cores:           48
    max_dies_per_pkg:    1
    max_threads_per_core:2

Logs (hyper-thread disabled)
----------------------------
2.1 dmesg | grep "CPU topo" :

    CPU topo: Max. logical packages:   2
    CPU topo: Max. logical dies:       2
    CPU topo: Max. dies per package:   1
    CPU topo: Max. threads per core:   1
    CPU topo: Num. cores per package:    48
    CPU topo: Num. threads per package:  48
    CPU topo: Allowing 96 present CPUs plus 0 hotplug CPUs
    CPU topo: Thread    :    96
    CPU topo: Core      :    96
    CPU topo: Module    :     2
    CPU topo: Tile      :     2
    CPU topo: Die       :     2
    CPU topo: Package   :     2

2.2 cat /sys/kernel/debug/x86/topo/domains :

    domain: Thread     shift: 1 dom_size:     2 max_threads:     2
    domain: Core       shift: 7 dom_size:    64 max_threads:   128
    domain: Module     shift: 7 dom_size:     1 max_threads:   128
    domain: Tile       shift: 7 dom_size:     1 max_threads:   128
    domain: Die        shift: 7 dom_size:     1 max_threads:   128
    domain: Package    shift: 7 dom_size:     1 max_threads:   128

2.3 <1st socket, 1st core>
    cat /sys/kernel/debug/x86/topo/cpus/0
    online:              1
    initial_apicid:      0
    apicid:              0
    pkg_id:              0
    die_id:              0
    cu_id:               255
    core_id:             0
    logical_pkg_id:      0
    logical_die_id:      0
    llc_id:              0
    l2c_id:              0
    amd_node_id:         0
    amd_nodes_per_pkg:   0
    num_threads:         48
    num_cores:           48
    max_dies_per_pkg:    1
    max_threads_per_core:1

    <1st socket, last core>
    cat /sys/kernel/debug/x86/topo/cpus/47
    online:              1
    initial_apicid:      5e
    apicid:              5e
    pkg_id:              0
    die_id:              0
    cu_id:               255
    core_id:             47
    logical_pkg_id:      0
    logical_die_id:      0
    llc_id:              0
    l2c_id:              94
    amd_node_id:         0
    amd_nodes_per_pkg:   0
    num_threads:         48
    num_cores:           48
    max_dies_per_pkg:    1
    max_threads_per_core:1

    <2nd socket, 1st core>
    cat /sys/kernel/debug/x86/topo/cpus/48
    online:              1
    initial_apicid:      80
    apicid:              80
    pkg_id:              1
    die_id:              1
    cu_id:               255
    core_id:             0
    logical_pkg_id:      1
    logical_die_id:      1
    llc_id:              128
    l2c_id:              128
    amd_node_id:         0
    amd_nodes_per_pkg:   0
    num_threads:         48
    num_cores:           48
    max_dies_per_pkg:    1
    max_threads_per_core:1

    <2nd socket, last core>
    cat /sys/kernel/debug/x86/topo/cpus/95
    online:              1
    initial_apicid:      de
    apicid:              de
    pkg_id:              1
    die_id:              1
    cu_id:               255
    core_id:             47
    logical_pkg_id:      1
    logical_die_id:      1
    llc_id:              128
    l2c_id:              222
    amd_node_id:         0
    amd_nodes_per_pkg:   0
    num_threads:         48
    num_cores:           48
    max_dies_per_pkg:    1
    max_threads_per_core:1

-Qiuxu
