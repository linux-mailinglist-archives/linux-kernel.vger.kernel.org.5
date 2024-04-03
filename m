Return-Path: <linux-kernel+bounces-130400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7A6897795
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF6B41C24165
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9861715382E;
	Wed,  3 Apr 2024 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NmDDOIpl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62CF14E2F9;
	Wed,  3 Apr 2024 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167003; cv=none; b=hWRXeBHlW+jK8qgmm4uzhesitpzseJt4DWg6KzCwczj0yvaXG7jqHVw3wL3jYr/ATmQ0X224keOz/zLWUzzNtC1psMtk/VJ4BmWlZdgwrbu+DOuzQJT8kOiyexQZJJITXgd0mSrRRAgYDj3r2764m9fFuFfkJaRoS382PWbBzH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167003; c=relaxed/simple;
	bh=IFDV1xb914cHALB3Pl3nf2SP1HjqdcJS3i04MrHq1c0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DM2dQNYIB99shzcIX5B2c6KYuyLmP8EGDEVzYMBuJJ6OB8EZB0apYwWlLL/pO9P6C7dn7W+PSD3ynOzDbnRWr+j+6WDKoy0tNq61fLe9C93zT2Jo+VRhdGDAKvb7zHynu1oDxQ5z1bUkiioHb41LSH7d1TdoGidn6FVKCKHogOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NmDDOIpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA2AC433C7;
	Wed,  3 Apr 2024 17:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712167003;
	bh=IFDV1xb914cHALB3Pl3nf2SP1HjqdcJS3i04MrHq1c0=;
	h=From:To:Cc:Subject:Date:From;
	b=NmDDOIplg9Yo/WqbBOuE0eVjopT1v1ikqn8H45deJhZRopFA0WUqez8r6NquUsUuf
	 12BcNMy/9XrERdZVc7SYe1THid1zPjFenM3lhFIujgKsMp2uSeFVSLVVJZrTgXX+eK
	 APu06ohtkUnPUFvrOTHs5czfVyquY+SxhbugBWPc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	allen.lkml@gmail.com,
	broonie@kernel.org
Subject: [PATCH 6.6 00/11] 6.6.25-rc1 review
Date: Wed,  3 Apr 2024 19:55:49 +0200
Message-ID: <20240403175126.839589571@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.25-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.25-rc1
X-KernelTest-Deadline: 2024-04-05T17:51+00:00
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.6.25 release.
There are 11 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 05 Apr 2024 17:51:13 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.25-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.6.25-rc1

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "workqueue.c: Increase workqueue name length"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "workqueue: Move pwq->max_active to wq->max_active"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "workqueue: Factor out pwq_is_empty()"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "workqueue: Replace pwq_activate_inactive_work() with [__]pwq_activate_work()"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "workqueue: Move nr_active handling into helpers"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "workqueue: Make wq_adjust_max_active() round-robin pwqs while activating"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "workqueue: RCU protect wq->dfl_pwq and implement accessors for it"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "workqueue: Introduce struct wq_node_nr_active"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "workqueue: Implement system-wide nr_active enforcement for unbound workqueues"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "workqueue: Don't call cpumask_test_cpu() with -1 CPU in wq_update_node_max_active()"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "workqueue: Shorten events_freezable_power_efficient name"


-------------

Diffstat:

 Makefile                  |   4 +-
 include/linux/workqueue.h |  35 +--
 kernel/workqueue.c        | 757 ++++++++--------------------------------------
 3 files changed, 132 insertions(+), 664 deletions(-)



