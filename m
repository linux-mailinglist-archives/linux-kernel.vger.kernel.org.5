Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD71B78B900
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbjH1UDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbjH1UCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:02:30 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586DA194
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693252892; bh=Oreco0LF0y2+87Gi8hDvxZqi5x4vlnmmNzHzWTtMaek=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=dBTB/CLtUy49MZPHyuldYYqx/hYG9xd3TMA22ZktcvsOWgxHo70NhORZDomVPSHETak2FQvhZxiLWxFRLi/bw6uhE8/savxmKtOQGOwkfZTF7URaGZXFZJvKdKbCEZpIPCgT6wJ545YD1i4shcz7x9cvxsWQkzzKGLYhe4vDXwQmROLsK8cglnnO0XKdbitJTO0UWxZSdEBLulgXPWF40t843dOh44+YujwiKqlP8Ua+U68VJ/nzqixiVzkgn0QzKPF7hcVkt//lb094m1xfW2o/AMQN9OU8BTqhIRaMODAKIujyTeeZ+gDxRidtXKWOLIvPt5J5aGriHbvt37SG2A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693252892; bh=iyAsjsOIrbpE4SvFgYmsEIT6JPJ1UE0as1WRa/anQ5A=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=eO2CzBQLew+dGZApdgXm5UL4lT/EmRnrdaFaoRmFh1n4XTHLjMLh8JJPYceQ454N03p1pOnioQ20sACPNNLn/l8dPzVzjKp0IgUzbVyR6Ze9yoz3F+I7usswa9qYM+RwakJ7lvwKYhubgxKTR+GsjmVhmyVTs4shnbfqG0puy+wT6SkVQleUhUh7GFpoTsZLMsfs62NRzsabAu7LlumsR588mu+4Et4Wz01JWPLHtanbnHwbHkPH6RSNGKmuDAoZZLHlb7SNQZvOGiIGKp013OEXNiX1RdFEid4BrtGgmqTC3fpDEJAXwet62BOyNbfarPSXuYL5Z6kN+nrCis7F+g==
X-YMail-OSG: 6v1rDR0VM1kHQBCEKuNQaUyxk7csQYN8b9Iy7DO2BlS.iLGR_AQepzJ.JGyouha
 FbbjHJndIWtrSh7hqUQKCouXljQvSjFTDL9LEMEXdocRCEnfXKeQLcgNWdrs3fWI_ETwvdS_OmDi
 XrG_agQOio49eKfYM36T9Cpjd14qw.wBQZgVmDVyIulekE7ZA4Sn0W1XC0eIaqECbyzI_8GynIBf
 9zDGGqE_Mc6BaAbfwG8pQVNkjOTqZUozfAnBX94M70WpvpitUAbITcy8oH_rTKhchgyq8CxR83An
 jT9WjAXUzoopDBBrrmVO2EVY89fU9Nnven7KaSCD4L3Hq.oRyupSy6rtZfJnxM7SLdQRGaAKQNyt
 qKJazDouPC.gAly6lpm6silgO6ZLiIuPJ6uWib3yO_ueD1O8.WyM0VjicfXYb1oGRPtez7.09cYc
 ShBLiP1nm_WAZfSFmo5Vo2aHKK6urMIG0z0ILN4VeGAUYV.gzS9UztuHWg0cJNCczMlPwwV6Bg4.
 SYE49.sAh47Hwnuiai4mXeKEgd67kQRuhrCAeiWeWZfMWza3FbNtJx7PuJR8cuSP5NBo6ZAoWPGy
 1fdeWBvb98D0_7NVYqqx2VkUBjIxxCEdMDb5_jhT.8Nw4pxcKNpyxqYi9KOWOdHQwfAbS4WuygUV
 3FQFcSusP98IKFGRKP2kAomAO53ENaE6A8Z94W_6Ro9C5F24h1xLylOfiXz3.Ba0PHCiPGuvoXCL
 nCI4R7zY5tsiLpvCmW53rj7oAXFgm2vZhZjgrQX2V2YzsWANChKoTm8rO1yU_zdabWrwjwELPnEL
 gHI_WWYrqOCNSN8hx2IoNoiEmX8IO4aiC2uifBuFOP80l2izdA6my_F4ELEC.b9o9SBppJy50S7o
 s31byNdbiGLBAL.7vAnHZx_S9ujTmQNvrNQ7G36V.UKfnrxDZTxhyfSN.Kgv6u6RV4FgeVn88sK5
 0yOVZqkjfO1Zc7N1igLFnvfBG25EOiS5s0TgOS.rvDEY6pjuZhbFT2cjfvyD95Sy2az3apXGQAl7
 5JyGawCufiqyeMIFl_fkC40E6CV4qeo9u.NEyHU5R8Gi2.Pz4vtpL_2mCxCmk2HKFvppM4Lf67zv
 7aVIILhyEs8yGOoHdu0V2yovqfWjFkXH9mDOAERGgleZTpENt1NirswYFzufqCezVLZ_kek04y3x
 VdRtOlsAhR5REkv6WZG9nW98GuSWgEleSW5RJzBamMweksrTJxwcULCT_wJg.1KOu5wkSYwR99Wa
 THBQ6U_V1sfTed1PBJybh6r_aSImmEdT04LvyMH94kAPxlTYOuTvlpNbQAGN9OSOWrkgACU_kcci
 j6o_POGYHZkGgFXe6j.S4q3pYN5JsmTJYLvC7Y3IFBUujC_ELR0ZpLesnpZ.ZBREvcnuHa0s3rr8
 SWhgQn46JYyxasB.u89sY2aFjH16aZNK0SExtNMbNvEqjYv.VO_XjYN8qJWRy3vnxtiVhhdl9Fgm
 o4F_zmT7k_lKCMymC5fSQu.7UscbH_FHnvW0hI65HFy1vvVfXWw_w1l.HBuxej7FuHnCkxTuDZz0
 KrpLmOPp7RBSms97ZmTC3hbSlpNkE88muWh4DjKYXobkWW5rAv7eVmuoRLZCjj10iLaPHOnLeUCM
 280nuNRplV4CsB94MLnYfaNTeNax.8mlcxps4IezAm0wG7qmPChH_deOQLHqJiySaApTCsiMn0lj
 FIY2FuaeRib8hgeDYfru6FEaBqjcYA3uq3lS.7Heof5NfDLkOwn5NJugXRbnZSDw9AnebVb3RMpB
 Qw3mKK9WhT5EyiNXWx1cCNFIpg2rLgMG8flyyW3LKODYym9g4jnyLe3IAAotxeYmStKNrYJeaLmh
 zffnBiVRyQcj0CiXTC49TjdHIZoj4nonUFiqCYFtmxVhGdpCEKsprW22XmBB6Oy3G63Pd2SdqClE
 PDaCHgilYWB3d3x1jL8j2ORaqVHtroJFbRiAuf1khDCfLSdFKpRtsuftw2I23pORlDfTwL_UCcxn
 y8704L55UKW4hApJ1wZ6599iaUF25dC5aPVL0SbeeeJtH01pOB74S7CdUpz5n3tRaZTPIdPjCg.4
 YToZOBSZdpW4NpzU.1pAUF3jyAlqoVK2pPanaPtIhzjcobfMa3FMlez3B_nqoqTOzyyNXxQ6Dp6R
 lTdaKdFH_3lo1N7Ta84zpi7fo6bJJAGa1jnLd7oBqwl6puTQw.f1pCDmqAr7MvyUQipPjv3xvuj.
 FWBeQCcqRTfrxmBh91QhwRQ6Bzmm3vifvt7b8xg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: dfd8f45e-a7b8-4b6e-bbc7-5da8826f8a30
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Mon, 28 Aug 2023 20:01:32 +0000
Received: by hermes--production-bf1-865889d799-xc84r (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 41e108e68e35436397144cebae3e0d39;
          Mon, 28 Aug 2023 20:01:28 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v14 07/11] LSM: Helpers for attribute names and filling lsm_ctx
Date:   Mon, 28 Aug 2023 12:57:57 -0700
Message-ID: <20230828195802.135055-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828195802.135055-1-casey@schaufler-ca.com>
References: <20230828195802.135055-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add lsm_name_to_attr(), which translates a text string to a
LSM_ATTR value if one is available.

Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
the trailing attribute value.

Both are used in module specific components of LSM system calls.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
 include/linux/security.h | 14 ++++++++++++++
 security/lsm_syscalls.c  | 24 +++++++++++++++++++++++
 security/security.c      | 41 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 0d882cb221f4..817cf28dbf8a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -32,6 +32,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/sockptr.h>
+#include <uapi/linux/lsm.h>
 
 struct linux_binprm;
 struct cred;
@@ -263,6 +264,7 @@ int unregister_blocking_lsm_notifier(struct notifier_block *nb);
 /* prototypes */
 extern int security_init(void);
 extern int early_security_init(void);
+extern u64 lsm_name_to_attr(const char *name);
 
 /* Security operations */
 int security_binder_set_context_mgr(const struct cred *mgr);
@@ -488,6 +490,8 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 int security_locked_down(enum lockdown_reason what);
+int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
+		      size_t context_size, u64 id, u64 flags);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -505,6 +509,11 @@ static inline  int unregister_blocking_lsm_notifier(struct notifier_block *nb)
 	return 0;
 }
 
+static inline u64 lsm_name_to_attr(const char *name)
+{
+	return LSM_ATTR_UNDEF;
+}
+
 static inline void security_free_mnt_opts(void **mnt_opts)
 {
 }
@@ -1408,6 +1417,11 @@ static inline int security_locked_down(enum lockdown_reason what)
 {
 	return 0;
 }
+static inline int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
+				    size_t context_size, u64 id, u64 flags)
+{
+	return -EOPNOTSUPP;
+}
 #endif	/* CONFIG_SECURITY */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index 329aaca5efc0..5d391b1f7e69 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -17,6 +17,30 @@
 #include <linux/lsm_hooks.h>
 #include <uapi/linux/lsm.h>
 
+/**
+ * lsm_name_to_attr - map an LSM attribute name to its ID
+ * @name: name of the attribute
+ *
+ * Returns the LSM attribute value associated with @name, or 0 if
+ * there is no mapping.
+ */
+u64 lsm_name_to_attr(const char *name)
+{
+	if (!strcmp(name, "current"))
+		return LSM_ATTR_CURRENT;
+	if (!strcmp(name, "exec"))
+		return LSM_ATTR_EXEC;
+	if (!strcmp(name, "fscreate"))
+		return LSM_ATTR_FSCREATE;
+	if (!strcmp(name, "keycreate"))
+		return LSM_ATTR_KEYCREATE;
+	if (!strcmp(name, "prev"))
+		return LSM_ATTR_PREV;
+	if (!strcmp(name, "sockcreate"))
+		return LSM_ATTR_SOCKCREATE;
+	return LSM_ATTR_UNDEF;
+}
+
 /**
  * sys_lsm_set_self_attr - Set current task's security module attribute
  * @attr: which attribute to set
diff --git a/security/security.c b/security/security.c
index aa4ade1f71b9..1cd3123a18f8 100644
--- a/security/security.c
+++ b/security/security.c
@@ -770,6 +770,47 @@ static int lsm_superblock_alloc(struct super_block *sb)
 	return 0;
 }
 
+/**
+ * lsm_fill_user_ctx - Fill a user space lsm_ctx structure
+ * @ctx: an LSM context to be filled
+ * @context: the new context value
+ * @context_size: the size of the new context value
+ * @id: LSM id
+ * @flags: LSM defined flags
+ *
+ * Fill all of the fields in a user space lsm_ctx structure.
+ * Caller is assumed to have verified that @ctx has enough space
+ * for @context.
+ *
+ * Returns 0 on success, -EFAULT on a copyout error, -ENOMEM
+ * if memory can't be allocated.
+ */
+int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
+		      size_t context_size, u64 id, u64 flags)
+{
+	struct lsm_ctx *lctx;
+	size_t locallen = struct_size(lctx, ctx, context_size);
+	int rc = 0;
+
+	lctx = kzalloc(locallen, GFP_KERNEL);
+	if (lctx == NULL)
+		return -ENOMEM;
+
+	lctx->id = id;
+	lctx->flags = flags;
+	lctx->ctx_len = context_size;
+	lctx->len = locallen;
+
+	memcpy(lctx->ctx, context, context_size);
+
+	if (copy_to_user(ctx, lctx, locallen))
+		rc = -EFAULT;
+
+	kfree(lctx);
+
+	return rc;
+}
+
 /*
  * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
  * can be accessed with:
-- 
2.41.0

