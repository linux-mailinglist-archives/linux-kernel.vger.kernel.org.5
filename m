Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1B5782F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbjHURhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 13:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbjHURhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:37:35 -0400
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1137EF7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 10:37:32 -0700 (PDT)
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
        by cmsmtp with ESMTP
        id Y8q5qac2Bez0CY8q5qfW3P; Mon, 21 Aug 2023 17:37:17 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id Y8eWq8mBgyUcIY8eXqfxM7; Mon, 21 Aug 2023 17:25:21 +0000
X-Authority-Analysis: v=2.4 cv=CaEbWZnl c=1 sm=1 tr=0 ts=64e39e01
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=1WnDPnTmFzQZd09XUGwA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bc2M5SoQ/ymmZ343GMwBS2h8os/ZMLDqdFlqcSGHi6Q=; b=d2/nlEiexF9/UMltVqQ5SAkFCg
        V/0wK9HURzHIhWrE5u7IKcMIoLL36u/iu+xN0SMP7N5+oK9yH480/RHqgFTyvop7lTENM1mLac1W2
        tEmRg/JdnHCSm3VKOOr+3LkXUJDr6fst2y2aEUpKdM5KNU7JrdV41v6iyWfE5WYz2oTB2po78frbg
        EGeUmS6iFzcHecOL/DENRzccmJhHvbdksDheTSh1Xi+cJ3UPFuQM6dnPg+n77hVGCzPkGQdLz059V
        4cqUql33ONPJzZjhMM9OWMokITkSCo3yK/Mh7Jaf5Ea1MKhNrEzCm2MYvSyJxzujQwxgOp50d7CdF
        vkaPoVpA==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:51434 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qY8eW-002N7c-1k;
        Mon, 21 Aug 2023 12:25:20 -0500
Message-ID: <d8fd6210-84eb-6d32-6486-1d90c86186ca@embeddedor.com>
Date:   Mon, 21 Aug 2023 11:26:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [gustavoars:testing/fam01-next20230817] BUILD SUCCESS WITH
 WARNING dbd3e479335bc8b09ea540102109ac38b0a73336
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Liu, Yujie" <yujie.liu@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <202308181544.cTQDCUcQ-lkp@intel.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202308181544.cTQDCUcQ-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qY8eW-002N7c-1k
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:51434
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCkm13rzZu4o768rasN1VQoVd2CesnMcQxD4U9KoAndGb3htjUvG+CQQdqDE7xLU4ZMBicdDb6QrK8Cwr3IJAel84tKsotmgRXQquJLYlsmBZgvO5q2r
 XbYC2SCNHtDJDkEql2/JnsjxDlcMGF65vfZxCx2xV4HyJRplCct/of/QbdxF31puWSF7vDELckanqav5c3ZooDWbpeL3pLw1BkzGhIKbmx2S8OeCH6E6sSdr
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there!

It'd be great to add to these reports the versions of the compilers you are using
to build the kernel.

It's not uncommon that some compiler versions contain bugs. And in cases where kernel
developers are aware of those issues, knowing the exact version used to build the
kernel will help us determine whether the issues reported may be false positives or
not.

Maybe just one line at the beginning mentioning the versions:

`GCC 13.2.0 and Clang 16.0.0 builds`

Thank you!
--
Gustavo


On 8/18/23 01:55, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230817
> branch HEAD: dbd3e479335bc8b09ea540102109ac38b0a73336  net: sched: cls_u32: Fix allocation in u32_init()
> 
> Warning: (recently discovered and may have been fixed)
> 
> arch/arc/include/asm/io.h:129:9: warning: array subscript 0 is outside array bounds of 'volatile void[0]' [-Warray-bounds]
> arch/loongarch/include/asm/atomic.h:174:9: warning: array subscript 1 is outside array bounds of 'struct cpumask[1]' [-Warray-bounds]
> arch/sparc/include/asm/string.h:15:25: warning: '__builtin_memcpy' forming offset [132, 257] is out of the bounds [0, 132] of object 'send_data' with type 'u8[132]' {aka 'unsigned char[132]'} [-Warray-bounds]
> include/asm-generic/unaligned.h:14:15: warning: array subscript -1 is outside array bounds of 'unsigned char[2147483647]' [-Warray-bounds]
> lib/vsprintf.c:2893:33: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
> mm/mempolicy.c:3117:26: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
> 
> Warning ids grouped by kconfigs:
> 
> gcc_recent_errors
> |-- arc-allyesconfig
> |   `-- arch-arc-include-asm-io.h:warning:array-subscript-is-outside-array-bounds-of-volatile-void
> |-- arc-randconfig-r043-20230818
> |   `-- arch-arc-include-asm-io.h:warning:array-subscript-is-outside-array-bounds-of-volatile-void
> |-- loongarch-randconfig-r001-20230818
> |   `-- arch-loongarch-include-asm-atomic.h:warning:array-subscript-is-outside-array-bounds-of-struct-cpumask
> |-- mips-randconfig-r012-20230818
> |   `-- include-asm-generic-unaligned.h:warning:array-subscript-is-outside-array-bounds-of-unsigned-char
> |-- sparc-randconfig-r026-20230818
> |   `-- arch-sparc-include-asm-string.h:warning:__builtin_memcpy-forming-offset-is-out-of-the-bounds-of-object-send_data-with-type-u8-aka-unsigned-char
> `-- x86_64-defconfig
>      |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
>      `-- mm-mempolicy.c:warning:writing-byte-into-a-region-of-size
> 
> elapsed time: 845m
> 
> configs tested: 111
> configs skipped: 4
> 
