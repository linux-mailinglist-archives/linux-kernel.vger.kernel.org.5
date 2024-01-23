Return-Path: <linux-kernel+bounces-35169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DA1838D06
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A80A828CB37
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA0D5EE6A;
	Tue, 23 Jan 2024 11:09:24 +0000 (UTC)
Received: from out0-203.mail.aliyun.com (out0-203.mail.aliyun.com [140.205.0.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDAD5D91E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706008163; cv=none; b=HlaaWpnCHEhnI9YpdgXeXTF1w9NwvSxWGhlkrcjh3UfdLsoV36O0G4vnhDflD/mzXu3khB0SmT+Or2bmEs2FEHKj/OIlc58BrbXxviSYqYAQsVpYT0EOhexid77p2Z3PfN14YEfW7CJGADnqIGqDqisiHSroUig4U49hKGWtS+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706008163; c=relaxed/simple;
	bh=Z5e940A58gW1sYAm3DdoIAB32t7YxtpAzeJ2S0iFi+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=l/JG0N4Aa9/vAM1XZ3MU0fem22hj3IASjgSSpBVX+yWbnlyE5mN67Mpx+n+wMDVllrXOMeYrgLRvW+ptCI+6Y/1uozFTH+5Eu3pxzB3nhAnywISv9ARBqRUsmYnwanhwbms+ZTHRfxHyhoKZi68rsM9GA0Bo9T8JjD5qEkzG94M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; arc=none smtp.client-ip=140.205.0.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047209;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.WDCKThV_1706007828;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.WDCKThV_1706007828)
          by smtp.aliyun-inc.com;
          Tue, 23 Jan 2024 19:03:55 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 0/5] um: Minor fixes and cleanups
Date: Tue, 23 Jan 2024 19:03:42 +0800
Message-Id: <20240123110347.1274217-1-tiwei.btw@antgroup.com>
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

Tiwei Bie (5):
  um: Make local functions and variables static
  um: Fix the declaration of vfree
  um: Remove unused functions
  um: Fix the return type of __switch_to
  um: Add missing headers

 arch/um/drivers/pcap_kern.c              |  4 +--
 arch/um/drivers/ubd_user.c               |  2 +-
 arch/um/include/shared/um_malloc.h       |  2 +-
 arch/um/kernel/kmsg_dump.c               |  2 +-
 arch/um/kernel/mem.c                     |  2 ++
 arch/um/kernel/process.c                 | 34 ++++++------------------
 arch/um/kernel/reboot.c                  |  1 +
 arch/um/kernel/skas/mmu.c                |  1 +
 arch/um/kernel/skas/process.c            |  1 +
 arch/um/kernel/time.c                    |  6 ++---
 arch/um/kernel/tlb.c                     |  7 +----
 arch/um/os-Linux/drivers/ethertap_kern.c |  2 +-
 arch/um/os-Linux/drivers/tuntap_kern.c   |  2 +-
 arch/um/os-Linux/signal.c                |  4 +--
 arch/x86/um/bugs_32.c                    |  1 +
 arch/x86/um/bugs_64.c                    |  1 +
 arch/x86/um/fault.c                      |  1 +
 arch/x86/um/os-Linux/mcontext.c          |  1 +
 arch/x86/um/os-Linux/registers.c         |  2 +-
 19 files changed, 31 insertions(+), 45 deletions(-)

-- 
2.34.1


