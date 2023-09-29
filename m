Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1499F7B2F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 11:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjI2Jvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 05:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjI2Jvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 05:51:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E710F195
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 02:51:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A0932218E6;
        Fri, 29 Sep 2023 09:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695981106;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=2mSvajXs/u299TQR/vl8udijxVbzNCOW2qMU41hxYb4=;
        b=q50G3asbHmAzxja6JMjQdjtO2wfyPavrJh+sLjDYoAl3s6FzvR7pOLQ1ieptOKA897NJQ0
        EGOmPa+8CXaGj4gKnz36/d4eWBV/ptrcKf/Df9D386W07YHHbsG0Kvl6UEU02D+1jJObwm
        P/oMZH86ZxagOfSnj7XNbokaVVVOSbM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695981106;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=2mSvajXs/u299TQR/vl8udijxVbzNCOW2qMU41hxYb4=;
        b=tvpkGFUuvM/cGpi/g+GaNsZTzw85e+gKzLu6skn/+c1yVkb8iHr5iaBpxnPPaFsJVwFH7K
        novooDOjzpxWN6CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 371151390A;
        Fri, 29 Sep 2023 09:51:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AVg2CzKeFmUaFgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 29 Sep 2023 09:51:46 +0000
Date:   Fri, 29 Sep 2023 11:51:44 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it, linux-kernel@vger.kernel.org,
        libc-alpha@sourceware.org
Cc:     lwn@lwn.net, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, Cyril Hrubis <chrubis@suse.cz>
Subject: The Linux Test Project has been released for SEPTEMBER 2023
Message-ID: <20230929095144.GD364346@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good news everyone,

the Linux Test Project test suite stable release for *September 2023* has been
released.

Since the last release 250 patches by 34 authors were merged, 14 authors were new.

Patch review is what most of the projects struggle with and LTP is no
different. If you can spare some effort helping with the patch review is more
than welcomed.

The release notes were prepared by Cyril Hrubis.

NOTABLE CHANGES
===============

* New tests
  - epoll_wait07 for EPOLLONESHOT
  - epoll_wait06 for EPOLLET
  - epoll_wait05 for EPOLLRDHUP
  - process_madvise01 for MADV_PAGEOUT
  - faccessat201 basic faccessat2() test
  - faccessat202 checks that the syscall fails correctly
  - tcindex01 aka CVE-2023-1829
  - mremap06 reproducer for
    7e7757876f25 ("mm/mremap: fix vm_pgoff in vma_merge() case 3")
  - starvation a simple test case for sched starvation
    https://lwn.net/ml/linux-kernel/9fd2c37a05713c206dcbd5866f67ce779f315e9e.camel@gmx.de/
  - pipe14 for end-of-file (read() returns 0) in a case the write end is closed
  - statx12 basic test for STATX_ATTR_MOUNT_ROOT
  - kvm_svm03 KVM test for CPU lockup through malicous SVM guest
  - kvm_svm02 test that KVM correctly intercepts VMSAVE and VMLOAD instructions
              in a nested virtual machine aka CVE-2021-3656
  - statx11 a basic test for STATX_DIOALIGN on block device
  - statx10 a basic test for STATX_DIOALIGN on regular file

* Increased coverage
  - fanotify13 added test variant for overalfs upper fs
  - mmap05 increased coverage for EINVAL
  - mmap06 increased coverage for EACCES
  - bind03 now includes regression test for
    c0c3b8d380a8 ("unix_bind_bsd(): unlink if we fail after successful mknod")
  - stack_clash added test for mmap() minding gap

* ebizzy benchmark counter increment races and overflows were fixed

* A few more testcases were converted to guarded buffers
  that is data passed by pointer to kernel are immediatelly
  following a PROT_NONE page and followed by canaries
  to catch off-by-one errors

* Tests that modprobe kernel modules are now skipped when secure boot is
  enabled on x86 and ppc64le

* ioprio tests now use IOPRIO_PRIO_NUM instead of hardcoded value
  to check for prio range

* 35 testcases were converted to the new test library
  - we finally got rid of the old and messy libclone library

+ The usual amount of fixes and cleanups

KIRK (previously RUNLTP-NG)
===========================

* The new runltp-ng version is now called kirk
  - The name was changed since kirk now supports different testsuites as well
  - Apart from the name changes the internals were rewritten and cleaned up
  - Prototype for parallel testruns is included as well
  - https://github.com/linux-test-project/kirk/#readme

* There is now experimental LTX support implemented
  - Beware this is _VERY EXPERIMENTAL_ at the moment
  - LTX is tiny binary that runs on system under test
  - LTX communicates with kirk over serial using messages packed in msgpack
  - LTX is going to be locked in memory and executed with realtime priority
  - LTX allows advanced features such as running tests in parallel
  - https://github.com/linux-test-project/ltx

REMOVED TESTS
=============

* mmap07 (included in mmap06)
* setgroups04 (included in setgroups03)

DOWNLOAD AND LINKS
==================

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

https://github.com/linux-test-project/ltp/releases/tag/YYYYMMDD

The project pages as well as GIT repository are hosted on GitHub:

https://github.com/linux-test-project/ltp
http://linux-test-project.github.io/

If you ever wondered how to write a LTP testcase, don't miss our developer
documentation at:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines

https://github.com/linux-test-project/ltp/wiki/C-Test-API

https://github.com/linux-test-project/ltp/wiki/C-Test-Network-API

https://github.com/linux-test-project/ltp/wiki/Shell-Test-API

https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial

https://github.com/linux-test-project/ltp/wiki/Build-System

Patches, new tests, bugs, comments or questions should go to to our mailing
list at ltp@lists.linux.it.

CREDITS
=======

Many thanks to the people contributing to this release:

$ git shortlog -s -e -n 20230516..
    71	Petr Vorel <pvorel@suse.cz>
    32	Yang Xu <xuyang2018.jy@fujitsu.com>
    26	Avinesh Kumar <akumar@suse.de>
    22	Andrea Cervesato <andrea.cervesato@suse.com>
    22	Martin Doucha <mdoucha@suse.cz>
    13	Cyril Hrubis <chrubis@suse.cz>
    13	Li Wang <liwang@redhat.com>
     6	Wei Gao <wegao@suse.com>
     5	Souta Kawahara <souta.kawahara@miraclelinux.com>
     4	Amir Goldstein <amir73il@gmail.com>
     4	Marius Kittler <mkittler@suse.de>
     3	Richard Palethorpe <rpalethorpe@suse.com>
     3	Ci Zhou <zhouci@ruijie.com.cn>
     2	Damien Le Moal <dlemoal@kernel.org>
     2	Jan Kara <jack@suse.cz>
     2	Konstantin Khorenko <khorenko@virtuozzo.com>
     2	Min Li <limin154@huawei.com>
     2	Murphy Zhou <jencce.kernel@gmail.com>
     2	Vishal Chourasia <vishalc@linux.ibm.com>
     1	Ashwin Dayanand Kamat <kashwindayan@vmware.com>
     1	Duncan.chu <wqhaicyj@163.com>
     1	Dylan Jhong <dylan@andestech.com>
     1	Edward Liaw <edliaw@google.com>
     1	Hongchen Zhang <zhanghongchen@loongson.cn>
     1	Jeff Layton <jlayton@kernel.org>
     1	Leo Yu-Chi Liang <ycliang@andestech.com>
     1	Nageswara R Sastry <rnsastry@linux.ibm.com>
     1	Randolph <randolph@andestech.com>
     1	Rick Edgecombe <rick.p.edgecombe@intel.com>
     1	Shizhao Chen <shichen@redhat.com>
     1	Takuya Wakazono <pastalian46@gmail.com>
     1	Zachary Leaf <zachary.leaf@arm.com>
     1	Li Qiang <liqiang64@huawei.com>
     1	Ioannis Bonatakis <ybonatakis@suse.com>

And also thanks to patch reviewers:

$ git log 20230516.. | grep -Ei '(reviewed|acked)-by:' | sed 's/.*by: //' | sort | uniq -c | sort -n -r
    104 Cyril Hrubis <chrubis@suse.cz>
     66 Petr Vorel <pvorel@suse.cz>
     46 Li Wang <liwang@redhat.com>
     15 Martin Doucha <mdoucha@suse.cz>
     14 Avinesh Kumar <akumar@suse.de>
     14 Richard Palethorpe <rpalethorpe@suse.com>
      8 Xiao Yang <yangx.jy@fujitsu.com>
      3 Niklas Cassel <niklas.cassel@wdc.com>
      3 Marius Kittler <mkittler@suse.de>
      3 Damien Le Moal <dlemoal@kernel.org>
      2 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
      2 Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
      2 Linus Walleij <linus.walleij@linaro.org>
      2 Amir Goldstein <amir73il@gmail.com>
      1 Yang Xu <xuyang2018.jy@fujitsu.com>
      1 Vlastimil Babka <vbabka@suse.cz>
      1 Murphy Zhou <jencce.kernel@gmail.com>
      1 Jeff Moyer <jmoyer@redhat.com>
      1 Andrea Cervesato <andrea.cervesato@suse.com>
