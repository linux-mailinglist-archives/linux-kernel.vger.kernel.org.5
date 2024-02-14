Return-Path: <linux-kernel+bounces-65134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3CE854870
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E221CB227DE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DF91C6BB;
	Wed, 14 Feb 2024 11:32:43 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15801C693;
	Wed, 14 Feb 2024 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910363; cv=none; b=QE6fpR9/mDQL7qMB+75JUigOEoq8EMo9cJuUJCWHVUeNVmlmFo6R2bNCH8dl28nZSY4ir5F7AllW8DF3mzfIaDeMawkLXmiynFwO4CIapZSlVBxgynlpsM6QmMM9FUQZd2jN3wF0V70NxkhjlIQ9izYNX4VBb9eY/k5VumEA3Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910363; c=relaxed/simple;
	bh=upDj9qpTtCStajMBNXnNGiR+ZhJ3V3cjJpEDu8+zmq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zleptk5j0SvwkcCuU19HKb1WDBnUtaknK8f+HI2lbtSPCrvNVX6HMfgWiKQhWWpNV1eyG8OHuO3SDwEdQ4UT3Gm7qKhavDf24h2IFOU6siYUC16ktKf8vZbeSivGUJf3V3JvTGvsCjK7GtsGEbSqhnC1I6z/HBtomipcM/hvFNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TZbCt6kvYz9y62R;
	Wed, 14 Feb 2024 19:13:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id DEE94140668;
	Wed, 14 Feb 2024 19:32:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.45.156.69])
	by APP1 (Coremail) with SMTP id LxC2BwAn0Rl8pMxlwo99Ag--.51308S7;
	Wed, 14 Feb 2024 12:32:27 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Jonathan Corbet <corbet@lwn.net>,
	David Kaplan <david.kaplan@amd.com>,
	Larry Dewey <larry.dewey@amd.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Carlos Bilbao <carlos.bilbao@amd.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	=?UTF-8?q?Marc=20Aur=C3=A8le=20La=20France?= <tsi@tuyoix.net>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Christian Brauner (Microsoft)" <brauner@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Mike Christie <michael.christie@oracle.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Maninder Singh <maninder1.s@samsung.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	petr@tesarici.cz,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: [PATCH v1 5/5] sbm: SandBox Mode documentation
Date: Wed, 14 Feb 2024 12:30:35 +0100
Message-Id: <20240214113035.2117-6-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214113035.2117-1-petrtesarik@huaweicloud.com>
References: <20240214113035.2117-1-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAn0Rl8pMxlwo99Ag--.51308S7
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw4rJryrtw1DCryxWw43Awb_yoW3uw4fpF
	Zxta4ftF4DJFy7Zr1xJw4xZFyFyw4rAr45KF95G34Fvas0934vyF1Fqr18uFy7CrWkCa4j
	qF4jgr1UCwn8A37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_
	Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
	IIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_
	Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
	xan2IY04v7MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8
	JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr
	0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	YxBIdaVFxhVjvjDU0xZFpf9x0JUzwZcUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Add a SandBox Mode document under Documentation/security. Describe the
concept, usage and known limitations.

Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
---
 Documentation/security/index.rst        |   1 +
 Documentation/security/sandbox-mode.rst | 180 ++++++++++++++++++++++++
 2 files changed, 181 insertions(+)
 create mode 100644 Documentation/security/sandbox-mode.rst

diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
index 59f8fc106cb0..680a0b8bf28b 100644
--- a/Documentation/security/index.rst
+++ b/Documentation/security/index.rst
@@ -14,6 +14,7 @@ Security Documentation
    sak
    SCTP
    self-protection
+   sandbox-mode
    siphash
    tpm/index
    digsig
diff --git a/Documentation/security/sandbox-mode.rst b/Documentation/security/sandbox-mode.rst
new file mode 100644
index 000000000000..4405b8858c4a
--- /dev/null
+++ b/Documentation/security/sandbox-mode.rst
@@ -0,0 +1,180 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
+SandBox Mode
+============
+
+Introduction
+============
+
+The primary goal of SandBox Mode (SBM) is to reduce the impact of potential
+memory safety bugs in kernel code by decomposing the kernel. The SBM API
+allows to run each component inside an isolated execution environment. In
+particular, memory areas used as input and/or output are isolated from the
+rest of the kernel and surrounded by guard pages. Without arch hooks, this
+common base provides *weak isolation*.
+
+On architectures which implement the necessary arch hooks, SandBox Mode
+leverages hardware paging facilities and CPU privilege levels to enforce the
+use of only these predefined memory areas. With arch support, SBM can also
+recover from protection violations. This means that SBM forcibly terminates
+the sandbox and returns an error code (e.g. ``-EFAULT``) to the caller, so
+execution can continue. Such implementation provides *strong isolation*.
+
+A target function in a sandbox communicates with the rest of the kernel
+through a caller-defined interface, comprising read-only buffers (input),
+read-write buffers (output) and the return value. The caller can explicitly
+share other data with the sandbox, but doing so may reduce isolation strength.
+
+Protection of sensitive kernel data is currently out of scope. SandBox Mode is
+meant to run kernel code which would otherwise have full access to all system
+resources. SBM allows to impose a scoped access control policy on which
+resources are available to the sandbox. That said, protection of sensitive
+data is foreseen as a future goal, and that's why the API is designed to
+control not only memory writes but also memory reads.
+
+The expected use case for SandBox Mode is parsing data from untrusted sources,
+especially if the parsing cannot be reasonably done by a user mode helper.
+Keep in mind that a sandbox doesn't guarantee that the output data is correct.
+The result may be corrupt (e.g. as a result of an exploited bug) and where
+applicable, it should be sanitized before further use.
+
+Using SandBox Mode
+==================
+
+SandBox Mode is an optional feature, enabled with ``CONFIG_SANDBOX_MODE``.
+However, the SBM API is always defined regardless of the kernel configuration.
+It will call a function with the best available isolation, which is:
+
+* *strong isolation* if both ``CONFIG_SANDBOX_MODE`` and
+  ``CONFIG_ARCH_HAVE_SBM`` are set,
+* *weak isolation* if ``CONFIG_SANDBOX_MODE`` is set, but
+  ``CONFIG_ARCH_HAVE_SBM`` is unset,
+* *no isolation* if ``CONFIG_SANDBOX_MODE`` is unset.
+
+Code which cannot safely run with no isolation should depend on the relevant
+config option(s).
+
+The API can be used like this:
+
+.. code-block:: c
+
+  #include <linux/sbm.h>
+
+  /* Function to be executed in a sandbox. */
+  static SBM_DEFINE_FUNC(my_func, const struct my_input *, in,
+			 struct my_output *, out)
+  {
+	/* Read from in, write to out. */
+	return 0;
+  }
+
+  int caller(...)
+  {
+	/* Declare a SBM instance. */
+	struct sbm sbm;
+
+	/* Initialize SBM instance. */
+	sbm_init(&sbm);
+
+	/* Execute my_func() using the SBM instance. */
+	err = sbm_call(&sbm, my_func,
+		       SBM_COPY_IN(&sbm, input, in_size),
+		       SBM_COPY_OUT(&sbm, output, out_size));
+
+	/* Clean up. */
+	sbm_destroy(&sbm);
+
+The return type of a sandbox mode function is always ``int``. The return value
+is zero on success and negative on error. That's because the SBM helpers
+return an error code (such as ``-ENOMEM``) if the call cannot be performed.
+
+If sbm_call() returns an error, you can use sbm_error() to decide whether the
+error was returned by the target function or because sandbox mode was aborted
+(or failed to run entirely).
+
+Public API
+----------
+
+.. kernel-doc:: include/linux/sbm.h
+		:identifiers: sbm sbm_init sbm_destroy sbm_exec sbm_error
+			      SBM_COPY_IN SBM_COPY_OUT SBM_COPY_INOUT
+			      SBM_DEFINE_CALL SBM_DEFINE_THUNK SBM_DEFINE_FUNC
+			      sbm_call
+
+Arch Hooks
+----------
+
+These hooks must be implemented to select HAVE_ARCH_SBM.
+
+.. kernel-doc:: include/linux/sbm.h
+		:identifiers: arch_sbm_init arch_sbm_destroy arch_sbm_exec
+			      arch_sbm_map_readonly arch_sbm_map_writable
+
+Current Limitations
+===================
+
+This section lists know limitations of the current SBM implementation, which
+are planned to be removed in the future.
+
+Stack
+-----
+
+There is no generic kernel API to run a function on an alternate stack, so SBM
+runs on the normal kernel stack by default. The kernel already offers
+self-protection against stack overflows and underflows as well as against
+overwriting on-stack data outside the current frame, but violations are
+usually fatal.
+
+This limitation can be solved for specific targets. Arch hooks can set up a
+separate stack and recover from stack frame overruns.
+
+Inherent Limitations
+====================
+
+This section lists limitations which are inherent to the concept.
+
+Explicit Code
+-------------
+
+The main idea behind SandBox Mode is decomposition of one big program (the
+Linux kernel) into multiple smaller programs that can be sandboxed. AFAIK
+there is no way to automate this task for an existing code base in C.
+
+Given the performance impact of running code in a sandbox, this limitation may
+be perceived as a benefit. It is expected that sandbox mode is introduced only
+knowingly and only where safety is more important than performance.
+
+Complex Data
+------------
+
+Although data structures are not serialized and deserialized between kernel
+mode and sandbox mode, all directly and indirectly referenced data structures
+must be explicitly mapped into the sandbox, which requires some manual effort.
+
+Copying of input/output buffers also incurs some runtime overhead. This
+overhead can be reduced by sharing data directly with the sandbox, but the
+resulting isolation is weaker, so it may or may not be acceptable, depending
+on the overall safety requirements.
+
+Page Granularity
+----------------
+
+Since paging is used to enforce memory safety, page size is the smallest unit.
+Objects mapped into the sandbox must be aligned to a page boundary, and buffer
+overflows may not be detected if they fit into the same page.
+
+On the other hand, even though such writes are not detected, they do not
+corrupt kernel data, because only the output buffer is copied back to kernel
+mode, and the (corrupted) rest of the page is ignored.
+
+Transitions
+-----------
+
+Transitions between kernel mode and sandbox mode are synchronous. That is,
+whenever entering or leaving sandbox mode, the currently running CPU executes
+the instructions necessary to save/restore its kernel-mode state. The API is
+generic enough to allow asynchronous transitions, e.g. to pass data to another
+CPU which is already running in sandbox mode. However, to see the benefits, a
+hypothetical implementation would require far-reaching changes in the kernel
+scheduler. This is (currently) out of scope.
-- 
2.34.1


