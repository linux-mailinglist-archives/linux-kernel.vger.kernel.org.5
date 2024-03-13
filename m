Return-Path: <linux-kernel+bounces-101256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC0387A49E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9871C20306
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100081B95C;
	Wed, 13 Mar 2024 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b="i8YBiMSS";
	dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b="Hef1er5h"
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1240C1CD14
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320753; cv=none; b=j8trc18AKS6NMuxaZvQ0XHLeorfagkYPNn1inwCVCaRqz4BHPLwMapzLWoXfAFTx6zA0rjIcVzHtgQsSreSV1ANXSl7qL0QLV/nzUoA77+on0vxXFNNWWT7wLaUwi9YOyHajP1R4Z3QvekPTWc6p3bhk/BSMkQg5nWOCKXBS4ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320753; c=relaxed/simple;
	bh=oYO5G2kgoI0v/4fOm9QTTExYPwIT6pOuW8fRLgogous=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H8PD/pISilukfduS4i1CGFC1tkIqYtyn+9ObCU7AnqEVlYxnFJP6UGtf7PUc4q/eJD5FB2JIzcmmsyzOG118+n28ngbDIuTd/K8NJQ+yCsVBfM/ub/MUIF433/nWUduhHkKPYdlsA2oR0ajieYDbirSLyUjPH2cA2UjPezYGjFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=syntacore.com; spf=fail smtp.mailfrom=syntacore.com; dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b=i8YBiMSS; dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b=Hef1er5h; arc=none smtp.client-ip=89.207.88.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=syntacore.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=syntacore.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 83FCFC0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
	s=mta-04; t=1710320742;
	bh=hzex8GVy1A6DhuERVgut3DhHXnR8ynA/aRj+HZfrGmI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=i8YBiMSSWB1gKyBsNgx996JhaURZDLnrGhmAj+E0n1uG9gB2BKDYVRvY8lw5iP9ad
	 0NEiMLcZUS5bbZqMcXgNrzHoJfxSSMzWtKR4LYNx+enblE/wgFBjgHgJc+aYmmgWrk
	 0MKAAeHuJKZdfQsb17U76NtGelm+ydqAb4AbJyJyMF8Lq1fxMfMAL8w19gO6SJShrj
	 OgYuwiEjc3yqETaQJIdlT6Ec7ol7b+JsA7MOVWm/3Wl8nrz/eqQlEFYlkCfEH6IUSd
	 wSEUQoHrEVMO5hLl4/Dt/fxZrr+DpMnFauQz870aAT7aXt/y9STWuyvePSSjtmyi+R
	 21PTIwnrOSBjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
	s=mta-03; t=1710320742;
	bh=hzex8GVy1A6DhuERVgut3DhHXnR8ynA/aRj+HZfrGmI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Hef1er5h30zUfWFAow6aUvTmO9ZGDnXJ3MG7GtFkpLGLAjGbz+p1HSHBkokeZRRdD
	 K4QfOxNQTXtsLhRfc2NbWPVL1RAo4pw260p+nmJx50N0PJAmHNYgi/EuDgUkXvWc3m
	 jhgzOGAlZmfUvrrcVkGngCCv8X7o84THxeiQPenJ982Ab0rYn6nLanxhLGR15CCxwE
	 PdNwaC7VMVH8uCjEMwYrxhrOcBPEMo8hUn7s+RTHRMnXzIgMCw8zKlrrVIphZU1PdO
	 p7jn91p8MJSygbgUOt/Yh8daWQQtpBvIo8nxE+24DPi4puDSdC+yyhH2+gr2KzmYcx
	 D/QSEUi+/gvZg==
From: Vladimir Isaev <vladimir.isaev@syntacore.com>
To: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<catalin.marinas@arm.com>, <evan@rivosinc.com>, <nicolas@fjasle.eu>,
	<tglx@linutronix.de>, <samitolvanen@google.com>, <masahiroy@kernel.org>,
	<maskray@google.com>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <guoren@kernel.org>
CC: Vladimir Isaev <vladimir.isaev@syntacore.com>, Roman Artemev
	<roman.artemev@syntacore.com>
Subject: [PATCH] riscv: hwprobe: do not produce frtace relocation
Date: Wed, 13 Mar 2024 10:35:46 +0300
Message-ID: <20240313085843.17661-1-vladimir.isaev@syntacore.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-06.corp.yadro.com (172.17.10.110) To
 S-Exch-01.corp.yadro.com (10.78.5.241)

Such relocation causes crash of android linker similar to one
described in commit e05d57dcb8c7
("riscv: Fixup __vdso_gettimeofday broke dynamic ftrace").

Looks like this relocation is added by CONFIG_DYNAMIC_FTRACE which is
disabled in the default android kernel.

Before:

readelf -rW arch/riscv/kernel/vdso/vdso.so:

Relocation section '.rela.dyn' at offset 0xd00 contains 1 entry:
    Offset             Info             Type
0000000000000d20  0000000000000003 R_RISCV_RELATIVE

objdump:
0000000000000c86 <__vdso_riscv_hwprobe@@LINUX_4.15>:
 c86:   0001                    nop
 c88:   0001                    nop
 c8a:   0001                    nop
 c8c:   0001                    nop
 c8e:   e211                    bnez    a2,c92 <__vdso_riscv_hwprobe...

After:
readelf -rW arch/riscv/kernel/vdso/vdso.so:

There are no relocations in this file.

objdump:
0000000000000c86 <__vdso_riscv_hwprobe@@LINUX_4.15>:
 c86:   e211                    bnez    a2,c8a <__vdso_riscv_hwprobe...
 c88:   c6b9                    beqz    a3,cd6 <__vdso_riscv_hwprobe...
 c8a:   e739                    bnez    a4,cd8 <__vdso_riscv_hwprobe...
 c8c:   ffffd797                auipc   a5,0xffffd

Also disable SCS since it also should not be available in vdso.

Fixes: aa5af0aa90ba ("RISC-V: Add hwprobe vDSO function and data")
Signed-off-by: Roman Artemev <roman.artemev@syntacore.com>
Signed-off-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
---
 arch/riscv/kernel/vdso/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 9b517fe1b8a8..272c431ac5b9 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -37,6 +37,7 @@ endif
 
 # Disable -pg to prevent insert call site
 CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
+CFLAGS_REMOVE_hwprobe.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
 
 # Disable profiling and instrumentation for VDSO code
 GCOV_PROFILE := n
-- 
2.43.0


