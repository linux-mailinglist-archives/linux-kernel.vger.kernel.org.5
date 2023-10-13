Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185907C8228
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjJMJiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjJMJiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:38:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0A2B7;
        Fri, 13 Oct 2023 02:38:04 -0700 (PDT)
Date:   Fri, 13 Oct 2023 09:38:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697189883;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U2BAOWoNEDTVIWwE7C+fvkNZ7nxqswUT9TQVN6SmJak=;
        b=A0dJ6jX1wy7xxolGmNlIRgIHdlIEZjuztrSoym46x8RcWopQwR/lZKo5PN0raQThn2W5rJ
        ibGNC0jxxs1kbMTQvTOoyK3GRy3uU8G48oR4fynb9YXTeg9lxBxDJ+IjiYLM8r14gF6vGU
        aeV2H4noUaXHNfkWgOjmCh9myteQ95RfAcq4bQgpXvpxMxccWmEPze1ANM9h0yuFhuE/s1
        KetpR4l+MZ76Fx6wQ0jAjCusOmK08w6Aj3UGzCfLCiZOAK4PWN4kO0Ab0Jdju89z8dIxPM
        S/yLuHQXPhvxY7OX2g1O/qsApfhmTj/jZsfBiVEFR0upKsVwTXkyLkgW2490xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697189883;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U2BAOWoNEDTVIWwE7C+fvkNZ7nxqswUT9TQVN6SmJak=;
        b=xlcmw/R4C5DImpgd2nTach9Q6U8BglrfCDE9+J7l20T0VPX3MmnT7ioWc9iAACgZYomhs7
        QpKBbhN6a6mTbNCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpu: Provide debug interface
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230814085113.353191313@linutronix.de>
References: <20230814085113.353191313@linutronix.de>
MIME-Version: 1.0
Message-ID: <169718988245.3135.226367801293113279.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     48525fd1ea1cfa059a580e77b10ea8790914efa2
Gitweb:        https://git.kernel.org/tip/48525fd1ea1cfa059a580e77b10ea8790914efa2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Aug 2023 10:18:47 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Oct 2023 14:38:19 +02:00

x86/cpu: Provide debug interface

Provide debug files which dump the topology related information of
cpuinfo_x86. This is useful to validate the upcoming conversion of the
topology evaluation for correctness or bug compatibility.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230814085113.353191313@linutronix.de

---
 arch/x86/kernel/cpu/Makefile  |  2 +-
 arch/x86/kernel/cpu/debugfs.c | 58 ++++++++++++++++++++++++++++++++++-
 2 files changed, 60 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/debugfs.c

diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 4350f6b..93eabf5 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -54,6 +54,8 @@ obj-$(CONFIG_X86_LOCAL_APIC)		+= perfctr-watchdog.o
 obj-$(CONFIG_HYPERVISOR_GUEST)		+= vmware.o hypervisor.o mshyperv.o
 obj-$(CONFIG_ACRN_GUEST)		+= acrn.o
 
+obj-$(CONFIG_DEBUG_FS)			+= debugfs.o
+
 quiet_cmd_mkcapflags = MKCAP   $@
       cmd_mkcapflags = $(CONFIG_SHELL) $(srctree)/$(src)/mkcapflags.sh $@ $^
 
diff --git a/arch/x86/kernel/cpu/debugfs.c b/arch/x86/kernel/cpu/debugfs.c
new file mode 100644
index 0000000..0c179d6
--- /dev/null
+++ b/arch/x86/kernel/cpu/debugfs.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/debugfs.h>
+
+#include <asm/apic.h>
+#include <asm/processor.h>
+
+static int cpu_debug_show(struct seq_file *m, void *p)
+{
+	unsigned long cpu = (unsigned long)m->private;
+	struct cpuinfo_x86 *c = per_cpu_ptr(&cpu_info, cpu);
+
+	seq_printf(m, "online:              %d\n", cpu_online(cpu));
+	if (!c->initialized)
+		return 0;
+
+	seq_printf(m, "initial_apicid:      %x\n", c->topo.initial_apicid);
+	seq_printf(m, "apicid:              %x\n", c->topo.apicid);
+	seq_printf(m, "pkg_id:              %u\n", c->topo.pkg_id);
+	seq_printf(m, "die_id:              %u\n", c->topo.die_id);
+	seq_printf(m, "cu_id:               %u\n", c->topo.cu_id);
+	seq_printf(m, "core_id:             %u\n", c->topo.core_id);
+	seq_printf(m, "logical_pkg_id:      %u\n", c->topo.logical_pkg_id);
+	seq_printf(m, "logical_die_id:      %u\n", c->topo.logical_die_id);
+	seq_printf(m, "llc_id:              %u\n", c->topo.llc_id);
+	seq_printf(m, "l2c_id:              %u\n", c->topo.l2c_id);
+	seq_printf(m, "max_cores:           %u\n", c->x86_max_cores);
+	seq_printf(m, "max_die_per_pkg:     %u\n", __max_die_per_package);
+	seq_printf(m, "smp_num_siblings:    %u\n", smp_num_siblings);
+	return 0;
+}
+
+static int cpu_debug_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, cpu_debug_show, inode->i_private);
+}
+
+static const struct file_operations dfs_cpu_ops = {
+	.open		= cpu_debug_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static __init int cpu_init_debugfs(void)
+{
+	struct dentry *dir, *base = debugfs_create_dir("topo", arch_debugfs_dir);
+	unsigned long id;
+	char name[24];
+
+	dir = debugfs_create_dir("cpus", base);
+	for_each_possible_cpu(id) {
+		sprintf(name, "%lu", id);
+		debugfs_create_file(name, 0444, dir, (void *)id, &dfs_cpu_ops);
+	}
+	return 0;
+}
+late_initcall(cpu_init_debugfs);
