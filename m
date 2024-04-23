Return-Path: <linux-kernel+bounces-155232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DB98AE730
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73DCE288DDC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A31130A6C;
	Tue, 23 Apr 2024 12:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="yoEHMuTN"
Received: from out0-219.mail.aliyun.com (out0-219.mail.aliyun.com [140.205.0.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E550386AC2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877153; cv=none; b=G4DFBXIghB7WrlOsE/Kkdw68OefyT0sLQ5pV0Sf3nz7PrkW/1BYzedxkezgVtlBVKHQGDtxLYaOQX2rTyCXz75mfiD3XdIgdNGOcSc9botzJukZFvaJwsup/jgQblX/RxPMlUmm5ZL2EG4VuInfEFfAzTlIh4VEyBhzsfrIrIDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877153; c=relaxed/simple;
	bh=Y37GtktunSaQ5M+3akdpzPsQR1Cyv0+zKrMHQcCYULQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KhwpuuhIlk2fVMeggePZeOX22sePjTtBtwO0NtsaGRvCO3/fj9r3k+RBifqLT/2Xy/11FcbRGpkQEnRj6O2YY5vfz0UVCzdrmDZXjIQjWWgOL17UIy4x+6Qn0+SOVx7Z/LpCgeT2LdCiLkVQclDTw04puBu4IlIoYGTp76V+Jyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=yoEHMuTN; arc=none smtp.client-ip=140.205.0.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713877147; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=UMByg3cjk4dNIWG+7FR1ywCtH7rpQe+uxSkEqin1HfU=;
	b=yoEHMuTN/8/8czn2o3LMhH2HZokkrupkB+STpS51OTaNIikZLdcA2kH6AC+eTcbZ2Qim37wiJABaEUN9KBTOOTAchBkN/muXsmI+C1ReQv+6kjPjIbkte+iXybSC4rqoRsf3tp0lu53d3I9AHblFeHsqkIEC0AVCNu6ZUXT3GIg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047212;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.XJXNjPz_1713877140;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XJXNjPz_1713877140)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 20:59:06 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 0/7] um: A follow-up series of -Wmissing-prototypes fixes
Date: Tue, 23 Apr 2024 20:58:51 +0800
Message-Id: <20240423125858.137709-1-tiwei.btw@antgroup.com>
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

Changes since v1:
https://lore.kernel.org/linux-um/20240423112457.2409319-1-tiwei.btw@antgroup.com/
- include "internal.h" explicitly (Johannes);
- drop the "extern" (Johannes);

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
 arch/um/os-Linux/elf_aux.c              |  1 +
 arch/um/os-Linux/internal.h             | 20 ++++++++++++++++++++
 arch/um/os-Linux/main.c                 |  3 +--
 arch/um/os-Linux/mem.c                  |  2 ++
 arch/um/os-Linux/skas/mem.c             |  3 +--
 arch/um/os-Linux/skas/process.c         |  1 +
 arch/um/os-Linux/start_up.c             |  3 +--
 arch/x86/um/shared/sysdep/archsetjmp.h  |  7 +++++++
 arch/x86/um/signal.c                    |  5 +++--
 arch/x86/um/tls_32.c                    | 17 -----------------
 arch/x86/um/vdso/um_vdso.c              | 10 ++++++++--
 16 files changed, 49 insertions(+), 31 deletions(-)
 create mode 100644 arch/um/os-Linux/internal.h

-- 
2.34.1


