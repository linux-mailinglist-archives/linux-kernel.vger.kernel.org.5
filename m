Return-Path: <linux-kernel+bounces-1740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DA9815366
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F2EAB25148
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3105713B140;
	Fri, 15 Dec 2023 22:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="aU7oB6Lb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3435D13B138
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702678701; bh=FWuDNgdpCAWOPQ8pKENu3D4KD/v4ITCKXFqzF8c2TZc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=aU7oB6Lb6iP0yRjijZgDLrdJMMoo2694H3uQOuUQs3j5bGN+Hl8rm6Ok0ua/wCtClxpifru0VGRtlKL/zxbLhXRA38G7k4XoCHRzLLpwBWy0Cr4nGVaBCYTl8YDgKm+TR58piXRTa8/zxiO0gMuiQSbOFwcN5JUhRhomZarMusTHohiK93TtAzSQ2tx3lozavHoEHntomvad9BMM1qgs2tAiChedHR3/xrR3SU7auXXtV+Iq/e8y5cDvUhqi+Ze6uZ0//O/b2MXt+C3w04EErZ0ScG5G4q/CzgOQNjO4XCqyaufzRTrpPBOw7iyytA5vsU26gt8yD46OIvfr2Ks1kw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702678701; bh=OoxX26JW+NchuXGVZv3GGkGMlzlO1isaAVCjJ1Ui5qc=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qTvZtOQ0H6CU0fKfahLPxANvk1F6ZXFDWITw4DlQ1B2ClPU/x9GBn1gMlolBRgkbGL1F2O8XyXaY9V6BrX+JgT6ANhWDu/8c/hAz1kG41pU6GgHdHhNx0KV2JmgM269x5ZizO2xbMmRNskxh7X/NNjSlC4fb0l7t+9h+891uGu9hyNNjlGX0oSBdrihdtqtAEYGqdcbB66ahc8GPYZwXzIXVUTpudMqXhU+kkhwwdlgRzBo8h2VHhv7tIOTezYEXpF83jhPCMkhpq9BSov/945efVfiUZDYEFEOlY453Ho/2Id/EPh5v0tmJ3O7lF0D8lNbPA0uUitT6r7PODMSS6Q==
X-YMail-OSG: ver.UiQVM1mWsJ__gOg3uxzsQ8W_x7_5GYYrD2NTVkpyRaIwO7EwZn3j4XaxQpV
 Agm.FDvMcyUplmhdSEC8fb9ZOPb5ky4KHNk0RmWo.Fxm6yIWmbYw09Kk9AIGCrkCs2Z2h_W_uerG
 VRty4aljvVa1T8TQDeKynOc2aXJo4yFIiGfPNlykmoxhtUQ.vGU_wGwXEx9lL2LkzUK5S0K5PCYo
 zGJTJ9yQ2MM91R7LdkuU8fsrFWKLnt5xFBTnmt6jthVGi5nLSF_Je65lS.7z1RVav2eB2fMkMDVe
 BHK4e0KjXChO5lWp3ohJ6YRW8j.xS5IR7e0wg_veyefYmIzi3_u02cWXlWity6Zd0Nmt_V.XKutT
 UCveMB0J39wtLr2nYyRe8h_rgG6P5N.idEU8s3bkOjbexF1bV_Nuzr8M.72Fr4cE13pAzgdg5Kg4
 KFsh5e30xE1BvzY.WI6ItsIkEi1ODIU_pcHAKRUDz7ki.zgRclYr_N31YV.FfP0UHkMNOEGOXM.9
 SttQ6FP0vaO1A5mSmmXbmJdcfq2l3xSO3DU8f0XddtHnqnCiAs24uVciBla7QjLBvLEEUtxlubyn
 D1WaCLB_9PZmJY3CKRjVmCHblQ_cQXm.rBdIrjj4LauZ0AKfiNNNsC_5QxVQZ8PkA91.Y_dlGzE1
 BsO.0WEQA5YdqGOFp9Fqfh0w2QlBVOZlArBP8qQZ5vlaho1IzV9x7R_gtdXDGSPcxHKZdXfA7UiX
 Er3EXews6o0j8An0wAAfF.tqBeyeGDLU.d0uHmLYSQVm9KzrU4FEHfNL.YVT.prLOHia4vCrxN5j
 EiswHFwh0.ShFxjTPh4CU2oKronWPMm_DLpBl8Bk95UEL2aiKPmOsQQDzhXAXN1_5gxlPoZgRN5w
 G7xBnkgfKtWGPh1ZeWAtOlvUjeXla8qa_0CBpmK5qsulRhodPqBtqAvYr8LJESi.MzYDLSnLDsyv
 jNyQQlza2fGngDd7wtHF3WRlZIKnoHigquFpeaF5bA2Fw3vkdhKH1gGyzc83EliOdRmIkFOf6OyB
 gRrce9.TlmkbxeWSO8EUKsbTQ.GWrfYPpCojN_msH_rOBpGNcLaJjeXOhj8EDVadbvgLhsRazgEl
 .xwjw9Gpd_S2ocRYAJqQ.GpeZuwvqPfhp7bk51krHkZoBNrV4d8.ux.kbvGeTw90d6kCNpGJ6XT1
 lgP4kS4hgSJNgv1BaqWDSCLgM5SneWhPJHA0eURaKWFx_TTKcqiI.IPu0Zw1T9FJQlryiWKcMcgt
 9RkjoYs1odqhTx9GH5N6KYd.UpnJZ8DBu4T_.vrX2jRn4br4sNkJ2hLeXNQschEZHW6vdd6HzTFK
 OzN08O822xjyYVE9WK6Zmoy.29EIADfsx.L._Ta0Dx18sk6sTE4JiDkEQB2aHrIG1nV5SnJi2dPv
 e128_X2v588nDVGQF.F8deBnpuvPiLsS.Jv9njp0zBN1u.ocF_JATd_KViSnJ5ynV07Doix_HLdL
 ZqI52bBqBQzKpOrSE1C5embIr66VufC5XDdwk.BFWqZFoSOkdfS9AkLPZr24Z5tffe0.NqFOBLUJ
 3zl2PFL0_05tT.KVFvcAo2bIb9smvqB4PZQnJ7YmFr1.McUguemF8TFV3olUjJyR7Og52m5l7pUY
 lKje97cKwpSnflEd2SQvKpmdSBlcFqtG1x_ArgKwl3D4jWbaveUvnWrEAtCakC1kPDU8q_YFjO9G
 aFbCRqFWVkxW.C4RFEePZ84YLlD9wI_weU8eHGQmuVUzWi9dQcJfLB3W4ZJlIkKKz6YocaVJj7NR
 yc7CfpNke.rRrJv5J4l25F4KYRGucwt.5s43yhDsgUjGwxiwFt7n.PWPXadQrupwd_WFcOWW.jE4
 3cZrF5mGnDMhWD2LXMvmmhDbG60P2ghQGNz0wGP.W81fzv5NlJh5wt8tqgGT5uy9UclLWL4_ngD3
 _gvhINRPB5mk2gv0Q3fJ3nV_JDpT6ObGKbqPMq26hUOavogmV9KMCz.IpMpUN.2u0_N7xaC3HUX9
 ga7FX_5fPM9DZwUnlSMYnbqiycnsvBWRmxWbic0dIphxJ5IXiKb3n69bQdQ0SlMsyX0m9_hKVGZt
 uT.goRB0sOcC.5lEkdfezfLDw9uta0F2HxeQK6Pn_4uo7AvKF87NbPivi4m7BNzUYCxBqD5t0Fkc
 QWw3q9pl.1MlqQkNVuuEXuG5sQkn4yzye5MNt0DADcucI213c25u4zAP5AF2EW2vYhVhlDqJKDMF
 HG8Qcb_XcbF8RXUZMXPHpYqsNO95CXFHZuAYZ9YtPkY7O_5ICzwytzIKwE2MfN1fh8BQ5iLVhh45
 0OYEQh3mJXMmaeB7eI6I-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 0df143bb-7cfd-4c6e-9191-144d8b00e699
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:18:21 +0000
Received: by hermes--production-gq1-6949d6d8f9-c9pk7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f3cc26e4d12b933f3b6c85ffc86b5c01;
          Fri, 15 Dec 2023 22:18:20 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	mic@digikod.net
Subject: [PATCH v39 03/42] LSM: Add the lsmblob data structure.
Date: Fri, 15 Dec 2023 14:15:57 -0800
Message-ID: <20231215221636.105680-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215221636.105680-1-casey@schaufler-ca.com>
References: <20231215221636.105680-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When more than one security module is exporting data to audit and
networking sub-systems a single 32 bit integer is no longer
sufficient to represent the data. Add a structure to be used instead.

The lsmblob structure definition is intended to keep the LSM
specific information private to the individual security modules.
The module specific information is included in a new set of
header files under include/lsm. Each security module is allowed
to define the information included for its use in the lsmblob.
SELinux includes a u32 secid. Smack includes a pointer into its
global label list. The conditional compilation based on feature
inclusion is contained in the include/lsm files.

Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm/apparmor.h | 17 +++++++++++++++++
 include/linux/lsm/bpf.h      | 16 ++++++++++++++++
 include/linux/lsm/selinux.h  | 16 ++++++++++++++++
 include/linux/lsm/smack.h    | 17 +++++++++++++++++
 include/linux/security.h     | 20 ++++++++++++++++++++
 5 files changed, 86 insertions(+)
 create mode 100644 include/linux/lsm/apparmor.h
 create mode 100644 include/linux/lsm/bpf.h
 create mode 100644 include/linux/lsm/selinux.h
 create mode 100644 include/linux/lsm/smack.h

diff --git a/include/linux/lsm/apparmor.h b/include/linux/lsm/apparmor.h
new file mode 100644
index 000000000000..8ff1cd899a20
--- /dev/null
+++ b/include/linux/lsm/apparmor.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Linux Security Module interface to other subsystems.
+ * AppArmor presents a single u32 value which is known as a secid.
+ */
+#ifndef __LINUX_LSM_APPARMOR_H
+#define __LINUX_LSM_APPARMOR_H
+
+struct aa_label;
+
+struct lsmblob_apparmor {
+#ifdef CONFIG_SECURITY_APPARMOR
+	struct aa_label *label;
+#endif
+};
+
+#endif /* ! __LINUX_LSM_APPARMOR_H */
diff --git a/include/linux/lsm/bpf.h b/include/linux/lsm/bpf.h
new file mode 100644
index 000000000000..48abdcd82ded
--- /dev/null
+++ b/include/linux/lsm/bpf.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Linux Security Module interface to other subsystems.
+ * BPF may present a single u32 value.
+ */
+#ifndef __LINUX_LSM_BPF_H
+#define __LINUX_LSM_BPF_H
+#include <linux/types.h>
+
+struct lsmblob_bpf {
+#ifdef CONFIG_BPF_LSM
+	u32 secid;
+#endif
+};
+
+#endif /* ! __LINUX_LSM_BPF_H */
diff --git a/include/linux/lsm/selinux.h b/include/linux/lsm/selinux.h
new file mode 100644
index 000000000000..fd16456b36ac
--- /dev/null
+++ b/include/linux/lsm/selinux.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Linux Security Module interface to other subsystems.
+ * SELinux presents a single u32 value which is known as a secid.
+ */
+#ifndef __LINUX_LSM_SELINUX_H
+#define __LINUX_LSM_SELINUX_H
+#include <linux/types.h>
+
+struct lsmblob_selinux {
+#ifdef CONFIG_SECURITY_SELINUX
+	u32 secid;
+#endif
+};
+
+#endif /* ! __LINUX_LSM_SELINUX_H */
diff --git a/include/linux/lsm/smack.h b/include/linux/lsm/smack.h
new file mode 100644
index 000000000000..2018f288302f
--- /dev/null
+++ b/include/linux/lsm/smack.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Linux Security Module interface to other subsystems.
+ * Smack presents a pointer into the global Smack label list.
+ */
+#ifndef __LINUX_LSM_SMACK_H
+#define __LINUX_LSM_SMACK_H
+
+struct smack_known;
+
+struct lsmblob_smack {
+#ifdef CONFIG_SECURITY_SMACK
+	struct smack_known *skp;
+#endif
+};
+
+#endif /* ! __LINUX_LSM_SMACK_H */
diff --git a/include/linux/security.h b/include/linux/security.h
index 4790508818ee..d4103b6cd3fc 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -33,6 +33,10 @@
 #include <linux/mm.h>
 #include <linux/sockptr.h>
 #include <uapi/linux/lsm.h>
+#include <linux/lsm/selinux.h>
+#include <linux/lsm/smack.h>
+#include <linux/lsm/apparmor.h>
+#include <linux/lsm/bpf.h>
 
 struct linux_binprm;
 struct cred;
@@ -139,6 +143,22 @@ enum lockdown_reason {
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
+/* stacking scaffolding */
+struct lsmblob_scaffold {
+	u32 secid;
+};
+
+/*
+ * Data exported by the security modules
+ */
+struct lsmblob {
+	struct lsmblob_selinux selinux;
+	struct lsmblob_smack smack;
+	struct lsmblob_apparmor apparmor;
+	struct lsmblob_bpf bpf;
+	struct lsmblob_scaffold scaffold;
+};
+
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
 extern u32 lsm_active_cnt;
 extern const struct lsm_id *lsm_idlist[];
-- 
2.41.0


