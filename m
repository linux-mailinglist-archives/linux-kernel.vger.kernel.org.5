Return-Path: <linux-kernel+bounces-155038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 073808AE4A2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1AD21F23340
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE9213D2B6;
	Tue, 23 Apr 2024 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="Dt7cB+Dl"
Received: from out0-196.mail.aliyun.com (out0-196.mail.aliyun.com [140.205.0.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEE713C9DA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872449; cv=none; b=BfiFrq7BadQiNZi1WrzHgbLaRfKmyte8IHrVtYAXXu+Y5XVrhWiIy9qrCAy7Hm0CcLthK3CVq/Pgjqq6MEYAEsuBjulrlH24L6Tjx/kJ+o5KxsEgwzp06TKshpxVLzHY6oCoMNe1jsz9O4lgEjJH7Sldb20x2oNgAChpuuByC5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872449; c=relaxed/simple;
	bh=YfsrPvivDoRKNrC1YbqFj+eCbbGzeciwc/RF0sBkVJU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=G7o3lV+CBHDiqUwttvXmx3irAH3hPb7s3u7KtALZzS+h5f1pLHm6wyHKF/Rw6igY0nSR12gdzYp2551PSMLBt7npc5tfEs5FCVjzkIECyQJDqKY78/l2j2Cv53a8vkIjLfj85/rs8LZwH+mgT/BcjvV8FViIHuBdzIq8uTDSmrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=Dt7cB+Dl; arc=none smtp.client-ip=140.205.0.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713872444; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=Puom3o0JDkiZIFarbwt9DAJoDSO5gjgxzhiu11+oa54=;
	b=Dt7cB+Dlv+gDGuvCSI0krKXzPBBUjh/wdHxVuCtXuZzSKlIwwPeYG4k0OLL4c6+P2BRRnBjLp5K4yMgMfNftbfCCGQI7juDq52KfcDmi9Jvef//gOHbFBNKM7zL/0cOafDcuyBtuIFOXg8Fc6H7vQAdSQ8h8Pg9jcU46PW9Q1T0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047192;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.XJTUYfJ_1713871506;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XJTUYfJ_1713871506)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 19:25:12 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 0/7] um: A follow-up series of -Wmissing-prototypes fixes
Date: Tue, 23 Apr 2024 19:24:50 +0800
Message-Id: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a follow-up series built on top of below series:
https://lore.kernel.org/linux-um/20240306101925.1088870-1-tiwei.btw@antgroup.com/

Tiwei Bie (7):
  um: Fix -Wmissing-prototypes warnings for (rt_)sigreturn
  um: Fix the -Wmissing-prototypes warning for __switch_mm
  um: Fix the -Wmissing-prototypes warning for get_thread_reg
  um: Fix the declaration of kasan_map_memory
  um: Add an internal header shared among the user code
  um: Fix -Wmissing-prototypes warnings for __vdso_*
  um: Remove unused do_get_thread_area function

 arch/um/include/asm/kasan.h             |  1 -
 arch/um/include/asm/mmu.h               |  2 --
 arch/um/include/asm/processor-generic.h |  1 -
 arch/um/include/shared/kern_util.h      |  2 ++
 arch/um/include/shared/skas/mm_id.h     |  2 ++
 arch/um/os-Linux/internal.h             | 20 ++++++++++++++++++++
 arch/um/os-Linux/main.c                 |  2 --
 arch/um/os-Linux/mem.c                  |  1 +
 arch/um/os-Linux/skas/mem.c             |  2 --
 arch/um/os-Linux/start_up.c             |  2 --
 arch/um/scripts/Makefile.rules          |  3 ++-
 arch/x86/um/shared/sysdep/archsetjmp.h  |  7 +++++++
 arch/x86/um/signal.c                    |  5 +++--
 arch/x86/um/tls_32.c                    | 17 -----------------
 arch/x86/um/vdso/um_vdso.c              | 10 ++++++++--
 15 files changed, 45 insertions(+), 32 deletions(-)
 create mode 100644 arch/um/os-Linux/internal.h

-- 
2.34.1


