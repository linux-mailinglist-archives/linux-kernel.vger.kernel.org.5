Return-Path: <linux-kernel+bounces-110621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF8D88615F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5101C21899
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2411F134432;
	Thu, 21 Mar 2024 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="WK54Qvh1"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64403134422;
	Thu, 21 Mar 2024 19:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711051092; cv=none; b=HI0RkLwtuJcgn4SByP6wMD1P1cJ25lCV6+gauRWRWYf7TyifY9bUD2uRqk7YC7S2/neIwg3Z4lo9sTrRM7Sf5ipZRFQmrnYx1+uqPRrXNMOF88aqhj2YkTMwyKWryeZk7qjQr5Nt1VDRpLCK2eB3BUpYrD0VTMQKFAWJ8Q41bcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711051092; c=relaxed/simple;
	bh=wIJ+KoMAFPGnOWz5mM3Dq9a7rmOXRTwxGoBU1sVmoL4=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=aK+SZF6qnZXffVS8N1nezyr0HSTC2yKir2G4c+9MO1q6M3JPxcfWdrl54+jvJsU/yKP2zHBgD9RyjSlhZA5zxSQBf/YzlKRlI+EODsgUGoUVFH+2hROmE/znu5Ecmz3pp4WFzWtLbIYceYPCsMdmJBTWULS2Y5/Rpj3Bc4S3CjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=WK54Qvh1; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1711051082;
	bh=wIJ+KoMAFPGnOWz5mM3Dq9a7rmOXRTwxGoBU1sVmoL4=;
	h=Date:From:To:Subject:From;
	b=WK54Qvh1bgK7dT+NGgBXVvwdpHWgQ/wyYWqJ3k6KU2r8dbrWB8L4wVDHZ6ah6Sz/2
	 WPqojASp201H8wu40iEmI1DnHEbrIAlQIZJ4OtxokQpw7EpHTIRjR2Mp0ryEOWrlvR
	 3Hd3bGK6RCgoB4CcHa8gpsTeRseussEa2PZuQScZtRhHCvBmRltPy/rTU0/5Ci/3yU
	 TfOWALeQ0OHezT9OIc7Wn613GQVILk3U6a9wgPG5bE3eHBCv3zNpo14KW4PSpgKOM6
	 sf9kFti6bEp34H0A1oZWJemci+RSWxxKcKoDlkRlyhSa03ei5pzcZbPLrE6vSt2e/p
	 3j4PvfSkWV9oQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4V0x8V1C3tzlr8;
	Thu, 21 Mar 2024 15:58:02 -0400 (EDT)
Message-ID: <b0c3b8ec-90fe-4813-8df5-92168f621808@efficios.com>
Date: Thu, 21 Mar 2024 15:58:22 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: lttng-dev <lttng-dev@lists.lttng.org>,
 Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RELEASE] LTTng-modules 2.12.16 and 2.13.12 (Linux kernel tracer)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This is a release announcement for the currently maintained
LTTng-modules Linux kernel tracer stables branches.

* New and noteworthy in these releases:

Linux kernel v6.8 is now supported by LTTng modules 2.13.12. If you need
support for recent kernels (v5.18+), you will need to upgrade to a
recent LTTng-modules 2.13.x.

Both releases correct issues with SLE kernel version ranges detection.

A compilation fix for RHEL 9.3 kernel is present in v2.13.12.

Feedback is welcome!

Thanks,

Mathieu

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

Detailed change logs:

2024-03-21 (National Common Courtesy Day) LTTng modules 2.13.12
         * docs: Add supported versions and fix-backport policy
         * docs: Add links to project resources
         * Fix: Correct minimum version in jbd2 SLE kernel range
         * Fix: Handle recent SLE major version codes
         * Fix: build on sles15sp4
         * Compile fixes for RHEL 9.3 kernels
         * Fix: ext4_discard_preallocations changed in linux 6.8.0-rc3
         * Fix: btrfs_get_extent flags and compress_type changed in linux 6.8.0-rc1
         * Fix: btrfs_chunk tracepoints changed in linux 6.8.0-rc1
         * Fix: strlcpy removed in linux 6.8.0-rc1
         * Fix: timer_start changed in linux 6.8.0-rc1
         * Fix: sched_stat_runtime changed in linux 6.8.0-rc1

2024-03-21 (National Common Courtesy Day) 2.12.16
         * fix: lttng-probe-kvm-x86-mmu build with linux 6.6
         * docs: Add supported versions and fix-backport policy
         * docs: Add links to project resources
         * Fix: Correct minimum version in jbd2 SLE kernel range
         * Fix: Handle recent SLE major version codes
         * Fix: build on sles15sp4

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

