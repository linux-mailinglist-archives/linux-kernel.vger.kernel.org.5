Return-Path: <linux-kernel+bounces-44466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 347FE842268
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E049F290EC7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0959F66B5F;
	Tue, 30 Jan 2024 11:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SDSghpIS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9yr/rAM4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qmPdSS5T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+i24So+s"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E427F66B26
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613179; cv=none; b=DrRs+MSfZZRUlGtik4BVPRnUYjJpMybz7vX02aH+4A4KTCtmbupkKI93sX7X8AieLEXGeDCXSS1DugOkny5eFbgQjCbf2aJC+QJCcmEw97/pddt0NPKP41ltuMhyhTc3WTak/DU8DmrDDPfK1WLwnIrXW+gpDFpZFuNl09Z7fmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613179; c=relaxed/simple;
	bh=3iEbLDOu9nt8iOdGf5LsQJCKQamAr4+HCLfGDWLOBvA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cOPLJD4fxuojc8ZxistPlymDtNshFmfl8nKUQOnORlVFs70AO4Ghi9tTeJ6doUPSmhzmxMmQHYQrrAlath5VcutQN/rJ+JhUUOtoaIqxEaBs6iyjHhLax1j382Hj0Bg9qCSJOYS6C3EX3D1nh2Zk41FWJDAUYcsAZrdKMD0TD1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SDSghpIS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9yr/rAM4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qmPdSS5T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+i24So+s; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BE9B91F842;
	Tue, 30 Jan 2024 11:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706613175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Dxati+qBxOFlcNbXmMq5JTlEeeYaTlm8C204WS2tk6Y=;
	b=SDSghpIS1VC6hue7r6ICL4g4GrlOkEvelRnj+OvyR51Yl2L7TUMk4r2Du3vDCmsWNkuo2w
	GhxAYj9uQcyCzKAxg+L9A0Gx/Nnu2j+t2C0e1ZnZnLU86yFvEdAzo00Xgw/HAaxKRRNnxA
	KAlzK9Xmz8g52TRvpoxgtNi+RK4x7Es=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706613175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Dxati+qBxOFlcNbXmMq5JTlEeeYaTlm8C204WS2tk6Y=;
	b=9yr/rAM4ph06CMsk3bDUI1rCGaBmqAOqVNtZfsW05i5BAihtixsuxdJ4C9KOu9Q65j56d4
	Wbw1BS5nYLE5gNCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706613174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Dxati+qBxOFlcNbXmMq5JTlEeeYaTlm8C204WS2tk6Y=;
	b=qmPdSS5Tx5H3lAFbxyR3ESCpmaff0bUGmDdttAPE7U5RqVhvsJNEhN/U9/zKofQJ8L9XgF
	oKvM0euzjcCv4nr/JdL2zAf73EuwpEjoxuJeevOFPfQSiJ9EIIPxFFG5BvRngTWM3gFU0/
	CQHz8666joghY6VA3QwiC0d/b4fXoKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706613174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Dxati+qBxOFlcNbXmMq5JTlEeeYaTlm8C204WS2tk6Y=;
	b=+i24So+s85ujDoaDcqYJMLNVGepWBiH2meklDrKvizTHucYoN9m9zybrbsQ0I5G3WDv5vv
	79lvFPeXbMqkXUCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD99212FF7;
	Tue, 30 Jan 2024 11:12:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WzRjKbbZuGXTPgAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Tue, 30 Jan 2024 11:12:54 +0000
Date: Tue, 30 Jan 2024 12:13:11 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it, linux-kernel@vger.kernel.org,
	libc-alpha@sourceware.org
Cc: lwn@lwn.net, akpm@linux-foundation.org, torvalds@linux-foundation.org
Subject: [ANNOUNCE] The Linux Test Project has been released for JANUARY 2024
Message-ID: <ZbjZxy4vbxoXUJ-i@yuki>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qmPdSS5T;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+i24So+s
X-Spamd-Result: default: False [-4.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_IN_DNSWL_HI(-1.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BE9B91F842
X-Spam-Level: 
X-Spam-Score: -4.81
X-Spam-Flag: NO

Good news everyone,

the Linux Test Project test suite stable release for *January 2024* has been
released.

Since the last release 315 patches by 34 authors were merged.

Patch review is what most of the projects struggle with and LTP is no
different. If you can spare some effort helping with the patch review is more
than welcomed.

NOTABLE CHANGES
===============

* New tests
  - splice07, accept03, readahead01:

    Tests that feeds the syscall all kinds of invalid file descriptors and
    checks that the syscall fails properly.

   - proc_sched_rt01 a regression test for:

     c1fc6484e1fb ("sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset")
     079be8fc6309 ("sched/rt: Disallow writing invalid values to sched_rt_period_us")

  - ksm07 a test for KSM smart-scan.

  - pathconf02 negative testcases for pathconf()

  - pipe15 A regresson test for:

    46c4c9d1beb7 ("pipe: increase minimum default pipe size to 2 pages")

  - nft02 A regression test for:

     515ad530795c ("netfilter: nf_tables: do not ignore genmask when looking up chain by id") aka CVE-2023-31248

  - sched_setscheduler04 a test for SCHED_RESET_ON_FORK

  - setsockopt10 2c02d41d71f9 ("net/ulp: prevent ULP without clone op from entering the LISTEN status") aka CVE-2023-0461

  - gettid02 A basic gettid02 test.

  - splice06 A test that splicing from a /proc files works.

* Increased coverage

   - ioctl02 cover more modern termios ioctls() as well.

   - fanotify13 More test coverage for overlayfs.

   - input* test now check UI_GET_NAME ioctl() too.

* Removed tests

   - fork12 Which was a naive fork bomb test, we do have other tests
            (setrlimit01.c, ...) that better cover this scenario.

   - mongo test framework

     Which was test reiser, ext2 and jfs unmaintained for a decade.

   - simple_tracer.c Tracing test from 2009 that does not compile anymore.

   - runtest/fsx-linux This is consolidation of runtest files, since these test
                       duplicated in ltp-aiodio.part3.

   - testscripts/autofs{1,4}.sh, testscripts/sysfs.sh,
     testscripts/ltp-scsi_debug.sh, testscripts/ltpdmmapper.sh

     These were unmaintained and unused scripts.

   - scsi/* A testsuite with a custom kernel module for kernel 2.5 that didn't
            compile cleanly for decades.

   - load_stress_all_kernel_modules.sh Broken for quite some time.

* The LTP library now has a functions to iterate over different
  file descriptors. That allows us to easily implement more comprehensive tests
  that feed various syscalls all possible file descriptors and check that the
  syscall fails properly with invalid combinations. Most notable use of this
  library is the newly introduced splice07.c test.

* The minimal size of the device for a few filesystem tests was increased to
  1GB because modern filesystems, most notably Btrfs does not work properly on
  smaller devices.

* LTP now tests bcachefs if kernel support and bcache.mkfs is present

* 30 testcases were converted to the new test library

+ The usual amount of fixes and cleanups

NOTABLE CHANGES IN NETWORK TESTS
================================
brought to you by Petr Vorel

The performance tests in net.features can be now skipped by setting
LTP_NET_FEATURES_IGNORE_PERFORMANCE_FAILURE=1 which is useful when testing is
executed on VMs on a overloaded host or if we are running tests with a
background load.

KIRK (previously RUNLTP-NG)
===========================

Kirk was updated to v1.2

This version brings the following updates:

 - show both stdout and stderr when executing tests on host
 - support for external commands on different SUTs
 - warning message when SUT doesn't support parallel execution
 - more stable epoll() communication with LTX
 - minor fixes
 - updated documentation

DOWNLOAD AND LINKS
==================

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

https://github.com/linux-test-project/ltp/releases/tag/20240129

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

git shortlog -s -e -n 20230929..

   147  Petr Vorel <pvorel@suse.cz>
    25  Yang Xu <xuyang2018.jy@fujitsu.com>
    21  Andrea Cervesato <andrea.cervesato@suse.com>
    18  Martin Doucha <mdoucha@suse.cz>
    12  Cyril Hrubis <chrubis@suse.cz>
    11  Marius Kittler <mkittler@suse.de>
     8  Wei Gao <wegao@suse.com>
     7  Amir Goldstein <amir73il@gmail.com>
     7  Richard Palethorpe <rpalethorpe@suse.com>
     6  Avinesh Kumar <akumar@suse.de>
     6  Edward Liaw <edliaw@google.com>
     6  Jan Kara <jack@suse.cz>
     5  Jan Stancek <jstancek@redhat.com>
     4  Hongchen Zhang <zhanghongchen@loongson.cn>
     4  Kevin Brodsky <kevin.brodsky@arm.com>
     4  Xiao Yang <yangx.jy@fujitsu.com>
     3  Shiyang Ruan <ruansy.fnst@fujitsu.com>
     2  Li Wang <liwang@redhat.com>
     2  Li Zhijian <lizhijian@fujitsu.com>
     2  Pengfei Xu <pengfei.xu@intel.com>
     2  Stefan Roesch <shr@devkernel.io>
     1  Alexander Kanavin <alex@linutronix.de>
     1  Brennan Ashton <bashton@brennanashton.com>
     1  Korobeynikov Gleb <mathkgd@mail.ru>
     1  Marcos Paulo de Souza <mpdesouza@suse.com>
     1  Mengchi Cheng <mengcc@amazon.com>
     1  Murphy Zhou <jencce.kernel@gmail.com>
     1  Shizhao Chen <shichen@redhat.com>
     1  Shoukui Zhang <zhangshoukui@xiaomi.com>
     1  Subramanya Swamy <subramanya.swamy.linux@gmail.com>
     1  haopengxiang <haopengxiang@xiaomi.com>
     1  nietingting <nietingting@xiaomi.com>
     1  wangxuewen <wangxuewen@kylinos.cn>
     1  ybonatakis <ybonatakis@suse.com>

And also thanks to patch reviewers:

git log 20230929.. | grep -Ei '(reviewed|acked)-by:' | sed 's/.*by: //' | sort | uniq -c | sort -n -r

    111 Petr Vorel <pvorel@suse.cz>
     70 Cyril Hrubis <chrubis@suse.cz>
     47 Li Wang <liwang@redhat.com>
     35 Richard Palethorpe <rpalethorpe@suse.com>
     14 Martin Doucha <mdoucha@suse.cz>
      8 Amir Goldstein <amir73il@gmail.com>
      7 Xiao Yang <yangx.jy@fujitsu.com>
      7 Marius Kittler <mkittler@suse.de>
      6 Jan Kara <jack@suse.cz>
      4 Avinesh Kumar <akumar@suse.de>
      3 Andrea Cervesato <andrea.cervesato@suse.com>
      3 Jan Stancek <jstancek@redhat.com>
      2 Yang Xu <xuyang2018.jy@fujitsu.com>
      1 Petr Vorel <petr.vorel@gmail.com>
      1 Christian Brauner <brauner@kernel.org>
-- 
Cyril Hrubis
chrubis@suse.cz

