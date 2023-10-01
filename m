Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C081A7B4827
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 16:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbjJAOuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 10:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjJAOud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 10:50:33 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267D3A9;
        Sun,  1 Oct 2023 07:50:28 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0F0B75C2C29;
        Sun,  1 Oct 2023 10:50:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 01 Oct 2023 10:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696171825; x=1696258225; bh=mEMutYlrVNpsS
        g7pWqpRwU1aONJ27VWy6905pdrkIqI=; b=clRr215/arKhXy6mDtuOWYOvKNH/O
        plIeU3G7c7h4aFie7RVwb33h4LHvbvXn8zJTz7R/3xSWD3WDLq/ute/eGezCWVzh
        OYgi2D2hI+xO/W4R/g9Ehrv3uDTZGHYqKCHK5euZ7aUlZjbhaGJBu+ajulSSCfPT
        6rHnYNeCj6Fqw46XpFYRxCPT2DY7Kuk5luqvn0oJ5z690YucYgeEPWot3FAYc+Kc
        x0IeNhdqKgTDY5zJEHmMiQ+F2DkGXsrG/1N3LJ4d8XtaerOMjaZoX0zRq1a2LDwN
        /y3a6pMLqHSv1uF6jRYtOmtOzxy0P0cwCJr2guHVHloRN5oQNH5JJ9/eA==
X-ME-Sender: <xms:MIcZZWVbvahzZh2oj7kR-Z5QrhM-UuCJPJihvrvEO3e1K5l80bAFpg>
    <xme:MIcZZSnEzheXxG1Mfk9Ir-1ZY4kW5uldSfpWkJ0MHLTd41dn9KVzybmAwjq6qinw4
    9PO2oOQyFVvmLg>
X-ME-Received: <xmr:MIcZZaazckKZ_FxHkRZBpZuZZpSD6Z2qISNbHdoQqDavIf3FsvlH8k_GX5Cy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddugddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpeetgeejteeivedvheekgeeiheehvedvveefgffgudekgfffheehgeeivdejgeei
    udenucffohhmrghinhepshgvlhhfthgvshhtshdrnhgvthdpkhgvrhhnvghlqdhsvghlfh
    htvghsthhsrdhnvghtpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:MIcZZdUNKS4M8JNImwQOwxYoBwMqWmu8WA4PTdT7n7Ke58TwVfuLiQ>
    <xmx:MIcZZQkGiDxb77mbQN1auwagngkQ29-jAGAlk6McHypLQ-7zxObD6w>
    <xmx:MIcZZSdEidrF1POPDZIShTlrCKpBQ5kxsqiYMvEc8vHv6RkCoI7Pqg>
    <xmx:MYcZZRCyPV4ExQyo7dDtkRJyPBEQxCoW9RY803Ld7eIpPaeUeWolsA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Oct 2023 10:50:24 -0400 (EDT)
Date:   Sun, 1 Oct 2023 17:50:20 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
        oliver.sang@intel.com
Cc:     "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "lkp@intel.com" <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [linus:master] [selftests]  8ae9efb859:
 kernel-selftests.net.fib_tests.sh.fail
Message-ID: <ZRmHLPbyTCBvoHWP@shredder>
References: <202309191658.c00d8b8-oliver.sang@intel.com>
 <DBBP189MB1433CECC6CBECFD95352EA3595FCA@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBBP189MB1433CECC6CBECFD95352EA3595FCA@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 06:18:34PM +0000, Sriram Yagnaraman wrote:
> CC: Ido, who helped a lot with writing these tests.
> 
> > -----Original Message-----
> > From: kernel test robot <oliver.sang@intel.com>
> > Sent: Tuesday, 19 September 2023 10:32
> > To: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> > Cc: oe-lkp@lists.linux.dev; lkp@intel.com; linux-kernel@vger.kernel.org; David
> > S. Miller <davem@davemloft.net>; netdev@vger.kernel.org;
> > oliver.sang@intel.com
> > Subject: [linus:master] [selftests] 8ae9efb859: kernel-
> > selftests.net.fib_tests.sh.fail
> > 
> > 
> > hi, Sriram Yagnaraman,
> > 
> > we noticed two new added tests failed in our test environment.
> > want to consult with you what's the dependency and requirement to run
> > them?
> > Thanks a lot!
> 
> Sorry for the delayed response. I will look at this and get back.
> I am not an expert with lkp-tests but will try to set it up on my local environment and reproduce the problem.
> 
> > 
> > Hello,
> > 
> > kernel test robot noticed "kernel-selftests.net.fib_tests.sh.fail" on:
> > 
> > commit: 8ae9efb859c05a54ac92b3336c6ca0597c9c8cdb ("selftests: fib_tests:
> > Add multipath list receive tests")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > in testcase: kernel-selftests
> > version: kernel-selftests-x86_64-60acb023-1_20230329
> > with following parameters:
> > 
> > 	group: net
> > 
> > 
> > 
> > compiler: gcc-12
> > test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @
> > 3.00GHz (Cascade Lake) with 32G memory
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of the
> > same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes:
> > | https://lore.kernel.org/oe-lkp/202309191658.c00d8b8-oliver.sang@intel.
> > | com
> > 
> > 
> > 
> > # timeout set to 1500
> > # selftests: net: fib_tests.sh
> > #
> > # Single path route test
> > #     Start point
> > #     TEST: IPv4 fibmatch                                                 [ OK ]
> > #     TEST: IPv6 fibmatch                                                 [ OK ]
> > #     Nexthop device deleted
> > #     TEST: IPv4 fibmatch - no route                                      [ OK ]
> > #     TEST: IPv6 fibmatch - no route                                      [ OK ]
> > 
> > ...
> > 
> > #
> > # Fib6 garbage collection test
> > #     TEST: ipv6 route garbage collection                                 [ OK ]
> > #
> > # IPv4 multipath list receive tests
> > #     TEST: Multipath route hit ratio (.06)                               [FAIL]
> > #
> > # IPv6 multipath list receive tests
> > #     TEST: Multipath route hit ratio (.10)                               [FAIL]

I found two possible problems. The first is that in the IPv4 case we
might get more trace point hits than packets (ratio higher than 1)
because of the additional FIB lookups for source validation. Fixed by
disabling source validation:

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index e7d2a530618a..66d0db7a2614 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -2437,6 +2437,9 @@ ipv4_mpath_list_test()
        run_cmd "ip -n ns2 route add 203.0.113.0/24
                nexthop via 172.16.201.2 nexthop via 172.16.202.2"
        run_cmd "ip netns exec ns2 sysctl -qw net.ipv4.fib_multipath_hash_policy=1"
+       run_cmd "ip netns exec ns2 sysctl -qw net.ipv4.conf.veth2.rp_filter=0"
+       run_cmd "ip netns exec ns2 sysctl -qw net.ipv4.conf.all.rp_filter=0"
+       run_cmd "ip netns exec ns2 sysctl -qw net.ipv4.conf.default.rp_filter=0"
        set +e
 
        local dmac=$(ip -n ns2 -j link show dev veth2 | jq -r '.[]["address"]')

The second problem (which I believe is the one you encountered) is that
we might miss certain trace point hits if they happen from the ksoftirqd
task instead of the mausezahn task. Fixed by:

@@ -2449,7 +2452,7 @@ ipv4_mpath_list_test()
        # words, the FIB lookup tracepoint needs to be triggered for every
        # packet.
        local t0_rx_pkts=$(link_stats_get ns2 veth2 rx packets)
-       run_cmd "perf stat -e fib:fib_table_lookup --filter 'err == 0' -j -o $tmp_file -- $cmd"
+       run_cmd "perf stat -a -e fib:fib_table_lookup --filter 'err == 0' -j -o $tmp_file -- $cmd"
        local t1_rx_pkts=$(link_stats_get ns2 veth2 rx packets)
        local diff=$(echo $t1_rx_pkts - $t0_rx_pkts | bc -l)
        list_rcv_eval $tmp_file $diff
@@ -2494,7 +2497,7 @@ ipv6_mpath_list_test()
        # words, the FIB lookup tracepoint needs to be triggered for every
        # packet.
        local t0_rx_pkts=$(link_stats_get ns2 veth2 rx packets)
-       run_cmd "perf stat -e fib6:fib6_table_lookup --filter 'err == 0' -j -o $tmp_file -- $cmd"
+       run_cmd "perf stat -a -e fib6:fib6_table_lookup --filter 'err == 0' -j -o $tmp_file -- $cmd"
        local t1_rx_pkts=$(link_stats_get ns2 veth2 rx packets)
        local diff=$(echo $t1_rx_pkts - $t0_rx_pkts | bc -l)
        list_rcv_eval $tmp_file $diff

Ran both tests in a loop:

# for i in $(seq 1 20); do ./fib_tests.sh -t ipv4_mpath_list; done
# for i in $(seq 1 20); do ./fib_tests.sh -t ipv6_mpath_list; done

And verified that the results are stable. Also verified that the tests
reliably fail when reverting both fixes:

8423be8926aa ipv6: ignore dst hint for multipath routes
6ac66cb03ae3 ipv4: ignore dst hint for multipath routes

Can you please test with the proposed modifications?

Thanks
