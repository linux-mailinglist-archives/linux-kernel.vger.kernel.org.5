Return-Path: <linux-kernel+bounces-1755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4246815391
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 079F6B24461
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37E118EB6;
	Fri, 15 Dec 2023 22:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="q6TncGL0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA12418EA7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679180; bh=9ZcTX73QaNIO/8jzBGKXu9xrcBn+sNqoh3q8BtNK3z0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=q6TncGL0o5mRPp1DFh7rcom3F97s9xEtBJUdPI1GMBbbWkf3ZiOMYOJj8X6Ywi3wu7buSahEB0OO6C4YSWLt6uKeLkExZmjMeSB/Hr6gXJGxpPhbBUi0Hykn5DYXV8sFu79gWRJgZJzPvOM34mlgm8gvzjY+k9PbknlO7PiNAWr6YLrlRmwQtCKzJXvN2EudnUoAKVYmVTqEEI0STRNvymSbozC7O9zWz7ieU5LPdcoV0YkrshNPt0fI0SxxxPyRqc+qHGJ31gBz+h0Rk+Lp3r4le7xyJphNpKXxZyTVsxRy+cniG3ehp2IWQHZUzMs4NmbvsMGYcSBchvy9TCwmBw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679180; bh=b5BBXITdN5mFkMToNi9u7QnrGy45/Mii05J4BSlJ/fk=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=rq6OzAwTLj2BVTjfsrPHzM+CAHoOTDC3B/yPI+JkNpeMoiVh0Bi21x9jwN4GEM3XdcDnIYLmBcGNCAksTDz5UeRuEJrvV4J9C5JDE/QjcQWxvi5Htl6+AB9n63WUvh1zGqbP4d6iYjz1bvIWag8zNhxCi+JYXf23rHrhljx/710QcDcvi+AalkvK/hHq72uhF1Dk4gTwEpuLc/nTAf5RO01caZFhIfUEaMTvPPhuJhHYnCUCeWx0NBuUdRCJ0aTbB8wSwyiEc/NtEXEQhP48xu5zi/yiRUG4w2fbUPkYdjl4m76wk/tdGchibvY15WYzYkif5WnqGu1CankE2hEU6w==
X-YMail-OSG: 9Uq_wqsVM1nsNmlQkGIjPQshXW_e3Tk6keFl7P6HDOPFhqJ284oEQptFiXV6W4m
 lF1OOt4bFL4amsHwHSXv5J1Y_t6r3dgpWxieSzYOaBg4vc7fqYRARNpezgv1l0js1EjDdzX4Aavx
 xJAKW7AaXwfYSZKRkfYCeH3Mb0rr4Wjwmj0ES80NRk8bW2oiNdy_6_dYnirwbKqSe.25Tz3bNdZ1
 moF5.On4t8XvSRY4pCl8K_KnB_3aGv5Yzgh59xvj2yxfmWPq3y1rMYMl1y78rW1Qyq_zjoDeyQ_9
 Iw7VHU9EorgG5DnDoTQ253p7p5NoxI7JiUlh_hFIT2LAyTDVSGHC25Ic0QoEiDB_hN.03Iuf85sh
 QUaz2fqTz3Gm0vTY3HlVgaKOt2FB5EkOnW.eshlzhlKBAK524LTXPduufEcy2upEGXgGjexd0nej
 zmSIt1U_O8zM8_BhW0Mxutr7OeDCVmm4X_Pj7pTlVrOSnMALYXDFfHoPSukmyLaDEQGGL2T2KWtp
 FhjHHSzYbrJ34osF10NC.z99mojsHlnEI2iL5z3wbGwaAnif2WC_3FbfrAvTRHiCFcQaySoYMlXq
 2t6JJ3NznZVQtxmDvbGWhh3aUDxY6cd5huKTzyHyZ4dY5K2MH30mwTWYZ5u2NcEZBRC4OiEQKaCQ
 YEuNKn3zlfjFSmEjKE8kyUubbFx7zwNlIB55N8a_3aKd8.IOJA4qlp6ztBv5SInWJzHiLfIbITBn
 uC1hak85Wgl_rsYYGVACq3rMlrTZCTHVRjCMrxveNEzc1zuDyXbj6pxANrvGMcdpvuU.yEutkVNQ
 J0kGjgNjBeKs9djrDr0dgg4i5nbGeGKTz8UA9c_aLdRfiH8eQtn9p3phEqSnfh6ejgsZn4MByjJJ
 yLytgGxxgEbp2CFa0u18a9Vw1UHJ.I404NDqMwBghD75phsSIPnQNPizIZmIffJW41hy4Thox9U9
 umv55xn8MzncshrzNO_f6Wyb6FMMjxbQVZfqdbJ5UzyMa_N.mKvd33UKjShhVbjAvahzmOBnkgn_
 Kneq2nNEFhvoEoHW2hIggx_E8N9tplGOtsmEzlkOXa8sfX.qO7yH99bc6gvd4EuFya2FXKsI6SZV
 lk6DxAqGlwtyn.G5FIJUCrsIMe3C.kH_4FtuEiXXimJMNArQqngNWGnZm9m__bBUrr5gnpgSum09
 Ek1i19n_SN03gnejfzqLD8YgRqFyh7XP22yKz65pFufbtnYAf4Y.Q_kcqJrkdb9rznBk4No9T6h0
 MGdIzCEmtIRRuDLX4TB9HikpOnlLJ3KwVSRwZi78pp89F5pUQXff64OyLxvvsyAqX6O3PpuP1wsW
 Js7yylf3anQNuxI8_jQy.13aGSEWCA4CuIQdajVLjKdOSbBgNxCUO_HLk_8IDgyF.SA3F3kMxFm_
 n8q2IRbzAAHOR4mhpR5nuRdJbz6FCeEUxtmekoK8ToMRVel4QvSCJlgaGSeNnYRmSljBIeJrpZp1
 5VkayYarMtr6OyoSWZF9bUm9o8o0ku5X5E3CCavUXSJMQI4p4tRkY9DvCwYONeRoOegpDknpQ8ps
 HEq8MscOMjuaTh4TQIWZWMnMCWzL_uVX5uGuc.gX8iwj6wDJoe8QGXO_Hslb9ovBDOpIdeQy2peJ
 39eecZm7TWEL67A2.IQOGbV0saf0c8w5F8JL5Pn1TlgiwmhpZeD3sWpeNzAb0f0aJ.vnrC27NKnn
 pTkbehBdD5IJFQrthx3i4Dh5D.16XuRlk1NLJuSk6_RefvvnwnFrRZWQPVxoW6.DcgRLipEvkgX_
 E_KiizjnbRbNGobrUS_nN8XuXsCCZ2EeOt5F54964ucQXVlPAR6ym8jEuZahFbxCmuAuVEZp2GUt
 O_0eej8ni7zOo9Wi.5Sd1xWcUpClz1Ek.r6lbyAmmObMDtJcU1rrzpcTW4Z7kplCU6VMrN5Zu13A
 nt0JDGjvelP5YvQRxEtjDuaj0TcT7AfijDjkt372.h.TNTihJJ2ScfJnLG5cL66LxeAct8ATEIWd
 nQagK_eUA5GyF27_ILDzUxE1TlRB6wOUgWnwlebvEEyOQv8PY2HxucE42wtlO2t6WwLwPHjHTgKS
 s1JBoeCor4t4huR1lpX2GSZfITTC3yHeMSUEPWimn3v.ITLu_dobsmsHCj8ux4PlJuAbYyBY5DGO
 WvATeJdE8y3kRcua4yWLf2JkKC4WXTd1rYGLKuh6X_zODv4lvUHRdDqBC.0fD3F2_3.5RPft6_XX
 .WPFh8ZcAMdG5ZtP7Fl1muK__u.jnE.f9JNVlwFnKKhcZMBt2uRqj
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 99d984fe-a30e-482e-9dbf-fc3592ae0374
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:26:20 +0000
Received: by hermes--production-gq1-6949d6d8f9-pmzmd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 82d6a093b466d43a3aa36e3491ebb0ec;
          Fri, 15 Dec 2023 22:26:16 +0000 (UTC)
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
	mic@digikod.net,
	linux-integrity@vger.kernel.org,
	audit@vger.kernel.org,
	Todd Kjos <tkjos@google.com>
Subject: [PATCH v39 13/42] LSM: Create new security_cred_getlsmblob LSM hook
Date: Fri, 15 Dec 2023 14:16:07 -0800
Message-ID: <20231215221636.105680-14-casey@schaufler-ca.com>
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

Create a new LSM hook security_cred_getlsmblob() which, like
security_cred_getsecid(), fetches LSM specific attributes from the
cred structure.  The associated data elements in the audit sub-system
are changed from a secid to a lsmblob to accommodate multiple possible
LSM audit users.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity@vger.kernel.org
Cc: audit@vger.kernel.org
Cc: Todd Kjos <tkjos@google.com>
---
 include/linux/lsm_hook_defs.h     |  2 ++
 include/linux/security.h          |  7 +++++++
 security/integrity/ima/ima_main.c |  7 ++-----
 security/security.c               | 15 +++++++++++++++
 security/selinux/hooks.c          |  8 ++++++++
 security/smack/smack_lsm.c        | 18 ++++++++++++++++++
 6 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 3c51ee8e3d6c..fe9c1d89dc66 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -196,6 +196,8 @@ LSM_HOOK(int, 0, cred_prepare, struct cred *new, const struct cred *old,
 LSM_HOOK(void, LSM_RET_VOID, cred_transfer, struct cred *new,
 	 const struct cred *old)
 LSM_HOOK(void, LSM_RET_VOID, cred_getsecid, const struct cred *c, u32 *secid)
+LSM_HOOK(void, LSM_RET_VOID, cred_getlsmblob, const struct cred *c,
+	 struct lsmblob *blob)
 LSM_HOOK(int, 0, kernel_act_as, struct cred *new, u32 secid)
 LSM_HOOK(int, 0, kernel_create_files_as, struct cred *new, struct inode *inode)
 LSM_HOOK(int, 0, kernel_module_request, char *kmod_name)
diff --git a/include/linux/security.h b/include/linux/security.h
index e8b7f858de04..67ecf8588c90 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -460,6 +460,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
+void security_cred_getlsmblob(const struct cred *c, struct lsmblob *blob);
 int security_kernel_act_as(struct cred *new, u32 secid);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
@@ -1151,6 +1152,12 @@ static inline void security_cred_getsecid(const struct cred *c, u32 *secid)
 	*secid = 0;
 }
 
+static inline void security_cred_getlsmblob(const struct cred *c,
+					    struct lsmblob *blob)
+{
+	*secid = 0;
+}
+
 static inline int security_kernel_act_as(struct cred *cred, u32 secid)
 {
 	return 0;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 657143fe558d..c69eb9665cc1 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -526,8 +526,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 int ima_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
-	u32 secid;
-	struct lsmblob blob = { };
+	struct lsmblob blob;
 
 	security_current_getlsmblob_subj(&blob);
 	ret = process_measurement(bprm->file, current_cred(),
@@ -535,9 +534,7 @@ int ima_bprm_check(struct linux_binprm *bprm)
 	if (ret)
 		return ret;
 
-	security_cred_getsecid(bprm->cred, &secid);
-	/* stacking scaffolding */
-	blob.scaffold.secid = secid;
+	security_cred_getlsmblob(bprm->cred, &blob);
 	return process_measurement(bprm->file, bprm->cred, &blob, NULL, 0,
 				   MAY_EXEC, CREDS_CHECK);
 }
diff --git a/security/security.c b/security/security.c
index ed4e9b5fdf70..1cbd45310f63 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3111,6 +3111,21 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
 }
 EXPORT_SYMBOL(security_cred_getsecid);
 
+/**
+ * security_cred_getlsmblob() - Get the LSM data from a set of credentials
+ * @c: credentials
+ * @blob: destination for the LSM data
+ *
+ * Retrieve the security data of the cred structure @c.  In case of
+ * failure, @blob will be cleared.
+ */
+void security_cred_getlsmblob(const struct cred *c, struct lsmblob *blob)
+{
+	lsmblob_init(blob);
+	call_void_hook(cred_getlsmblob, c, blob);
+}
+EXPORT_SYMBOL(security_cred_getlsmblob);
+
 /**
  * security_kernel_act_as() - Set the kernel credentials to act as secid
  * @new: credentials
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4ab923698da9..1bc28f5f6870 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3992,6 +3992,13 @@ static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
 	*secid = cred_sid(c);
 }
 
+static void selinux_cred_getlsmblob(const struct cred *c, struct lsmblob *blob)
+{
+	blob->selinux.secid = cred_sid(c);
+	/* stacking scaffolding */
+	blob->scaffold.secid = blob->selinux.secid;
+}
+
 /*
  * set the security data for a kernel service
  * - all the creation contexts are set to unlabelled
@@ -7153,6 +7160,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(cred_prepare, selinux_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, selinux_cred_transfer),
 	LSM_HOOK_INIT(cred_getsecid, selinux_cred_getsecid),
+	LSM_HOOK_INIT(cred_getlsmblob, selinux_cred_getlsmblob),
 	LSM_HOOK_INIT(kernel_act_as, selinux_kernel_act_as),
 	LSM_HOOK_INIT(kernel_create_files_as, selinux_kernel_create_files_as),
 	LSM_HOOK_INIT(kernel_module_request, selinux_kernel_module_request),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index e6d49e59a0c0..7dab00bbd0ed 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2121,6 +2121,23 @@ static void smack_cred_getsecid(const struct cred *cred, u32 *secid)
 	rcu_read_unlock();
 }
 
+/**
+ * smack_cred_getlsmblob - get the Smack label for a creds structure
+ * @cred: the object creds
+ * @blob: where to put the data
+ *
+ * Sets the Smack part of the blob
+ */
+static void smack_cred_getlsmblob(const struct cred *cred,
+				  struct lsmblob *blob)
+{
+	rcu_read_lock();
+	blob->smack.skp = smk_of_task(smack_cred(cred));
+	/* stacking scaffolding */
+	blob->scaffold.secid = blob->smack.skp->smk_secid;
+	rcu_read_unlock();
+}
+
 /**
  * smack_kernel_act_as - Set the subjective context in a set of credentials
  * @new: points to the set of credentials to be modified.
@@ -5102,6 +5119,7 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(cred_prepare, smack_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, smack_cred_transfer),
 	LSM_HOOK_INIT(cred_getsecid, smack_cred_getsecid),
+	LSM_HOOK_INIT(cred_getlsmblob, smack_cred_getlsmblob),
 	LSM_HOOK_INIT(kernel_act_as, smack_kernel_act_as),
 	LSM_HOOK_INIT(kernel_create_files_as, smack_kernel_create_files_as),
 	LSM_HOOK_INIT(task_setpgid, smack_task_setpgid),
-- 
2.41.0


