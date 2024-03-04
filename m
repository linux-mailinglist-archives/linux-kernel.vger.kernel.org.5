Return-Path: <linux-kernel+bounces-90494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D14870012
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8141C2106B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E884738DF7;
	Mon,  4 Mar 2024 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PIUVzZKr"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5176374FC;
	Mon,  4 Mar 2024 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550928; cv=none; b=rKzCiKEu1bge9VBo//PBUlQXHcWOSNn+0Vq3d7ZPkqNbrhImTSVI1wErC5hLL+gmqUN4yzApWm711oUdBY5Cfuf/FXE8bVbNhhKSJOpQ9FFKwEEdmVAhQSBCzic+ITVxbwSFkEX9j9HDTD/rtnAm9cDVPk8kYJ6AaO7RS0DB1Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550928; c=relaxed/simple;
	bh=I+1LKBKyDdSD8etDBGgYa4NJ520rUBsIlRMiUVOajK4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tEA+uaREjF/BuNvzzwl9dNa5BMeK9inCWvvsNYzti3T7EUXomBQVdxlWYp1YhVYibzTKOK2dijGft2tzc8MuztDe6xWd+WKSamKF4rL5qj2BKyR2t9Pfw+yKxJ1XiskXeqweVnHeq7Q36txnUIH8KgPbBqvJtdAfVYIK8JQptYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PIUVzZKr; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709550922; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+KToDONWSyU96YdlBLNtPCPCwLodjffJBV7loL7KhQU=;
	b=PIUVzZKruNCk/DNJHFJvU5G+Z4hmYTUcimxbYwxFE+rMlc2hxzI1WSXcWQ4LIYllezlpe3/SSoH3kUEdySu5OTwe+9JJqs0h69v8Aefa4o8Zmvj76w4CNiqDiPLiBOdKy+H8Yj5M0WAnlQyCigHsSteIrlPoQkvhup9sWVqhULQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W1oM1bh_1709550918;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0W1oM1bh_1709550918)
          by smtp.aliyun-inc.com;
          Mon, 04 Mar 2024 19:15:21 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	lpieralisi@kernel.org,
	guohanjun@huawei.com,
	sudeep.holla@arm.com,
	xueshuai@linux.alibaba.com,
	baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH 0/2] ARM Error Source Table V1 Support
Date: Mon,  4 Mar 2024 19:15:15 +0800
Message-Id: <20240304111517.33001-1-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the ARM Error Source Table (AEST) based on
the 1.1 version of ACPI for the Armv8 RAS Extensions [0].

The Arm Error Source Table (AEST) enable kernel-first handling of errors
in a system that supports the Armv8 RAS extensions. Hardware errors will
trigger a RAS interrupt to kernel, kernel scan all AEST node to fine
error node which occur error in irq context and use a workqueue to log
this hardware errors.

I have tested this series on PTG Yitian710 SOC. Both corrected and
uncorrected errors were tested to verify the non-fatal vs fatal
scenarios.

Future work:
1. UE trigger memory_failure other than panic.
2. Add CE storm mitigation.
3. Support AEST V2.

This series is based on Tyler Baicar's patches [1], which do not have v2
sended to mail list yet. Change from origin patch:
1. Add a genpool to collect all AEST error, and log them in a workqueue
other than in irq context.
2. Just use the same one aest_proc function for system register interface
and MMIO interface.
3. Reconstruct some structures and functions to make it more clear.
4. Accept all comments in Tyler Baicar's mail list.

[0]: https://developer.arm.com/documentation/den0085/0101/
[1]: https://lore.kernel.org/all/20211124170708.3874-1-baicar@os.amperecomputing.com/

Tyler Baicar (2):
  ACPI/AEST: Initial AEST driver
  trace, ras: add ARM RAS extension trace event

 MAINTAINERS                  |  11 +
 arch/arm64/include/asm/ras.h |  38 ++
 drivers/acpi/arm64/Kconfig   |  10 +
 drivers/acpi/arm64/Makefile  |   1 +
 drivers/acpi/arm64/aest.c    | 728 +++++++++++++++++++++++++++++++++++
 include/linux/acpi_aest.h    |  91 +++++
 include/linux/cpuhotplug.h   |   1 +
 include/ras/ras_event.h      |  55 +++
 8 files changed, 935 insertions(+)
 create mode 100644 arch/arm64/include/asm/ras.h
 create mode 100644 drivers/acpi/arm64/aest.c
 create mode 100644 include/linux/acpi_aest.h

-- 
2.33.1


