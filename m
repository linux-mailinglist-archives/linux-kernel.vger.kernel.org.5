Return-Path: <linux-kernel+bounces-52513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2231784992B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1CE428A724
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE0D1AAA9;
	Mon,  5 Feb 2024 11:47:29 +0000 (UTC)
Received: from out0-209.mail.aliyun.com (out0-209.mail.aliyun.com [140.205.0.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73A01AAB9
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707133649; cv=none; b=i34xm8AC2DFyr1eU2w1BKG24D+IkKU+ucO/3dJ6exAyK70Rj5hoIEvg02G5VyPZBVDhOQcVOzIU7FfWRTRjudIpExVIcgRuXneP66lsjoXEm+LcIRDL60vL38ZHmqc1gZsJPrFH4z5p9dzQdEMuzujNqfZT0810/yzUC4AQxzn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707133649; c=relaxed/simple;
	bh=z6IhGnhSPC1q5SH2k68uA0M5HTX/zBRN+v0ZXJZVVHM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VhAO7X2VXtRkz3kOthWyr41R+ATexbkKQ1DSlbepG4iVn+Vc9AH+gAgIp32ciTpB0YSG1ShOFv73HZs8XBkxjk+JdHmLNzX5sTlBSOeXqLhdQ7JEELNxecRHT8OxlxvTKUb/E5wdMj0//7FytDTbQxlcDbG6lqiOyV9Q+1R+Lhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; arc=none smtp.client-ip=140.205.0.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047194;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.WNt.HlX_1707133633;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.WNt.HlX_1707133633)
          by smtp.aliyun-inc.com;
          Mon, 05 Feb 2024 19:47:17 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 0/6] um: Minor fixes and cleanups
Date: Mon, 05 Feb 2024 19:47:02 +0800
Message-Id: <20240205114708.25235-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A series of minor fixes and cleanups for UML.

Changes since v1:
https://lore.kernel.org/lkml/20240123110347.1274217-1-tiwei.btw@antgroup.com/
- Add "um: Stop tracking host PID in cpu_tasks";
- Add missing headers for i386;

Tiwei Bie (6):
  um: Make local functions and variables static
  um: Fix the declaration of vfree
  um: Remove unused functions
  um: Fix the return type of __switch_to
  um: Add missing headers
  um: Stop tracking host PID in cpu_tasks

 arch/um/drivers/pcap_kern.c              |  4 +--
 arch/um/drivers/ubd_user.c               |  2 +-
 arch/um/include/shared/as-layout.h       |  1 -
 arch/um/include/shared/um_malloc.h       |  2 +-
 arch/um/kernel/kmsg_dump.c               |  2 +-
 arch/um/kernel/mem.c                     |  2 ++
 arch/um/kernel/process.c                 | 46 ++++++------------------
 arch/um/kernel/reboot.c                  |  1 +
 arch/um/kernel/skas/mmu.c                |  1 +
 arch/um/kernel/skas/process.c            |  5 +--
 arch/um/kernel/time.c                    |  6 ++--
 arch/um/kernel/tlb.c                     |  7 +---
 arch/um/os-Linux/drivers/ethertap_kern.c |  2 +-
 arch/um/os-Linux/drivers/tuntap_kern.c   |  2 +-
 arch/um/os-Linux/signal.c                |  4 +--
 arch/x86/um/bugs_32.c                    |  1 +
 arch/x86/um/bugs_64.c                    |  1 +
 arch/x86/um/elfcore.c                    |  1 +
 arch/x86/um/fault.c                      |  1 +
 arch/x86/um/os-Linux/mcontext.c          |  1 +
 arch/x86/um/os-Linux/registers.c         |  2 +-
 arch/x86/um/os-Linux/tls.c               |  1 +
 22 files changed, 35 insertions(+), 60 deletions(-)

-- 
2.34.1


