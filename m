Return-Path: <linux-kernel+bounces-31770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEC68333C5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 12:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91FF8B223B2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 11:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A52EAF6;
	Sat, 20 Jan 2024 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eytsFL8J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C013D2FE;
	Sat, 20 Jan 2024 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705749054; cv=none; b=e1qUFpF6nGzqMkYjkdCulYTGcXAF830INBguBVIHvJYG+IrXlzC/Yh+QxdWP4era1t+VChJA1ouTUXR2FG4aH54sDmB6aom7Jz9ziFj/ZOCLtKNU75h6DkA4IVCxr/dj2tPq4C+L12F6Ers9ETd+aQVC8f+txehc1nCIqyrm6hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705749054; c=relaxed/simple;
	bh=sxNWtz6Rvd5pBr1pPFropMpmtxca26OnHyNminYaecQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LwZmxt7Jsy46eFWLoOa2pyZNTP05uIQUV722+BuhRkqfjwpcvd0PfniiKDWOPqnK2/bgS4OKBWIgWf46l2G6Y77u98ycC9h8NyPDB3qpivVO/1c7keeXcdQyBDJNINfBYU17HBeH03jcBWy3QiHalmTcs1feEAxCRLUbioSIV0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eytsFL8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C1FC433C7;
	Sat, 20 Jan 2024 11:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705749054;
	bh=sxNWtz6Rvd5pBr1pPFropMpmtxca26OnHyNminYaecQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eytsFL8JL47yQn54Gwc2H1babeDM1Nst5/7QZLlcqjZYMJrrD2DdLGF0PCnB0FS8N
	 T5oPc7E4vXCmP11Yy3eNo65luMN/Iw/TJcCQn74LuApdFbhMwSotCELOYaQ4ANmrv8
	 cM/1ayppu2D5Q6ozKlMiSf+QREjES4AYvDJ2Gj48=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.7.1
Date: Sat, 20 Jan 2024 12:10:44 +0100
Message-ID: <2024012043-pleat-underline-64a6@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024012043-celery-quickly-3928@gregkh>
References: <2024012043-celery-quickly-3928@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/admin-guide/features.rst b/Documentation/admin-guide/features.rst
index 8c167082a84f..7651eca38227 100644
--- a/Documentation/admin-guide/features.rst
+++ b/Documentation/admin-guide/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features
+.. kernel-feat:: features
diff --git a/Documentation/arch/arc/features.rst b/Documentation/arch/arc/features.rst
index b793583d688a..49ff446ff744 100644
--- a/Documentation/arch/arc/features.rst
+++ b/Documentation/arch/arc/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features arc
+.. kernel-feat:: features arc
diff --git a/Documentation/arch/arm/features.rst b/Documentation/arch/arm/features.rst
index 7414ec03dd15..0e76aaf68eca 100644
--- a/Documentation/arch/arm/features.rst
+++ b/Documentation/arch/arm/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features arm
+.. kernel-feat:: features arm
diff --git a/Documentation/arch/arm64/features.rst b/Documentation/arch/arm64/features.rst
index dfa4cb3cd3ef..03321f4309d0 100644
--- a/Documentation/arch/arm64/features.rst
+++ b/Documentation/arch/arm64/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features arm64
+.. kernel-feat:: features arm64
diff --git a/Documentation/arch/loongarch/features.rst b/Documentation/arch/loongarch/features.rst
index ebacade3ea45..009f44c7951f 100644
--- a/Documentation/arch/loongarch/features.rst
+++ b/Documentation/arch/loongarch/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features loongarch
+.. kernel-feat:: features loongarch
diff --git a/Documentation/arch/m68k/features.rst b/Documentation/arch/m68k/features.rst
index 5107a2119472..de7f0ccf7fc8 100644
--- a/Documentation/arch/m68k/features.rst
+++ b/Documentation/arch/m68k/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features m68k
+.. kernel-feat:: features m68k
diff --git a/Documentation/arch/mips/features.rst b/Documentation/arch/mips/features.rst
index 1973d729b29a..6e0ffe3e7354 100644
--- a/Documentation/arch/mips/features.rst
+++ b/Documentation/arch/mips/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features mips
+.. kernel-feat:: features mips
diff --git a/Documentation/arch/nios2/features.rst b/Documentation/arch/nios2/features.rst
index 8449e63f69b2..89913810ccb5 100644
--- a/Documentation/arch/nios2/features.rst
+++ b/Documentation/arch/nios2/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features nios2
+.. kernel-feat:: features nios2
diff --git a/Documentation/arch/openrisc/features.rst b/Documentation/arch/openrisc/features.rst
index 3f7c40d219f2..bae2e25adfd6 100644
--- a/Documentation/arch/openrisc/features.rst
+++ b/Documentation/arch/openrisc/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features openrisc
+.. kernel-feat:: features openrisc
diff --git a/Documentation/arch/parisc/features.rst b/Documentation/arch/parisc/features.rst
index 501d7c450037..b3aa4d243b93 100644
--- a/Documentation/arch/parisc/features.rst
+++ b/Documentation/arch/parisc/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features parisc
+.. kernel-feat:: features parisc
diff --git a/Documentation/arch/powerpc/features.rst b/Documentation/arch/powerpc/features.rst
index aeae73df86b0..ee4b95e04202 100644
--- a/Documentation/arch/powerpc/features.rst
+++ b/Documentation/arch/powerpc/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features powerpc
+.. kernel-feat:: features powerpc
diff --git a/Documentation/arch/riscv/features.rst b/Documentation/arch/riscv/features.rst
index c70ef6ac2368..36e90144adab 100644
--- a/Documentation/arch/riscv/features.rst
+++ b/Documentation/arch/riscv/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features riscv
+.. kernel-feat:: features riscv
diff --git a/Documentation/arch/s390/features.rst b/Documentation/arch/s390/features.rst
index 57c296a9d8f3..2883dc950681 100644
--- a/Documentation/arch/s390/features.rst
+++ b/Documentation/arch/s390/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features s390
+.. kernel-feat:: features s390
diff --git a/Documentation/arch/sh/features.rst b/Documentation/arch/sh/features.rst
index f722af3b6c99..fae48fe81e9b 100644
--- a/Documentation/arch/sh/features.rst
+++ b/Documentation/arch/sh/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features sh
+.. kernel-feat:: features sh
diff --git a/Documentation/arch/sparc/features.rst b/Documentation/arch/sparc/features.rst
index c0c92468b0fe..96835b6d598a 100644
--- a/Documentation/arch/sparc/features.rst
+++ b/Documentation/arch/sparc/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features sparc
+.. kernel-feat:: features sparc
diff --git a/Documentation/arch/x86/features.rst b/Documentation/arch/x86/features.rst
index b663f15053ce..a33616346a38 100644
--- a/Documentation/arch/x86/features.rst
+++ b/Documentation/arch/x86/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features x86
+.. kernel-feat:: features x86
diff --git a/Documentation/arch/xtensa/features.rst b/Documentation/arch/xtensa/features.rst
index 6b92c7bfa19d..28dcce1759be 100644
--- a/Documentation/arch/xtensa/features.rst
+++ b/Documentation/arch/xtensa/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features xtensa
+.. kernel-feat:: features xtensa
diff --git a/Documentation/sphinx/kernel_feat.py b/Documentation/sphinx/kernel_feat.py
index b5fa2f0542a5..b9df61eb4501 100644
--- a/Documentation/sphinx/kernel_feat.py
+++ b/Documentation/sphinx/kernel_feat.py
@@ -37,8 +37,6 @@ import re
 import subprocess
 import sys
 
-from os import path
-
 from docutils import nodes, statemachine
 from docutils.statemachine import ViewList
 from docutils.parsers.rst import directives, Directive
@@ -76,33 +74,26 @@ class KernelFeat(Directive):
         self.state.document.settings.env.app.warn(message, prefix="")
 
     def run(self):
-
         doc = self.state.document
         if not doc.settings.file_insertion_enabled:
             raise self.warning("docutils: file insertion disabled")
 
         env = doc.settings.env
-        cwd = path.dirname(doc.current_source)
-        cmd = "get_feat.pl rest --enable-fname --dir "
-        cmd += self.arguments[0]
-
-        if len(self.arguments) > 1:
-            cmd += " --arch " + self.arguments[1]
 
-        srctree = path.abspath(os.environ["srctree"])
+        srctree = os.path.abspath(os.environ["srctree"])
 
-        fname = cmd
+        args = [
+            os.path.join(srctree, 'scripts/get_feat.pl'),
+            'rest',
+            '--enable-fname',
+            '--dir',
+            os.path.join(srctree, 'Documentation', self.arguments[0]),
+        ]
 
-        # extend PATH with $(srctree)/scripts
-        path_env = os.pathsep.join([
-            srctree + os.sep + "scripts",
-            os.environ["PATH"]
-        ])
-        shell_env = os.environ.copy()
-        shell_env["PATH"]    = path_env
-        shell_env["srctree"] = srctree
+        if len(self.arguments) > 1:
+            args.extend(['--arch', self.arguments[1]])
 
-        lines = self.runCmd(cmd, shell=True, cwd=cwd, env=shell_env)
+        lines = subprocess.check_output(args, cwd=os.path.dirname(doc.current_source)).decode('utf-8')
 
         line_regex = re.compile(r"^\.\. FILE (\S+)$")
 
@@ -121,30 +112,6 @@ class KernelFeat(Directive):
         nodeList = self.nestedParse(out_lines, fname)
         return nodeList
 
-    def runCmd(self, cmd, **kwargs):
-        u"""Run command ``cmd`` and return its stdout as unicode."""
-
-        try:
-            proc = subprocess.Popen(
-                cmd
-                , stdout = subprocess.PIPE
-                , stderr = subprocess.PIPE
-                , **kwargs
-            )
-            out, err = proc.communicate()
-
-            out, err = codecs.decode(out, 'utf-8'), codecs.decode(err, 'utf-8')
-
-            if proc.returncode != 0:
-                raise self.severe(
-                    u"command '%s' failed with return code %d"
-                    % (cmd, proc.returncode)
-                )
-        except OSError as exc:
-            raise self.severe(u"problems with '%s' directive: %s."
-                              % (self.name, ErrorString(exc)))
-        return out
-
     def nestedParse(self, lines, fname):
         content = ViewList()
         node    = nodes.section()
diff --git a/Documentation/translations/zh_CN/arch/loongarch/features.rst b/Documentation/translations/zh_CN/arch/loongarch/features.rst
index 82bfac180bdc..cec38dda8298 100644
--- a/Documentation/translations/zh_CN/arch/loongarch/features.rst
+++ b/Documentation/translations/zh_CN/arch/loongarch/features.rst
@@ -5,4 +5,4 @@
 :Original: Documentation/arch/loongarch/features.rst
 :Translator: Huacai Chen <chenhuacai@loongson.cn>
 
-.. kernel-feat:: $srctree/Documentation/features loongarch
+.. kernel-feat:: features loongarch
diff --git a/Documentation/translations/zh_CN/arch/mips/features.rst b/Documentation/translations/zh_CN/arch/mips/features.rst
index da1b956e4a40..0d6df97db069 100644
--- a/Documentation/translations/zh_CN/arch/mips/features.rst
+++ b/Documentation/translations/zh_CN/arch/mips/features.rst
@@ -10,4 +10,4 @@
 
 .. _cn_features:
 
-.. kernel-feat:: $srctree/Documentation/features mips
+.. kernel-feat:: features mips
diff --git a/Documentation/translations/zh_TW/arch/loongarch/features.rst b/Documentation/translations/zh_TW/arch/loongarch/features.rst
index b64e430f55ae..c2175fd32b54 100644
--- a/Documentation/translations/zh_TW/arch/loongarch/features.rst
+++ b/Documentation/translations/zh_TW/arch/loongarch/features.rst
@@ -5,5 +5,5 @@
 :Original: Documentation/arch/loongarch/features.rst
 :Translator: Huacai Chen <chenhuacai@loongson.cn>
 
-.. kernel-feat:: $srctree/Documentation/features loongarch
+.. kernel-feat:: features loongarch
 
diff --git a/Documentation/translations/zh_TW/arch/mips/features.rst b/Documentation/translations/zh_TW/arch/mips/features.rst
index f69410420035..3d3906c4d08e 100644
--- a/Documentation/translations/zh_TW/arch/mips/features.rst
+++ b/Documentation/translations/zh_TW/arch/mips/features.rst
@@ -10,5 +10,5 @@
 
 .. _tw_features:
 
-.. kernel-feat:: $srctree/Documentation/features mips
+.. kernel-feat:: features mips
 
diff --git a/Makefile b/Makefile
index c6f549f6a4ae..186da2386a06 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 7
-SUBLEVEL = 0
+SUBLEVEL = 1
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 9bd9f79cd409..c3536c236be9 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -510,6 +510,13 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GMxXGxx"),
 		},
 	},
+	{
+		/* TongFang GMxXGxx sold as Eluktronics Inc. RP-15 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Eluktronics Inc."),
+			DMI_MATCH(DMI_BOARD_NAME, "RP-15"),
+		},
+	},
 	{
 		/* TongFang GM6XGxX/TUXEDO Stellaris 16 Gen5 AMD */
 		.matches = {
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 92128aae2d06..71a40a4c546f 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5030,7 +5030,7 @@ static __poll_t binder_poll(struct file *filp,
 
 	thread = binder_get_thread(proc);
 	if (!thread)
-		return POLLERR;
+		return EPOLLERR;
 
 	binder_inner_proc_lock(thread->proc);
 	thread->looper |= BINDER_LOOPER_STATE_POLL;
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 138f6d43d13b..e5fa2042585a 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -557,7 +557,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
  * is the sum of the three given sizes (each rounded up to
  * pointer-sized boundary)
  *
- * Return:	The allocated buffer or %NULL if error
+ * Return:	The allocated buffer or %ERR_PTR(-errno) if error
  */
 struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 					   size_t data_size,
@@ -706,7 +706,7 @@ void binder_alloc_free_buf(struct binder_alloc *alloc,
 	/*
 	 * We could eliminate the call to binder_alloc_clear_buf()
 	 * from binder_alloc_deferred_release() by moving this to
-	 * binder_alloc_free_buf_locked(). However, that could
+	 * binder_free_buf_locked(). However, that could
 	 * increase contention for the alloc mutex if clear_on_free
 	 * is used frequently for large buffers. The mutex is not
 	 * needed for correctness here.
@@ -1005,7 +1005,9 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 		goto err_mmget;
 	if (!mmap_read_trylock(mm))
 		goto err_mmap_read_lock_failed;
-	vma = binder_alloc_get_vma(alloc);
+	vma = vma_lookup(mm, page_addr);
+	if (vma && vma != binder_alloc_get_vma(alloc))
+		goto err_invalid_vma;
 
 	list_lru_isolate(lru, item);
 	spin_unlock(lock);
@@ -1031,6 +1033,8 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	mutex_unlock(&alloc->mutex);
 	return LRU_REMOVED_RETRY;
 
+err_invalid_vma:
+	mmap_read_unlock(mm);
 err_mmap_read_lock_failed:
 	mmput_async(mm);
 err_mmget:
diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
index 5eb0fe73ddc4..e384fbc6c1d9 100644
--- a/drivers/bus/moxtet.c
+++ b/drivers/bus/moxtet.c
@@ -755,7 +755,7 @@ static int moxtet_irq_setup(struct moxtet *moxtet)
 	moxtet->irq.masked = ~0;
 
 	ret = request_threaded_irq(moxtet->dev_irq, NULL, moxtet_irq_thread_fn,
-				   IRQF_ONESHOT, "moxtet", moxtet);
+				   IRQF_SHARED | IRQF_ONESHOT, "moxtet", moxtet);
 	if (ret < 0)
 		goto err_free;
 
@@ -830,6 +830,12 @@ static void moxtet_remove(struct spi_device *spi)
 	mutex_destroy(&moxtet->lock);
 }
 
+static const struct spi_device_id moxtet_spi_ids[] = {
+	{ "moxtet" },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, moxtet_spi_ids);
+
 static const struct of_device_id moxtet_dt_ids[] = {
 	{ .compatible = "cznic,moxtet" },
 	{},
@@ -841,6 +847,7 @@ static struct spi_driver moxtet_spi_driver = {
 		.name		= "moxtet",
 		.of_match_table = moxtet_dt_ids,
 	},
+	.id_table	= moxtet_spi_ids,
 	.probe		= moxtet_probe,
 	.remove		= moxtet_remove,
 };
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 2d1f5efa9091..b5b29451d2db 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1698,7 +1698,7 @@ static enum bp_result bios_parser_enable_disp_power_gating(
 static enum bp_result bios_parser_enable_lvtma_control(
 	struct dc_bios *dcb,
 	uint8_t uc_pwr_on,
-	uint8_t panel_instance,
+	uint8_t pwrseq_instance,
 	uint8_t bypass_panel_control_wait)
 {
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
@@ -1706,7 +1706,7 @@ static enum bp_result bios_parser_enable_lvtma_control(
 	if (!bp->cmd_tbl.enable_lvtma_control)
 		return BP_RESULT_FAILURE;
 
-	return bp->cmd_tbl.enable_lvtma_control(bp, uc_pwr_on, panel_instance, bypass_panel_control_wait);
+	return bp->cmd_tbl.enable_lvtma_control(bp, uc_pwr_on, pwrseq_instance, bypass_panel_control_wait);
 }
 
 static bool bios_parser_is_accelerated_mode(
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index 90a02d7bd3da..ab0adabf9dd4 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -976,7 +976,7 @@ static unsigned int get_smu_clock_info_v3_1(struct bios_parser *bp, uint8_t id)
 static enum bp_result enable_lvtma_control(
 	struct bios_parser *bp,
 	uint8_t uc_pwr_on,
-	uint8_t panel_instance,
+	uint8_t pwrseq_instance,
 	uint8_t bypass_panel_control_wait);
 
 static void init_enable_lvtma_control(struct bios_parser *bp)
@@ -989,7 +989,7 @@ static void init_enable_lvtma_control(struct bios_parser *bp)
 static void enable_lvtma_control_dmcub(
 	struct dc_dmub_srv *dmcub,
 	uint8_t uc_pwr_on,
-	uint8_t panel_instance,
+	uint8_t pwrseq_instance,
 	uint8_t bypass_panel_control_wait)
 {
 
@@ -1002,8 +1002,8 @@ static void enable_lvtma_control_dmcub(
 			DMUB_CMD__VBIOS_LVTMA_CONTROL;
 	cmd.lvtma_control.data.uc_pwr_action =
 			uc_pwr_on;
-	cmd.lvtma_control.data.panel_inst =
-			panel_instance;
+	cmd.lvtma_control.data.pwrseq_inst =
+			pwrseq_instance;
 	cmd.lvtma_control.data.bypass_panel_control_wait =
 			bypass_panel_control_wait;
 	dm_execute_dmub_cmd(dmcub->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
@@ -1012,7 +1012,7 @@ static void enable_lvtma_control_dmcub(
 static enum bp_result enable_lvtma_control(
 	struct bios_parser *bp,
 	uint8_t uc_pwr_on,
-	uint8_t panel_instance,
+	uint8_t pwrseq_instance,
 	uint8_t bypass_panel_control_wait)
 {
 	enum bp_result result = BP_RESULT_FAILURE;
@@ -1021,7 +1021,7 @@ static enum bp_result enable_lvtma_control(
 	    bp->base.ctx->dc->debug.dmub_command_table) {
 		enable_lvtma_control_dmcub(bp->base.ctx->dmub_srv,
 				uc_pwr_on,
-				panel_instance,
+				pwrseq_instance,
 				bypass_panel_control_wait);
 		return BP_RESULT_OK;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.h b/drivers/gpu/drm/amd/display/dc/bios/command_table2.h
index b6d09bf6cf72..41c8c014397f 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.h
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.h
@@ -96,7 +96,7 @@ struct cmd_tbl {
 			struct bios_parser *bp, uint8_t id);
 	enum bp_result (*enable_lvtma_control)(struct bios_parser *bp,
 			uint8_t uc_pwr_on,
-			uint8_t panel_instance,
+			uint8_t pwrseq_instance,
 			uint8_t bypass_panel_control_wait);
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
index be9aa1a71847..26940d94d8fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
@@ -140,7 +140,7 @@ struct dc_vbios_funcs {
 	enum bp_result (*enable_lvtma_control)(
 		struct dc_bios *bios,
 		uint8_t uc_pwr_on,
-		uint8_t panel_instance,
+		uint8_t pwrseq_instance,
 		uint8_t bypass_panel_control_wait);
 
 	enum bp_result (*get_soc_bb_info)(
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index d3e6544022b7..930fd929e93a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -145,7 +145,11 @@ static bool dmub_abm_save_restore_ex(
 	return ret;
 }
 
-static bool dmub_abm_set_pipe_ex(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst)
+static bool dmub_abm_set_pipe_ex(struct abm *abm,
+		uint32_t otg_inst,
+		uint32_t option,
+		uint32_t panel_inst,
+		uint32_t pwrseq_inst)
 {
 	bool ret = false;
 	unsigned int feature_support;
@@ -153,7 +157,7 @@ static bool dmub_abm_set_pipe_ex(struct abm *abm, uint32_t otg_inst, uint32_t op
 	feature_support = abm_feature_support(abm, panel_inst);
 
 	if (feature_support == ABM_LCD_SUPPORT)
-		ret = dmub_abm_set_pipe(abm, otg_inst, option, panel_inst);
+		ret = dmub_abm_set_pipe(abm, otg_inst, option, panel_inst, pwrseq_inst);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
index 592a8f7a1c6d..42c802afc468 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
@@ -254,7 +254,11 @@ bool dmub_abm_save_restore(
 	return true;
 }
 
-bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst)
+bool dmub_abm_set_pipe(struct abm *abm,
+		uint32_t otg_inst,
+		uint32_t option,
+		uint32_t panel_inst,
+		uint32_t pwrseq_inst)
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = abm->ctx;
@@ -264,6 +268,7 @@ bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t option, uint
 	cmd.abm_set_pipe.header.type = DMUB_CMD__ABM;
 	cmd.abm_set_pipe.header.sub_type = DMUB_CMD__ABM_SET_PIPE;
 	cmd.abm_set_pipe.abm_set_pipe_data.otg_inst = otg_inst;
+	cmd.abm_set_pipe.abm_set_pipe_data.pwrseq_inst = pwrseq_inst;
 	cmd.abm_set_pipe.abm_set_pipe_data.set_pipe_option = option;
 	cmd.abm_set_pipe.abm_set_pipe_data.panel_inst = panel_inst;
 	cmd.abm_set_pipe.abm_set_pipe_data.ramping_boundary = ramping_boundary;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h
index 853564d7f471..07ea6c8d414f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h
@@ -44,7 +44,7 @@ bool dmub_abm_save_restore(
 		struct dc_context *dc,
 		unsigned int panel_inst,
 		struct abm_save_restore *pData);
-bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst);
+bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst, uint32_t pwrseq_inst);
 bool dmub_abm_set_backlight_level(struct abm *abm,
 		unsigned int backlight_pwm_u16_16,
 		unsigned int frame_ramp,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
index 217acd4e292a..d849b1eaa4a5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
@@ -50,7 +50,7 @@ static bool dcn31_query_backlight_info(struct panel_cntl *panel_cntl, union dmub
 	cmd->panel_cntl.header.type = DMUB_CMD__PANEL_CNTL;
 	cmd->panel_cntl.header.sub_type = DMUB_CMD__PANEL_CNTL_QUERY_BACKLIGHT_INFO;
 	cmd->panel_cntl.header.payload_bytes = sizeof(cmd->panel_cntl.data);
-	cmd->panel_cntl.data.inst = dcn31_panel_cntl->base.inst;
+	cmd->panel_cntl.data.pwrseq_inst = dcn31_panel_cntl->base.pwrseq_inst;
 
 	return dm_execute_dmub_cmd(dc_dmub_srv->ctx, cmd, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY);
 }
@@ -78,7 +78,7 @@ static uint32_t dcn31_panel_cntl_hw_init(struct panel_cntl *panel_cntl)
 	cmd.panel_cntl.header.type = DMUB_CMD__PANEL_CNTL;
 	cmd.panel_cntl.header.sub_type = DMUB_CMD__PANEL_CNTL_HW_INIT;
 	cmd.panel_cntl.header.payload_bytes = sizeof(cmd.panel_cntl.data);
-	cmd.panel_cntl.data.inst = dcn31_panel_cntl->base.inst;
+	cmd.panel_cntl.data.pwrseq_inst = dcn31_panel_cntl->base.pwrseq_inst;
 	cmd.panel_cntl.data.bl_pwm_cntl = panel_cntl->stored_backlight_registers.BL_PWM_CNTL;
 	cmd.panel_cntl.data.bl_pwm_period_cntl = panel_cntl->stored_backlight_registers.BL_PWM_PERIOD_CNTL;
 	cmd.panel_cntl.data.bl_pwm_ref_div1 =
@@ -157,4 +157,5 @@ void dcn31_panel_cntl_construct(
 	dcn31_panel_cntl->base.funcs = &dcn31_link_panel_cntl_funcs;
 	dcn31_panel_cntl->base.ctx = init_data->ctx;
 	dcn31_panel_cntl->base.inst = init_data->inst;
+	dcn31_panel_cntl->base.pwrseq_inst = init_data->pwrseq_inst;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 960a55e06375..9b8299d97e40 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -790,7 +790,7 @@ void dce110_edp_power_control(
 	struct dc_context *ctx = link->ctx;
 	struct bp_transmitter_control cntl = { 0 };
 	enum bp_result bp_result;
-	uint8_t panel_instance;
+	uint8_t pwrseq_instance;
 
 
 	if (dal_graphics_object_id_get_connector_id(link->link_enc->connector)
@@ -873,7 +873,7 @@ void dce110_edp_power_control(
 		cntl.coherent = false;
 		cntl.lanes_number = LANE_COUNT_FOUR;
 		cntl.hpd_sel = link->link_enc->hpd_source;
-		panel_instance = link->panel_cntl->inst;
+		pwrseq_instance = link->panel_cntl->pwrseq_inst;
 
 		if (ctx->dc->ctx->dmub_srv &&
 				ctx->dc->debug.dmub_command_table) {
@@ -881,11 +881,11 @@ void dce110_edp_power_control(
 			if (cntl.action == TRANSMITTER_CONTROL_POWER_ON) {
 				bp_result = ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
 						LVTMA_CONTROL_POWER_ON,
-						panel_instance, link->link_powered_externally);
+						pwrseq_instance, link->link_powered_externally);
 			} else {
 				bp_result = ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
 						LVTMA_CONTROL_POWER_OFF,
-						panel_instance, link->link_powered_externally);
+						pwrseq_instance, link->link_powered_externally);
 			}
 		}
 
@@ -956,7 +956,7 @@ void dce110_edp_backlight_control(
 {
 	struct dc_context *ctx = link->ctx;
 	struct bp_transmitter_control cntl = { 0 };
-	uint8_t panel_instance;
+	uint8_t pwrseq_instance;
 	unsigned int pre_T11_delay = OLED_PRE_T11_DELAY;
 	unsigned int post_T7_delay = OLED_POST_T7_DELAY;
 
@@ -1009,7 +1009,7 @@ void dce110_edp_backlight_control(
 	 */
 	/* dc_service_sleep_in_milliseconds(50); */
 		/*edp 1.2*/
-	panel_instance = link->panel_cntl->inst;
+	pwrseq_instance = link->panel_cntl->pwrseq_inst;
 
 	if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_ON) {
 		if (!link->dc->config.edp_no_power_sequencing)
@@ -1034,11 +1034,11 @@ void dce110_edp_backlight_control(
 		if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_ON)
 			ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
 					LVTMA_CONTROL_LCD_BLON,
-					panel_instance, link->link_powered_externally);
+					pwrseq_instance, link->link_powered_externally);
 		else
 			ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
 					LVTMA_CONTROL_LCD_BLOFF,
-					panel_instance, link->link_powered_externally);
+					pwrseq_instance, link->link_powered_externally);
 	}
 
 	link_transmitter_control(ctx->dc_bios, &cntl);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index 467812cf3368..08783ad097d2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -137,7 +137,8 @@ void dcn21_PLAT_58856_wa(struct dc_state *context, struct pipe_ctx *pipe_ctx)
 	pipe_ctx->stream->dpms_off = true;
 }
 
-static bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst)
+static bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst,
+		uint32_t option, uint32_t panel_inst, uint32_t pwrseq_inst)
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = abm->ctx;
@@ -147,6 +148,7 @@ static bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t optio
 	cmd.abm_set_pipe.header.type = DMUB_CMD__ABM;
 	cmd.abm_set_pipe.header.sub_type = DMUB_CMD__ABM_SET_PIPE;
 	cmd.abm_set_pipe.abm_set_pipe_data.otg_inst = otg_inst;
+	cmd.abm_set_pipe.abm_set_pipe_data.pwrseq_inst = pwrseq_inst;
 	cmd.abm_set_pipe.abm_set_pipe_data.set_pipe_option = option;
 	cmd.abm_set_pipe.abm_set_pipe_data.panel_inst = panel_inst;
 	cmd.abm_set_pipe.abm_set_pipe_data.ramping_boundary = ramping_boundary;
@@ -179,7 +181,6 @@ void dcn21_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx)
 	struct abm *abm = pipe_ctx->stream_res.abm;
 	uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
 	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
-
 	struct dmcu *dmcu = pipe_ctx->stream->ctx->dc->res_pool->dmcu;
 
 	if (dmcu) {
@@ -190,9 +191,13 @@ void dcn21_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx)
 	if (abm && panel_cntl) {
 		if (abm->funcs && abm->funcs->set_pipe_ex) {
 			abm->funcs->set_pipe_ex(abm, otg_inst, SET_ABM_PIPE_IMMEDIATELY_DISABLE,
-			panel_cntl->inst);
+					panel_cntl->inst, panel_cntl->pwrseq_inst);
 		} else {
-			dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_IMMEDIATELY_DISABLE, panel_cntl->inst);
+				dmub_abm_set_pipe(abm,
+						otg_inst,
+						SET_ABM_PIPE_IMMEDIATELY_DISABLE,
+						panel_cntl->inst,
+						panel_cntl->pwrseq_inst);
 		}
 		panel_cntl->funcs->store_backlight_level(panel_cntl);
 	}
@@ -212,9 +217,16 @@ void dcn21_set_pipe(struct pipe_ctx *pipe_ctx)
 
 	if (abm && panel_cntl) {
 		if (abm->funcs && abm->funcs->set_pipe_ex) {
-			abm->funcs->set_pipe_ex(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+			abm->funcs->set_pipe_ex(abm,
+					otg_inst,
+					SET_ABM_PIPE_NORMAL,
+					panel_cntl->inst,
+					panel_cntl->pwrseq_inst);
 		} else {
-			dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+				dmub_abm_set_pipe(abm, otg_inst,
+						SET_ABM_PIPE_NORMAL,
+						panel_cntl->inst,
+						panel_cntl->pwrseq_inst);
 		}
 	}
 }
@@ -237,9 +249,17 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 
 		if (abm && panel_cntl) {
 			if (abm->funcs && abm->funcs->set_pipe_ex) {
-				abm->funcs->set_pipe_ex(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+				abm->funcs->set_pipe_ex(abm,
+						otg_inst,
+						SET_ABM_PIPE_NORMAL,
+						panel_cntl->inst,
+						panel_cntl->pwrseq_inst);
 			} else {
-				dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+					dmub_abm_set_pipe(abm,
+							otg_inst,
+							SET_ABM_PIPE_NORMAL,
+							panel_cntl->inst,
+							panel_cntl->pwrseq_inst);
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
index 33db15d69f23..9f521cf0fc5a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
@@ -64,7 +64,8 @@ struct abm_funcs {
 	bool (*set_pipe_ex)(struct abm *abm,
 			unsigned int otg_inst,
 			unsigned int option,
-			unsigned int panel_inst);
+			unsigned int panel_inst,
+			unsigned int pwrseq_inst);
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h b/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
index 24af9d80b937..248adc1705e3 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
@@ -56,12 +56,14 @@ struct panel_cntl_funcs {
 struct panel_cntl_init_data {
 	struct dc_context *ctx;
 	uint32_t inst;
+	uint32_t pwrseq_inst;
 };
 
 struct panel_cntl {
 	const struct panel_cntl_funcs *funcs;
 	struct dc_context *ctx;
 	uint32_t inst;
+	uint32_t pwrseq_inst;
 	/* registers setting needs to be saved and restored at InitBacklight */
 	struct panel_cntl_backlight_registers stored_backlight_registers;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 7abfc67d10a6..ff7801aa552a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -368,6 +368,30 @@ static enum transmitter translate_encoder_to_transmitter(
 	}
 }
 
+static uint8_t translate_dig_inst_to_pwrseq_inst(struct dc_link *link)
+{
+	uint8_t pwrseq_inst = 0xF;
+	struct dc_context *dc_ctx = link->dc->ctx;
+
+	DC_LOGGER_INIT(dc_ctx->logger);
+
+	switch (link->eng_id) {
+	case ENGINE_ID_DIGA:
+		pwrseq_inst = 0;
+		break;
+	case ENGINE_ID_DIGB:
+		pwrseq_inst = 1;
+		break;
+	default:
+		DC_LOG_WARNING("Unsupported pwrseq engine id: %d!\n", link->eng_id);
+		ASSERT(false);
+		break;
+	}
+
+	return pwrseq_inst;
+}
+
+
 static void link_destruct(struct dc_link *link)
 {
 	int i;
@@ -595,24 +619,6 @@ static bool construct_phy(struct dc_link *link,
 	link->ddc_hw_inst =
 		dal_ddc_get_line(get_ddc_pin(link->ddc));
 
-
-	if (link->dc->res_pool->funcs->panel_cntl_create &&
-		(link->link_id.id == CONNECTOR_ID_EDP ||
-			link->link_id.id == CONNECTOR_ID_LVDS)) {
-		panel_cntl_init_data.ctx = dc_ctx;
-		panel_cntl_init_data.inst =
-			panel_cntl_init_data.ctx->dc_edp_id_count;
-		link->panel_cntl =
-			link->dc->res_pool->funcs->panel_cntl_create(
-								&panel_cntl_init_data);
-		panel_cntl_init_data.ctx->dc_edp_id_count++;
-
-		if (link->panel_cntl == NULL) {
-			DC_ERROR("Failed to create link panel_cntl!\n");
-			goto panel_cntl_create_fail;
-		}
-	}
-
 	enc_init_data.ctx = dc_ctx;
 	bp_funcs->get_src_obj(dc_ctx->dc_bios, link->link_id, 0,
 			      &enc_init_data.encoder);
@@ -643,6 +649,23 @@ static bool construct_phy(struct dc_link *link,
 	link->dc->res_pool->dig_link_enc_count++;
 
 	link->link_enc_hw_inst = link->link_enc->transmitter;
+
+	if (link->dc->res_pool->funcs->panel_cntl_create &&
+		(link->link_id.id == CONNECTOR_ID_EDP ||
+			link->link_id.id == CONNECTOR_ID_LVDS)) {
+		panel_cntl_init_data.ctx = dc_ctx;
+		panel_cntl_init_data.inst = panel_cntl_init_data.ctx->dc_edp_id_count;
+		panel_cntl_init_data.pwrseq_inst = translate_dig_inst_to_pwrseq_inst(link);
+		link->panel_cntl =
+			link->dc->res_pool->funcs->panel_cntl_create(
+								&panel_cntl_init_data);
+		panel_cntl_init_data.ctx->dc_edp_id_count++;
+
+		if (link->panel_cntl == NULL) {
+			DC_ERROR("Failed to create link panel_cntl!\n");
+			goto panel_cntl_create_fail;
+		}
+	}
 	for (i = 0; i < 4; i++) {
 		if (bp_funcs->get_device_tag(dc_ctx->dc_bios,
 					     link->link_id, i,
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index ed4379c04715..3cea96a36432 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -3357,6 +3357,16 @@ struct dmub_cmd_abm_set_pipe_data {
 	 * TODO: Remove.
 	 */
 	uint8_t ramping_boundary;
+
+	/**
+	 * PwrSeq HW Instance.
+	 */
+	uint8_t pwrseq_inst;
+
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad[3];
 };
 
 /**
@@ -3737,7 +3747,7 @@ enum dmub_cmd_panel_cntl_type {
  * struct dmub_cmd_panel_cntl_data - Panel control data.
  */
 struct dmub_cmd_panel_cntl_data {
-	uint32_t inst; /**< panel instance */
+	uint32_t pwrseq_inst; /**< pwrseq instance */
 	uint32_t current_backlight; /* in/out */
 	uint32_t bl_pwm_cntl; /* in/out */
 	uint32_t bl_pwm_period_cntl; /* in/out */
@@ -3796,7 +3806,7 @@ struct dmub_cmd_lvtma_control_data {
 	uint8_t uc_pwr_action; /**< LVTMA_ACTION */
 	uint8_t bypass_panel_control_wait;
 	uint8_t reserved_0[2]; /**< For future use */
-	uint8_t panel_inst; /**< LVTMA control instance */
+	uint8_t pwrseq_inst; /**< LVTMA control instance */
 	uint8_t reserved_1[3]; /**< For future use */
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 20e2e4cb7614..da17b6c49b0f 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -1036,7 +1036,7 @@ struct etmv4_drvdata {
 	u8				ctxid_size;
 	u8				vmid_size;
 	u8				ccsize;
-	u8				ccitmin;
+	u16				ccitmin;
 	u8				s_ex_level;
 	u8				ns_ex_level;
 	u8				q_support;
diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/ledtrig-tty.c
index 8ae0d2d284af..3e69a7bde928 100644
--- a/drivers/leds/trigger/ledtrig-tty.c
+++ b/drivers/leds/trigger/ledtrig-tty.c
@@ -168,6 +168,10 @@ static void ledtrig_tty_deactivate(struct led_classdev *led_cdev)
 
 	cancel_delayed_work_sync(&trigger_data->dwork);
 
+	kfree(trigger_data->ttyname);
+	tty_kref_put(trigger_data->tty);
+	trigger_data->tty = NULL;
+
 	kfree(trigger_data);
 }
 
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 26e1e8a5e941..b02b1a3010f7 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -36,7 +36,6 @@
  */
 
 #include <linux/blkdev.h>
-#include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/raid/pq.h>
 #include <linux/async_tx.h>
@@ -6820,18 +6819,7 @@ static void raid5d(struct md_thread *thread)
 			spin_unlock_irq(&conf->device_lock);
 			md_check_recovery(mddev);
 			spin_lock_irq(&conf->device_lock);
-
-			/*
-			 * Waiting on MD_SB_CHANGE_PENDING below may deadlock
-			 * seeing md_check_recovery() is needed to clear
-			 * the flag when using mdmon.
-			 */
-			continue;
 		}
-
-		wait_event_lock_irq(mddev->sb_wait,
-			!test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags),
-			conf->device_lock);
 	}
 	pr_debug("%d stripes handled\n", handled);
 
diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index 9f5d784cd95d..3644997a8342 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -65,6 +65,10 @@ enum parport_pc_pci_cards {
 	sunix_5069a,
 	sunix_5079a,
 	sunix_5099a,
+	brainboxes_uc257,
+	brainboxes_is300,
+	brainboxes_uc414,
+	brainboxes_px263,
 };
 
 /* each element directly indexed from enum list, above */
@@ -158,6 +162,10 @@ static struct parport_pc_pci cards[] = {
 	/* sunix_5069a */		{ 1, { { 1, 2 }, } },
 	/* sunix_5079a */		{ 1, { { 1, 2 }, } },
 	/* sunix_5099a */		{ 1, { { 1, 2 }, } },
+	/* brainboxes_uc257 */	{ 1, { { 3, -1 }, } },
+	/* brainboxes_is300 */	{ 1, { { 3, -1 }, } },
+	/* brainboxes_uc414 */  { 1, { { 3, -1 }, } },
+	/* brainboxes_px263 */	{ 1, { { 3, -1 }, } },
 };
 
 static struct pci_device_id parport_serial_pci_tbl[] = {
@@ -277,6 +285,38 @@ static struct pci_device_id parport_serial_pci_tbl[] = {
 	{ PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999, PCI_VENDOR_ID_SUNIX,
 	  0x0104, 0, 0, sunix_5099a },
 
+	/* Brainboxes UC-203 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0bc1,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0bc2,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+
+	/* Brainboxes UC-257 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0861,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0862,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0863,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+
+	/* Brainboxes UC-414 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0e61,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc414 },
+
+	/* Brainboxes UC-475 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0981,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0982,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+
+	/* Brainboxes IS-300/IS-500 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0da0,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_is300 },
+
+	/* Brainboxes PX-263/PX-295 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x402c,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_px263 },
+
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci,parport_serial_pci_tbl);
@@ -542,6 +582,30 @@ static struct pciserial_board pci_parport_serial_boards[] = {
 		.base_baud      = 921600,
 		.uart_offset	= 0x8,
 	},
+	[brainboxes_uc257] = {
+		.flags		= FL_BASE2,
+		.num_ports	= 2,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[brainboxes_is300] = {
+		.flags		= FL_BASE2,
+		.num_ports	= 1,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[brainboxes_uc414] = {
+		.flags		= FL_BASE2,
+		.num_ports	= 4,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[brainboxes_px263] = {
+		.flags		= FL_BASE2,
+		.num_ports	= 4,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
 };
 
 struct parport_serial_private {
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ea476252280a..d55a3ffae4b8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4699,17 +4699,21 @@ static int pci_quirk_xgene_acs(struct pci_dev *dev, u16 acs_flags)
  * But the implementation could block peer-to-peer transactions between them
  * and provide ACS-like functionality.
  */
-static int  pci_quirk_zhaoxin_pcie_ports_acs(struct pci_dev *dev, u16 acs_flags)
+static int pci_quirk_zhaoxin_pcie_ports_acs(struct pci_dev *dev, u16 acs_flags)
 {
 	if (!pci_is_pcie(dev) ||
 	    ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
 	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)))
 		return -ENOTTY;
 
+	/*
+	 * Future Zhaoxin Root Ports and Switch Downstream Ports will
+	 * implement ACS capability in accordance with the PCIe Spec.
+	 */
 	switch (dev->device) {
 	case 0x0710 ... 0x071e:
 	case 0x0721:
-	case 0x0723 ... 0x0732:
+	case 0x0723 ... 0x0752:
 		return pci_acs_ctrl_enabled(acs_flags,
 			PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
 	}
diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 62082d64ece0..2d572f6c8ec8 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -466,13 +466,13 @@ static int uio_open(struct inode *inode, struct file *filep)
 
 	mutex_lock(&minor_lock);
 	idev = idr_find(&uio_idr, iminor(inode));
-	mutex_unlock(&minor_lock);
 	if (!idev) {
 		ret = -ENODEV;
+		mutex_unlock(&minor_lock);
 		goto out;
 	}
-
 	get_device(&idev->dev);
+	mutex_unlock(&minor_lock);
 
 	if (!try_module_get(idev->owner)) {
 		ret = -ENODEV;
@@ -1064,9 +1064,8 @@ void uio_unregister_device(struct uio_info *info)
 	wake_up_interruptible(&idev->wait);
 	kill_fasync(&idev->async_queue, SIGIO, POLL_HUP);
 
-	device_unregister(&idev->dev);
-
 	uio_free_minor(minor);
+	device_unregister(&idev->dev);
 
 	return;
 }
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 47e88b4d4e7d..a8fc2cac6879 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -754,6 +754,12 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 		memcpy(pval, value, size);
 		last->e_value_size = cpu_to_le16(size);
 		new_hsize += newsize;
+		/*
+		 * Explicitly add the null terminator.  The unused xattr space
+		 * is supposed to always be zeroed, which would make this
+		 * unnecessary, but don't depend on that.
+		 */
+		*(u32 *)((u8 *)last + newsize) = 0;
 	}
 
 	error = write_all_xattrs(inode, new_hsize, base_addr, ipage);
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 652ab429bf2e..ca2c528c9de3 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2971,7 +2971,7 @@ int smb2_open(struct ksmbd_work *work)
 					    &may_flags);
 
 	if (!test_tree_conn_flag(tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
-		if (open_flags & O_CREAT) {
+		if (open_flags & (O_CREAT | O_TRUNC)) {
 			ksmbd_debug(SMB,
 				    "User does not have write permission\n");
 			rc = -EACCES;
@@ -5943,12 +5943,6 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 	}
 	case FILE_RENAME_INFORMATION:
 	{
-		if (!test_tree_conn_flag(work->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
-			ksmbd_debug(SMB,
-				    "User does not have write permission\n");
-			return -EACCES;
-		}
-
 		if (buf_len < sizeof(struct smb2_file_rename_info))
 			return -EINVAL;
 
@@ -5968,12 +5962,6 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 	}
 	case FILE_DISPOSITION_INFORMATION:
 	{
-		if (!test_tree_conn_flag(work->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
-			ksmbd_debug(SMB,
-				    "User does not have write permission\n");
-			return -EACCES;
-		}
-
 		if (buf_len < sizeof(struct smb2_file_disposition_info))
 			return -EINVAL;
 
@@ -6035,7 +6023,7 @@ int smb2_set_info(struct ksmbd_work *work)
 {
 	struct smb2_set_info_req *req;
 	struct smb2_set_info_rsp *rsp;
-	struct ksmbd_file *fp;
+	struct ksmbd_file *fp = NULL;
 	int rc = 0;
 	unsigned int id = KSMBD_NO_FID, pid = KSMBD_NO_FID;
 
@@ -6055,6 +6043,13 @@ int smb2_set_info(struct ksmbd_work *work)
 		rsp = smb2_get_msg(work->response_buf);
 	}
 
+	if (!test_tree_conn_flag(work->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
+		ksmbd_debug(SMB, "User does not have write permission\n");
+		pr_err("User does not have write permission\n");
+		rc = -EACCES;
+		goto err_out;
+	}
+
 	if (!has_file_id(id)) {
 		id = req->VolatileFileId;
 		pid = req->PersistentFileId;
diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 1164365533f0..1c9775f1efa5 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -401,10 +401,6 @@ static void parse_dacl(struct mnt_idmap *idmap,
 	if (num_aces > ULONG_MAX / sizeof(struct smb_ace *))
 		return;
 
-	ppace = kmalloc_array(num_aces, sizeof(struct smb_ace *), GFP_KERNEL);
-	if (!ppace)
-		return;
-
 	ret = init_acl_state(&acl_state, num_aces);
 	if (ret)
 		return;
@@ -414,6 +410,13 @@ static void parse_dacl(struct mnt_idmap *idmap,
 		return;
 	}
 
+	ppace = kmalloc_array(num_aces, sizeof(struct smb_ace *), GFP_KERNEL);
+	if (!ppace) {
+		free_acl_state(&default_acl_state);
+		free_acl_state(&acl_state);
+		return;
+	}
+
 	/*
 	 * reset rwx permissions for user/group/other.
 	 * Also, if num_aces is 0 i.e. DACL has no ACEs,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 7a5fc89a8652..c9c2ad5e2681 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -101,9 +101,11 @@ static int set_memmap_mode(const char *val, const struct kernel_param *kp)
 
 static int get_memmap_mode(char *buffer, const struct kernel_param *kp)
 {
-	if (*((int *)kp->arg) == MEMMAP_ON_MEMORY_FORCE)
-		return sprintf(buffer,  "force\n");
-	return param_get_bool(buffer, kp);
+	int mode = *((int *)kp->arg);
+
+	if (mode == MEMMAP_ON_MEMORY_FORCE)
+		return sprintf(buffer, "force\n");
+	return sprintf(buffer, "%c\n", mode ? 'Y' : 'N');
 }
 
 static const struct kernel_param_ops memmap_mode_ops = {
diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 564c5632e1a2..bfe5a4082d8e 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -16,6 +16,21 @@ elif type c++filt >/dev/null 2>&1 ; then
 	cppfilt_opts=-i
 fi
 
+UTIL_SUFFIX=
+if [[ -z ${LLVM:-} ]]; then
+	UTIL_PREFIX=${CROSS_COMPILE:-}
+else
+	UTIL_PREFIX=llvm-
+	if [[ ${LLVM} == */ ]]; then
+		UTIL_PREFIX=${LLVM}${UTIL_PREFIX}
+	elif [[ ${LLVM} == -* ]]; then
+		UTIL_SUFFIX=${LLVM}
+	fi
+fi
+
+READELF=${UTIL_PREFIX}readelf${UTIL_SUFFIX}
+ADDR2LINE=${UTIL_PREFIX}addr2line${UTIL_SUFFIX}
+
 if [[ $1 == "-r" ]] ; then
 	vmlinux=""
 	basepath="auto"
@@ -75,7 +90,7 @@ find_module() {
 
 	if [[ "$modpath" != "" ]] ; then
 		for fn in $(find "$modpath" -name "${module//_/[-_]}.ko*") ; do
-			if readelf -WS "$fn" | grep -qwF .debug_line ; then
+			if ${READELF} -WS "$fn" | grep -qwF .debug_line ; then
 				echo $fn
 				return
 			fi
@@ -169,7 +184,7 @@ parse_symbol() {
 	if [[ $aarray_support == true && "${cache[$module,$address]+isset}" == "isset" ]]; then
 		local code=${cache[$module,$address]}
 	else
-		local code=$(${CROSS_COMPILE}addr2line -i -e "$objfile" "$address" 2>/dev/null)
+		local code=$(${ADDR2LINE} -i -e "$objfile" "$address" 2>/dev/null)
 		if [[ $aarray_support == true ]]; then
 			cache[$module,$address]=$code
 		fi
diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 92ca2b3b6c92..d3fa6e136744 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -12,6 +12,7 @@
 #include <sound/hda_codec.h>
 #include <sound/soc.h>
 #include <linux/pm_runtime.h>
+#include <linux/spi/spi.h>
 #include "hda_local.h"
 #include "hda_auto_parser.h"
 #include "hda_jack.h"
@@ -996,6 +997,11 @@ static int cs35l41_smart_amp(struct cs35l41_hda *cs35l41)
 	__be32 halo_sts;
 	int ret;
 
+	if (cs35l41->bypass_fw) {
+		dev_warn(cs35l41->dev, "Bypassing Firmware.\n");
+		return 0;
+	}
+
 	ret = cs35l41_init_dsp(cs35l41);
 	if (ret) {
 		dev_warn(cs35l41->dev, "Cannot Initialize Firmware. Error: %d\n", ret);
@@ -1588,6 +1594,7 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	u32 values[HDA_MAX_COMPONENTS];
 	struct acpi_device *adev;
 	struct device *physdev;
+	struct spi_device *spi;
 	const char *sub;
 	char *property;
 	size_t nval;
@@ -1610,7 +1617,7 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	ret = cs35l41_add_dsd_properties(cs35l41, physdev, id, hid);
 	if (!ret) {
 		dev_info(cs35l41->dev, "Using extra _DSD properties, bypassing _DSD in ACPI\n");
-		goto put_physdev;
+		goto out;
 	}
 
 	property = "cirrus,dev-index";
@@ -1701,8 +1708,20 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 		hw_cfg->bst_type = CS35L41_EXT_BOOST;
 
 	hw_cfg->valid = true;
+out:
 	put_device(physdev);
 
+	cs35l41->bypass_fw = false;
+	if (cs35l41->control_bus == SPI) {
+		spi = to_spi_device(cs35l41->dev);
+		if (spi->max_speed_hz < CS35L41_MAX_ACCEPTABLE_SPI_SPEED_HZ) {
+			dev_warn(cs35l41->dev,
+				 "SPI speed is too slow to support firmware download: %d Hz.\n",
+				 spi->max_speed_hz);
+			cs35l41->bypass_fw = true;
+		}
+	}
+
 	return 0;
 
 err:
@@ -1711,14 +1730,13 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	hw_cfg->gpio1.valid = false;
 	hw_cfg->gpio2.valid = false;
 	acpi_dev_put(cs35l41->dacpi);
-put_physdev:
 	put_device(physdev);
 
 	return ret;
 }
 
 int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int irq,
-		      struct regmap *regmap)
+		      struct regmap *regmap, enum control_bus control_bus)
 {
 	unsigned int regid, reg_revid;
 	struct cs35l41_hda *cs35l41;
@@ -1737,6 +1755,7 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 	cs35l41->dev = dev;
 	cs35l41->irq = irq;
 	cs35l41->regmap = regmap;
+	cs35l41->control_bus = control_bus;
 	dev_set_drvdata(dev, cs35l41);
 
 	ret = cs35l41_hda_read_acpi(cs35l41, device_name, id);
diff --git a/sound/pci/hda/cs35l41_hda.h b/sound/pci/hda/cs35l41_hda.h
index 3d925d677213..43d55292b327 100644
--- a/sound/pci/hda/cs35l41_hda.h
+++ b/sound/pci/hda/cs35l41_hda.h
@@ -20,6 +20,8 @@
 #include <linux/firmware/cirrus/cs_dsp.h>
 #include <linux/firmware/cirrus/wmfw.h>
 
+#define CS35L41_MAX_ACCEPTABLE_SPI_SPEED_HZ	1000000
+
 struct cs35l41_amp_cal_data {
 	u32 calTarget[2];
 	u32 calTime[2];
@@ -46,6 +48,11 @@ enum cs35l41_hda_gpio_function {
 	CS35l41_SYNC,
 };
 
+enum control_bus {
+	I2C,
+	SPI
+};
+
 struct cs35l41_hda {
 	struct device *dev;
 	struct regmap *regmap;
@@ -74,6 +81,9 @@ struct cs35l41_hda {
 	struct cs_dsp cs_dsp;
 	struct acpi_device *dacpi;
 	bool mute_override;
+	enum control_bus control_bus;
+	bool bypass_fw;
+
 };
 
 enum halo_state {
@@ -85,7 +95,7 @@ enum halo_state {
 extern const struct dev_pm_ops cs35l41_hda_pm_ops;
 
 int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int irq,
-		      struct regmap *regmap);
+		      struct regmap *regmap, enum control_bus control_bus);
 void cs35l41_hda_remove(struct device *dev);
 int cs35l41_get_speaker_id(struct device *dev, int amp_index, int num_amps, int fixed_gpio_id);
 
diff --git a/sound/pci/hda/cs35l41_hda_i2c.c b/sound/pci/hda/cs35l41_hda_i2c.c
index b44536fbba17..603e9bff3a71 100644
--- a/sound/pci/hda/cs35l41_hda_i2c.c
+++ b/sound/pci/hda/cs35l41_hda_i2c.c
@@ -30,7 +30,7 @@ static int cs35l41_hda_i2c_probe(struct i2c_client *clt)
 		return -ENODEV;
 
 	return cs35l41_hda_probe(&clt->dev, device_name, clt->addr, clt->irq,
-				 devm_regmap_init_i2c(clt, &cs35l41_regmap_i2c));
+				 devm_regmap_init_i2c(clt, &cs35l41_regmap_i2c), I2C);
 }
 
 static void cs35l41_hda_i2c_remove(struct i2c_client *clt)
diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index c1afb721b4c6..35277ce890a4 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -16,10 +16,6 @@
 
 struct cs35l41_config {
 	const char *ssid;
-	enum {
-		SPI,
-		I2C
-	} bus;
 	int num_amps;
 	enum {
 		INTERNAL,
@@ -35,42 +31,72 @@ struct cs35l41_config {
 };
 
 static const struct cs35l41_config cs35l41_config_table[] = {
+	{ "10280B27", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "10280B28", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "10280BEB", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
+	{ "10280C4D", 4, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, CS35L41_LEFT, CS35L41_RIGHT }, 0, 1, -1, 1000, 4500, 24 },
 /*
  * Device 103C89C6 does have _DSD, however it is setup to use the wrong boost type.
  * We can override the _DSD to correct the boost type here.
  * Since this laptop has valid ACPI, we do not need to handle cs-gpios, since that already exists
  * in the ACPI. The Reset GPIO is also valid, so we can use the Reset defined in _DSD.
  */
-	{ "103C89C6", SPI, 2, INTERNAL, { CS35L41_RIGHT, CS35L41_LEFT, 0, 0 }, -1, -1, -1, 1000, 4500, 24 },
-	{ "104312AF", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
-	{ "10431433", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
-	{ "10431463", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
-	{ "10431473", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 1000, 4500, 24 },
-	{ "10431483", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 1000, 4500, 24 },
-	{ "10431493", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
-	{ "104314D3", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
-	{ "104314E3", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
-	{ "10431503", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
-	{ "10431533", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
-	{ "10431573", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
-	{ "10431663", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 1000, 4500, 24 },
-	{ "104316D3", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
-	{ "104316F3", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
-	{ "104317F3", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
-	{ "10431863", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
-	{ "104318D3", I2C, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
-	{ "10431C9F", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
-	{ "10431CAF", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
-	{ "10431CCF", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
-	{ "10431CDF", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
-	{ "10431CEF", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
-	{ "10431D1F", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
-	{ "10431DA2", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
-	{ "10431E02", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
-	{ "10431EE2", I2C, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
-	{ "10431F12", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
-	{ "10431F1F", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
-	{ "10431F62", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
+	{ "103C89C6", 2, INTERNAL, { CS35L41_RIGHT, CS35L41_LEFT, 0, 0 }, -1, -1, -1, 1000, 4500, 24 },
+	{ "103C8A28", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8A29", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8A2A", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8A2B", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8A2C", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8A2D", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8A2E", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8A30", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8A31", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8BB3", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8BB4", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8BDF", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8BE0", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8BE1", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8BE2", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8BE9", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8BDD", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8BDE", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8BE3", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8BE5", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8BE6", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8B3A", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "104312AF", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "10431433", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
+	{ "10431463", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
+	{ "10431473", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 1000, 4500, 24 },
+	{ "10431483", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 1000, 4500, 24 },
+	{ "10431493", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "104314D3", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "104314E3", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
+	{ "10431503", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
+	{ "10431533", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
+	{ "10431573", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "10431663", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 1000, 4500, 24 },
+	{ "104316D3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
+	{ "104316F3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
+	{ "104317F3", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
+	{ "10431863", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "104318D3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
+	{ "10431C9F", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "10431CAF", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "10431CCF", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "10431CDF", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "10431CEF", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "10431D1F", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
+	{ "10431DA2", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
+	{ "10431E02", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
+	{ "10431EE2", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
+	{ "10431F12", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
+	{ "10431F1F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
+	{ "10431F62", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
+	{ "17AA38B4", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
+	{ "17AA38B5", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
+	{ "17AA38B6", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
+	{ "17AA38B7", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{}
 };
 
@@ -208,7 +234,7 @@ static int generic_dsd_config(struct cs35l41_hda *cs35l41, struct device *physde
 			 "_DSD already exists.\n");
 	}
 
-	if (cfg->bus == SPI) {
+	if (cs35l41->control_bus == SPI) {
 		cs35l41->index = id;
 
 		/*
@@ -345,7 +371,33 @@ struct cs35l41_prop_model {
 static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CLSA0100", NULL, lenovo_legion_no_acpi },
 	{ "CLSA0101", NULL, lenovo_legion_no_acpi },
+	{ "CSC3551", "10280B27", generic_dsd_config },
+	{ "CSC3551", "10280B28", generic_dsd_config },
+	{ "CSC3551", "10280BEB", generic_dsd_config },
+	{ "CSC3551", "10280C4D", generic_dsd_config },
 	{ "CSC3551", "103C89C6", generic_dsd_config },
+	{ "CSC3551", "103C8A28", generic_dsd_config },
+	{ "CSC3551", "103C8A29", generic_dsd_config },
+	{ "CSC3551", "103C8A2A", generic_dsd_config },
+	{ "CSC3551", "103C8A2B", generic_dsd_config },
+	{ "CSC3551", "103C8A2C", generic_dsd_config },
+	{ "CSC3551", "103C8A2D", generic_dsd_config },
+	{ "CSC3551", "103C8A2E", generic_dsd_config },
+	{ "CSC3551", "103C8A30", generic_dsd_config },
+	{ "CSC3551", "103C8A31", generic_dsd_config },
+	{ "CSC3551", "103C8BB3", generic_dsd_config },
+	{ "CSC3551", "103C8BB4", generic_dsd_config },
+	{ "CSC3551", "103C8BDF", generic_dsd_config },
+	{ "CSC3551", "103C8BE0", generic_dsd_config },
+	{ "CSC3551", "103C8BE1", generic_dsd_config },
+	{ "CSC3551", "103C8BE2", generic_dsd_config },
+	{ "CSC3551", "103C8BE9", generic_dsd_config },
+	{ "CSC3551", "103C8BDD", generic_dsd_config },
+	{ "CSC3551", "103C8BDE", generic_dsd_config },
+	{ "CSC3551", "103C8BE3", generic_dsd_config },
+	{ "CSC3551", "103C8BE5", generic_dsd_config },
+	{ "CSC3551", "103C8BE6", generic_dsd_config },
+	{ "CSC3551", "103C8B3A", generic_dsd_config },
 	{ "CSC3551", "104312AF", generic_dsd_config },
 	{ "CSC3551", "10431433", generic_dsd_config },
 	{ "CSC3551", "10431463", generic_dsd_config },
@@ -375,6 +427,10 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "10431F12", generic_dsd_config },
 	{ "CSC3551", "10431F1F", generic_dsd_config },
 	{ "CSC3551", "10431F62", generic_dsd_config },
+	{ "CSC3551", "17AA38B4", generic_dsd_config },
+	{ "CSC3551", "17AA38B5", generic_dsd_config },
+	{ "CSC3551", "17AA38B6", generic_dsd_config },
+	{ "CSC3551", "17AA38B7", generic_dsd_config },
 	{}
 };
 
diff --git a/sound/pci/hda/cs35l41_hda_spi.c b/sound/pci/hda/cs35l41_hda_spi.c
index eb287aa5f782..b76c0dfd5fef 100644
--- a/sound/pci/hda/cs35l41_hda_spi.c
+++ b/sound/pci/hda/cs35l41_hda_spi.c
@@ -26,7 +26,7 @@ static int cs35l41_hda_spi_probe(struct spi_device *spi)
 		return -ENODEV;
 
 	return cs35l41_hda_probe(&spi->dev, device_name, spi_get_chipselect(spi, 0), spi->irq,
-				 devm_regmap_init_spi(spi, &cs35l41_regmap_spi));
+				 devm_regmap_init_spi(spi, &cs35l41_regmap_spi), SPI);
 }
 
 static void cs35l41_hda_spi_remove(struct spi_device *spi)
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 70b17b08d4ff..04a3dffcb412 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6956,6 +6956,11 @@ static void cs35l41_fixup_i2c_two(struct hda_codec *cdc, const struct hda_fixup
 	cs35l41_generic_fixup(cdc, action, "i2c", "CSC3551", 2);
 }
 
+static void cs35l41_fixup_i2c_four(struct hda_codec *cdc, const struct hda_fixup *fix, int action)
+{
+	cs35l41_generic_fixup(cdc, action, "i2c", "CSC3551", 4);
+}
+
 static void cs35l41_fixup_spi_two(struct hda_codec *codec, const struct hda_fixup *fix, int action)
 {
 	cs35l41_generic_fixup(codec, action, "spi", "CSC3551", 2);
@@ -7441,6 +7446,7 @@ enum {
 	ALC287_FIXUP_LEGION_16ACHG6,
 	ALC287_FIXUP_CS35L41_I2C_2,
 	ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED,
+	ALC287_FIXUP_CS35L41_I2C_4,
 	ALC245_FIXUP_CS35L41_SPI_2,
 	ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED,
 	ALC245_FIXUP_CS35L41_SPI_4,
@@ -9427,6 +9433,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC285_FIXUP_HP_MUTE_LED,
 	},
+	[ALC287_FIXUP_CS35L41_I2C_4] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cs35l41_fixup_i2c_four,
+	},
 	[ALC245_FIXUP_CS35L41_SPI_2] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cs35l41_fixup_spi_two,
@@ -9703,6 +9713,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x0a9e, "Dell Latitude 5430", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0b19, "Dell XPS 15 9520", ALC289_FIXUP_DUAL_SPK),
 	SND_PCI_QUIRK(0x1028, 0x0b1a, "Dell Precision 5570", ALC289_FIXUP_DUAL_SPK),
+	SND_PCI_QUIRK(0x1028, 0x0b27, "Dell", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1028, 0x0b28, "Dell", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1028, 0x0b37, "Dell Inspiron 16 Plus 7620 2-in-1", ALC295_FIXUP_DELL_INSPIRON_TOP_SPEAKERS),
 	SND_PCI_QUIRK(0x1028, 0x0b71, "Dell Inspiron 16 Plus 7620", ALC295_FIXUP_DELL_INSPIRON_TOP_SPEAKERS),
 	SND_PCI_QUIRK(0x1028, 0x0beb, "Dell XPS 15 9530 (2023)", ALC289_FIXUP_DELL_CS35L41_SPI_2),
@@ -9713,6 +9725,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x0c1c, "Dell Precision 3540", ALC236_FIXUP_DELL_DUAL_CODECS),
 	SND_PCI_QUIRK(0x1028, 0x0c1d, "Dell Precision 3440", ALC236_FIXUP_DELL_DUAL_CODECS),
 	SND_PCI_QUIRK(0x1028, 0x0c1e, "Dell Precision 3540", ALC236_FIXUP_DELL_DUAL_CODECS),
+	SND_PCI_QUIRK(0x1028, 0x0c4d, "Dell", ALC287_FIXUP_CS35L41_I2C_4),
 	SND_PCI_QUIRK(0x1028, 0x0cbd, "Dell Oasis 13 CS MTL-U", ALC289_FIXUP_DELL_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1028, 0x0cbe, "Dell Oasis 13 2-IN-1 MTL-U", ALC289_FIXUP_DELL_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1028, 0x0cbf, "Dell Oasis 13 Low Weight MTU-L", ALC289_FIXUP_DELL_CS35L41_SPI_2),
@@ -9816,6 +9829,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8735, "HP ProBook 435 G7", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8736, "HP", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8760, "HP", ALC285_FIXUP_HP_MUTE_LED),
+	SND_PCI_QUIRK(0x103c, 0x876e, "HP ENVY x360 Convertible 13-ay0xxx", ALC245_FIXUP_HP_X360_MUTE_LEDS),
 	SND_PCI_QUIRK(0x103c, 0x877a, "HP", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x877d, "HP", ALC236_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8780, "HP ZBook Fury 17 G7 Mobile Workstation",
@@ -10229,6 +10243,10 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3886, "Y780 VECO DUAL", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38a7, "Y780P AMD YG dual", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38a8, "Y780P AMD VECO dual", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x38b4, "Legion Slim 7 16IRH8", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x38b5, "Legion Slim 7 16IRH8", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x38b6, "Legion Slim 7 16APH8", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x38b7, "Legion Slim 7 16APH8", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x38ba, "Yoga S780-14.5 Air AMD quad YC", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38bb, "Yoga S780-14.5 Air AMD quad AAC", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38be, "Yoga S980-14.5 proX YC Dual", ALC287_FIXUP_TAS2781_I2C),

