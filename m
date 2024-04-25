Return-Path: <linux-kernel+bounces-158981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1E58B27BB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A171F25B7F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1D814EC42;
	Thu, 25 Apr 2024 17:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="SjUUi0IJ"
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8610714E2FA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714067404; cv=none; b=P5NpAGiPlQbYU0jrlQXPTTixHtFWs9ezDBKNVnYFXeP0fArW1P0w1Kq4840Z1OhndCn2N3A5Q8rZQPln3rsw104xwUISm6ilKzoWAdRoFuRyyAwvYFhRyuJXmGE1WCo8SeftQslbopDIVC/ywM7thp58TvhI4UOg4mpW9y9UQ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714067404; c=relaxed/simple;
	bh=Wcp+Os6j8PSxfC/nvGvMV2CKI+zcJnPAX63EWSKy9zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVcnhKhMCNhK/akJfXPrYm4JFYdpZrsc/Zl91JGfSe8zv3Mepd2rnwMh1J4WtZtEgnPyBrkvt6Aho8gSpl8HjlWzb1AB9tZ11UrY6OPD5iIjzTcueHmMhBwnFH4I5KsYpnBfemCtCLw5ppJmT6c24UmRPx6J2R5I5uHn7GQ0ExE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=SjUUi0IJ; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VQNfW00KyzB2p;
	Thu, 25 Apr 2024 19:49:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714067394;
	bh=Wcp+Os6j8PSxfC/nvGvMV2CKI+zcJnPAX63EWSKy9zQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SjUUi0IJOshpQJ9nZ56s7gT/r7Qb/c12WMGE5uDH6WhD3GXyz/oolIi7D2oxL/05R
	 KBERmBy12eBABcWlzrPlKqCgOrfX/3Z4EudkMwQXRT57q0P9ODnE6NDxbRmnW67Tlf
	 dLNcDx63I2XuiJKdzqBA6S1yAm81UU/zQGl+WHSY=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VQNfT6fSQzBnF;
	Thu, 25 Apr 2024 19:49:53 +0200 (CEST)
Date: Thu, 25 Apr 2024 19:49:52 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: kernel test robot <oliver.sang@intel.com>, 
	Christian Brauner <brauner@kernel.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Shuah Khan <shuah@kernel.org>, Will Drewry <wad@chromium.org>, 
	Kees Cook <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [linus:master] [selftests/harness]  0710a1a73f:
 kernel-selftests.pidfd.pidfd_setns_test.fail
Message-ID: <20240425.Oofoi5oghoo6@digikod.net>
References: <202403291015.1fcfa957-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202403291015.1fcfa957-oliver.sang@intel.com>
X-Infomaniak-Routing: alpha

FYI, I'm working on this issue.

Regards,
 Mickaël

On Fri, Mar 29, 2024 at 10:42:51AM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "kernel-selftests.pidfd.pidfd_setns_test.fail" on:
> 
> commit: 0710a1a73fb45033ebb06073e374ab7d44a05f15 ("selftests/harness: Merge TEST_F_FORK() into TEST_F()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master 4cece764965020c22cff7665b18a012006359095]
> 
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-4306b286-1_20240301
> with following parameters:
> 
> 	group: pidfd
> 
> 
> 
> compiler: gcc-12
> test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202403291015.1fcfa957-oliver.sang@intel.com
> 
> 
> 
> # timeout set to 300
> # selftests: pidfd: pidfd_setns_test
> # TAP version 13
> # 1..7
> # # Starting 7 tests from 2 test cases.
> # #  RUN           global.setns_einval ...
> # #            OK  global.setns_einval
> # ok 1 global.setns_einval
> # #  RUN           current_nsset.invalid_flags ...
> # # pidfd_setns_test.c:161:invalid_flags:Expected self->child_pid_exited (0) > 0 (0)
> # #            OK  current_nsset.invalid_flags
> # ok 2 current_nsset.invalid_flags
> # #  RUN           current_nsset.pidfd_exited_child ...
> # # pidfd_setns_test.c:161:pidfd_exited_child:Expected self->child_pid_exited (0) > 0 (0)
> # #            OK  current_nsset.pidfd_exited_child
> # ok 3 current_nsset.pidfd_exited_child
> # #  RUN           current_nsset.pidfd_incremental_setns ...
> # # pidfd_setns_test.c:161:pidfd_incremental_setns:Expected self->child_pid_exited (0) > 0 (0)
> # # pidfd_setns_test.c:408:pidfd_incremental_setns:Managed to correctly setns to user namespace of 45423 via pidfd 20
> # # pidfd_setns_test.c:408:pidfd_incremental_setns:Managed to correctly setns to mnt namespace of 45423 via pidfd 20
> # # pidfd_setns_test.c:408:pidfd_incremental_setns:Managed to correctly setns to pid namespace of 45423 via pidfd 20
> # # pidfd_setns_test.c:408:pidfd_incremental_setns:Managed to correctly setns to uts namespace of 45423 via pidfd 20
> # # pidfd_setns_test.c:408:pidfd_incremental_setns:Managed to correctly setns to ipc namespace of 45423 via pidfd 20
> # # pidfd_setns_test.c:408:pidfd_incremental_setns:Managed to correctly setns to net namespace of 45423 via pidfd 20
> # # pidfd_setns_test.c:408:pidfd_incremental_setns:Managed to correctly setns to cgroup namespace of 45423 via pidfd 20
> # # pidfd_setns_test.c:408:pidfd_incremental_setns:Managed to correctly setns to pid_for_children namespace of 45423 via pidfd 20
> # # pidfd_setns_test.c:391:pidfd_incremental_setns:Expected setns(self->child_pidfd1, info->flag) (-1) == 0 (0)
> # # pidfd_setns_test.c:392:pidfd_incremental_setns:Too many users - Failed to setns to time namespace of 45423 via pidfd 20
> # # pidfd_incremental_setns: Test terminated by timeout
> # #          FAIL  current_nsset.pidfd_incremental_setns
> # not ok 4 current_nsset.pidfd_incremental_setns
> # #  RUN           current_nsset.nsfd_incremental_setns ...
> # # pidfd_setns_test.c:161:nsfd_incremental_setns:Expected self->child_pid_exited (0) > 0 (0)
> # # pidfd_setns_test.c:444:nsfd_incremental_setns:Managed to correctly setns to user namespace of 45524 via nsfd 19
> # # pidfd_setns_test.c:444:nsfd_incremental_setns:Managed to correctly setns to mnt namespace of 45524 via nsfd 24
> # # pidfd_setns_test.c:444:nsfd_incremental_setns:Managed to correctly setns to pid namespace of 45524 via nsfd 27
> # # pidfd_setns_test.c:444:nsfd_incremental_setns:Managed to correctly setns to uts namespace of 45524 via nsfd 30
> # # pidfd_setns_test.c:444:nsfd_incremental_setns:Managed to correctly setns to ipc namespace of 45524 via nsfd 33
> # # pidfd_setns_test.c:444:nsfd_incremental_setns:Managed to correctly setns to net namespace of 45524 via nsfd 36
> # # pidfd_setns_test.c:444:nsfd_incremental_setns:Managed to correctly setns to cgroup namespace of 45524 via nsfd 39
> # # pidfd_setns_test.c:444:nsfd_incremental_setns:Managed to correctly setns to pid_for_children namespace of 45524 via nsfd 42
> # # pidfd_setns_test.c:427:nsfd_incremental_setns:Expected setns(self->child_nsfds1[i], info->flag) (-1) == 0 (0)
> # # pidfd_setns_test.c:428:nsfd_incremental_setns:Too many users - Failed to setns to time namespace of 45524 via nsfd 45
> # # nsfd_incremental_setns: Test terminated by timeout
> # #          FAIL  current_nsset.nsfd_incremental_setns
> # not ok 5 current_nsset.nsfd_incremental_setns
> # #  RUN           current_nsset.pidfd_one_shot_setns ...
> # # pidfd_setns_test.c:161:pidfd_one_shot_setns:Expected self->child_pid_exited (0) > 0 (0)
> # # pidfd_setns_test.c:462:pidfd_one_shot_setns:Adding user namespace of 45630 to list of namespaces to attach to
> # # pidfd_setns_test.c:462:pidfd_one_shot_setns:Adding mnt namespace of 45630 to list of namespaces to attach to
> # # pidfd_setns_test.c:462:pidfd_one_shot_setns:Adding pid namespace of 45630 to list of namespaces to attach to
> # # pidfd_setns_test.c:462:pidfd_one_shot_setns:Adding uts namespace of 45630 to list of namespaces to attach to
> # # pidfd_setns_test.c:462:pidfd_one_shot_setns:Adding ipc namespace of 45630 to list of namespaces to attach to
> # # pidfd_setns_test.c:462:pidfd_one_shot_setns:Adding net namespace of 45630 to list of namespaces to attach to
> # # pidfd_setns_test.c:462:pidfd_one_shot_setns:Adding cgroup namespace of 45630 to list of namespaces to attach to
> # # pidfd_setns_test.c:462:pidfd_one_shot_setns:Adding pid_for_children namespace of 45630 to list of namespaces to attach to
> # # pidfd_setns_test.c:462:pidfd_one_shot_setns:Adding time namespace of 45630 to list of namespaces to attach to
> # # pidfd_setns_test.c:466:pidfd_one_shot_setns:Expected setns(self->child_pidfd1, flags) (-1) == 0 (0)
> # # pidfd_setns_test.c:467:pidfd_one_shot_setns:Too many users - Failed to setns to namespaces of 45630
> # # pidfd_one_shot_setns: Test terminated by timeout
> # #          FAIL  current_nsset.pidfd_one_shot_setns
> # not ok 6 current_nsset.pidfd_one_shot_setns
> # #  RUN           current_nsset.no_foul_play ...
> # # pidfd_setns_test.c:161:no_foul_play:Expected self->child_pid_exited (0) > 0 (0)
> # # pidfd_setns_test.c:506:no_foul_play:Adding user namespace of 45737 to list of namespaces to attach to
> # # pidfd_setns_test.c:506:no_foul_play:Adding mnt namespace of 45737 to list of namespaces to attach to
> # # pidfd_setns_test.c:506:no_foul_play:Adding pid namespace of 45737 to list of namespaces to attach to
> # # pidfd_setns_test.c:506:no_foul_play:Adding uts namespace of 45737 to list of namespaces to attach to
> # # pidfd_setns_test.c:506:no_foul_play:Adding ipc namespace of 45737 to list of namespaces to attach to
> # # pidfd_setns_test.c:506:no_foul_play:Adding net namespace of 45737 to list of namespaces to attach to
> # # pidfd_setns_test.c:506:no_foul_play:Adding cgroup namespace of 45737 to list of namespaces to attach to
> # # pidfd_setns_test.c:506:no_foul_play:Adding time namespace of 45737 to list of namespaces to attach to
> # # pidfd_setns_test.c:510:no_foul_play:Expected setns(self->child_pidfd1, flags) (-1) == 0 (0)
> # # pidfd_setns_test.c:511:no_foul_play:Too many users - Failed to setns to namespaces of 45737 vid pidfd 20
> # # no_foul_play: Test terminated by timeout
> # #          FAIL  current_nsset.no_foul_play
> # not ok 7 current_nsset.no_foul_play
> # # FAILED: 3 / 7 tests passed.
> # # Totals: pass:3 fail:4 xfail:0 xpass:0 skip:0 error:0
> not ok 7 selftests: pidfd: pidfd_setns_test # exit=1
> make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-0710a1a73fb45033ebb06073e374ab7d44a05f15/tools/testing/selftests/pidfd'
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240329/202403291015.1fcfa957-oliver.sang@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
> 

