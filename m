Return-Path: <linux-kernel+bounces-1765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F618153B6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92DB1C24670
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8505818027;
	Fri, 15 Dec 2023 22:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kkik3eSC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D8413B14D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679655; bh=mM0WZyCz/tlNmJgaPwRTDUjkjMqKhKg8VZllCO0EmTg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=kkik3eSCu8YpbDnaARezAwEWl7snnrGP4kDaWewhitXWdeRsofIWdyENtVBbUS4BIu0lJUZT5Z6kzZBOfDvolBRM6dnJ1KXVzplUNZa8A89vm0Esw2TwdbZqV6esCn4yH7y8/hxGkcYMg7DVB0K/VBV8G9qyONmMjQQxCD4Rk8hZl6BQ/zcp+eTR+Jw9jaOpcFaQOo6Jd9GjTOUMcKf3485JxlFUXpzb+bWQBLl/PiCeajjS7nzl1akVvbdfe3YhfyRJjQ2mfMArZRO4wFBqs5vC1L0C8VZyHJSdz6FmX0DyC1AlflNaBmNvayOHhv/1T8SjWULJwKAsctUckYu8Og==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679655; bh=FAxExbaql8jFIp3VAoQmKNgDIKq+qzvGc5Ayk/CpIzN=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=quhmEjbY0r3/bnqNHDATa5W9SG/kDVAwrxT3KW8iWJA3mo2xMOtErj+y+VEFZ9tvj0RHd0T3kPoSMeQDlWf4b705o4ufgFTLfp5ArQsmcB+BCYrA+c7tlFCdZk/LCotx05Wv3bTUrzKHqf/ZyCTRwbNuOoE/EYwox7r5CEFc3rPJJTUHv1pifLqz6B7IXv71p4BIpnNJ6gH32iGaU49IMJZh6PDaAHTeujNBVW1HMOi6w8mhdbiHi74L9GeQ2CQCgWuuIhAw02zc/XnMI6SOqzYaoASc7/de4NCQRjRKVXycZWZfJs3uGGT4IQ9nwEz/iFRDqCsqk3zfaBNO2ehWaA==
X-YMail-OSG: sxegZS4VM1k15GHIGmAaacxqx.3QE2n8uqa0ajCnfWujfk7IzkatndBN8Z29DyU
 COw7esx.JSHVN54WHazV99Ak7AAlDrKXjhHt0mDij9arGgTBNgkp4kENjFPelvRWycfL3tMlKu5X
 f9QFuxmRCCibmN3RepR.wzWy6YgQjYTV8p9lh42CZZhb9QsGC5N7O9iSt1LV8RgY2zyUI.8pM.yT
 tkfc_MgaRORQQYVwRNShdDLKxw8Jqzofbrdon9FfEZKjI4_49YDJcp1fJmOycnsMLITO5o4g0aRQ
 RF4CJm.PsT7uyb9QGqtK2oSBC8G0_vZL9REMu_9SrP6MyoSMs9rRLshk33Ia24j3n5duWke_Nt5C
 IP7xKyTpMurmLg5kizTE.gdP0iu_dNPnsv0tGL2WsiNNt3fLQE8mAtGPhcaJApZSZmBs32mCEQ1z
 7nlR9uxNNj6iiCNRrp6cdz.WgsPGx7wJlkeQDq1qm3TLw5mo6HaOFYWI6cNhoyconSnlCpuUTpM2
 gJ0V1KES1iuNGRayYDM3CgGSywMIx3G1JlCTUpIG8l8pRdTKayC0cIxtpFGVw8_5PEwSGL7OWkSP
 F3vWPrAK7L5z12x7L2ql25vm8lKvBmzLYvAl1McWpurTcbqkE98EhSz_ynyUJjMyDea39Ec1QTWo
 KHTuc3umJ6jSiILxB.zS5fKfhFcgj39k1_59zHwGeDYtHuM0FHujbdP_7gMyI1w0Gw9_JrEjJ_lK
 _V1Q78kN8yrHu.qbCgGEHsZI3j6LMx1A8_wSdMP_egG5vM7Q2Ak5brOO0lQaAw_8ZdCxvA7fkugP
 exZLv.mZHKyswtvwaAoj4PVftpul5Pzo1GkBmWXx2m35CHXjeHFQ_NL5S3Z1mxynBRXCe9lJNcT5
 DsKKsDM_6HhYJxPQz5H8lhezxFsVrfdxE9KeyzsqcYbBDVzrmcQxvwufQiBz_y6FS8e71iZam7fL
 uY77Mr.P4XVyur_MOwlMt87oTe0VW3M5AKR_bZ4dq62WJ0nAz.FesGgSqMBHYd55t9F2VYdadgqf
 hXsNks45OTlbuLGANcxGouw5IvHnfyHzwev2uhCPFU8P.5oyGbhe_bpPxXzyAqVjqm2HA_oyA.di
 tE8LaDZ7FBrOT56tNEj7Fq_oLe8dYbhtIhUAtllHeT9sue8SgDivsk06qtpmZ_IuXD7pocCX_vTw
 WOvZ6Gqc70buLTB7sfERNVIc0VuxlIpVnIHx6Wq67MRILLH51yggt3SETzTUyPA24gRu9.j4rNW6
 f1we3bHR60Z0oRt48QlFsSyVIs2qPNkd36Qoj8jb8gZUEyQedIGaduJDjxiNbpZsFtn9jCUhB6ww
 DuJIOwVZei0LV4cyJt5A2.xrc_rheG4pzTDkIWfbpTvKLVl5SGBzbD7lBXw.7RAYNWM_QFf5asoa
 5yylpZ6nfTuPrqcnbf7NGyGB4VT8Szf3wBcFJmZ30d7uNOR13QMuJDZ7BYr5Wp7D9gU9uMNPF0KX
 8tvOcGgmAg2KbHlnV2XQ90nTSztYPS._K5wCff6wC.ACZ0dpTnPO4E_P5RK8XwVVam0Iyr3Aqmi.
 X_KGQOy45MunRxyRTEnzqsFrktBkt.shyw_mG4vU6kQWiX1pxKhq3anL89sunhxYWylODrlkCuNF
 5E9TqaTou9KIuTG.zQTmLCk6nwX6nJOTwsfxIJxr1sH74jUvbIFPXxiIRI7i6baCFDKQZD2AEep6
 2yhQNvHMYM8chbrDEpWyb2ok87hZ9at6UZwRGYt46ZwVGTFdH.55iD_wpYPxdbn6BDbbjRDhWGtB
 EEWUtjMOqtk3Kj4nzhAmWWbtLglOhm4DOgk8XTmCx7KiqU5F6sllo6uxJwPKMgHQ3Rxu3lVkpgLG
 HThBVtkL8XyIyKRiiopFwK2.rFvq_dnJiFAILf6iMgY3qsPf2GciUJt2kYm.2a2Ni9Iy58i8XIcF
 JCH6KcQCtG2axtWYnp.ZfTFe8izar5dHBvzmBexJN97ctKFYeP3bOICi9VQ5ANfNy85QKBfl7oD_
 8PKRSD_.QScGafu0kE3EsW1ec17tQpEIBuUuFC46lDP4zMJgfqX2PEutKz3FvvurV5HDUuKhNqE2
 BVzWEY0_sCZJ0wx.01djAXLo7wEh3BEulEUOI28X0x3RA8uJMN9mQ3Z99ybs11WTd_UhNDDM586k
 EEQ8rcitKvg9Z9SxasjCI5mOezjSCI3_kBK5db4Kv6Vem8WP4R0dldVTvQ0Nx.u1niIPcMUPyZkK
 gxlwa900JxnlnuTkmew0NsZZmi4WZrWPRsYk4_rA7izzWJLcw1bGGuRd33HaGyDhTTT8fiDasFZr
 6uWgYcbOGCiOZvNL6U.0nZIGqLWsn
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c1a56000-005b-4423-8689-f3e899d8bc69
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:34:15 +0000
Received: by hermes--production-gq1-6949d6d8f9-dpfkp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0a4ea853851f0b1cf5e01328013d4c00;
          Fri, 15 Dec 2023 22:34:10 +0000 (UTC)
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
Subject: [PATCH v39 22/42] Audit: Create audit_stamp structure
Date: Fri, 15 Dec 2023 14:16:16 -0800
Message-ID: <20231215221636.105680-23-casey@schaufler-ca.com>
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

Replace the timestamp and serial number pair used in audit records
with a structure containing the two elements.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Paul Moore <paul@paul-moore.com>
---
 kernel/audit.c   | 17 +++++++++--------
 kernel/audit.h   | 13 +++++++++----
 kernel/auditsc.c | 22 +++++++++-------------
 3 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index edefb370a72e..5291f65a01c8 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1820,11 +1820,11 @@ unsigned int audit_serial(void)
 }
 
 static inline void audit_get_stamp(struct audit_context *ctx,
-				   struct timespec64 *t, unsigned int *serial)
+				   struct audit_stamp *stamp)
 {
-	if (!ctx || !auditsc_get_stamp(ctx, t, serial)) {
-		ktime_get_coarse_real_ts64(t);
-		*serial = audit_serial();
+	if (!ctx || !auditsc_get_stamp(ctx, stamp)) {
+		ktime_get_coarse_real_ts64(&stamp->ctime);
+		stamp->serial = audit_serial();
 	}
 }
 
@@ -1847,8 +1847,7 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 				     int type)
 {
 	struct audit_buffer *ab;
-	struct timespec64 t;
-	unsigned int serial;
+	struct audit_stamp stamp;
 
 	if (audit_initialized != AUDIT_INITIALIZED)
 		return NULL;
@@ -1903,12 +1902,14 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 		return NULL;
 	}
 
-	audit_get_stamp(ab->ctx, &t, &serial);
+	audit_get_stamp(ab->ctx, &stamp);
 	/* cancel dummy context to enable supporting records */
 	if (ctx)
 		ctx->dummy = 0;
 	audit_log_format(ab, "audit(%llu.%03lu:%u): ",
-			 (unsigned long long)t.tv_sec, t.tv_nsec/1000000, serial);
+			 (unsigned long long)stamp.ctime.tv_sec,
+			 stamp.ctime.tv_nsec/1000000,
+			 stamp.serial);
 
 	return ab;
 }
diff --git a/kernel/audit.h b/kernel/audit.h
index b413c0420c6f..f147540862c7 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -99,6 +99,12 @@ struct audit_proctitle {
 	char	*value;	/* the cmdline field */
 };
 
+/* A timestamp/serial pair to identify an event */
+struct audit_stamp {
+	struct timespec64	ctime;	/* time of syscall entry */
+	unsigned int		serial;	/* serial number for record */
+};
+
 /* The per-task audit context. */
 struct audit_context {
 	int		    dummy;	/* must be the first element */
@@ -108,10 +114,9 @@ struct audit_context {
 		AUDIT_CTX_URING,	/* in use by io_uring */
 	} context;
 	enum audit_state    state, current_state;
-	unsigned int	    serial;     /* serial number for record */
+	struct audit_stamp  stamp;	/* event identifier */
 	int		    major;      /* syscall number */
 	int		    uring_op;   /* uring operation */
-	struct timespec64   ctime;      /* time of syscall entry */
 	unsigned long	    argv[4];    /* syscall arguments */
 	long		    return_code;/* syscall return code */
 	u64		    prio;
@@ -263,7 +268,7 @@ extern void audit_put_tty(struct tty_struct *tty);
 extern unsigned int audit_serial(void);
 #ifdef CONFIG_AUDITSYSCALL
 extern int auditsc_get_stamp(struct audit_context *ctx,
-			      struct timespec64 *t, unsigned int *serial);
+			     struct audit_stamp *stamp);
 
 extern void audit_put_watch(struct audit_watch *watch);
 extern void audit_get_watch(struct audit_watch *watch);
@@ -304,7 +309,7 @@ extern void audit_filter_inodes(struct task_struct *tsk,
 				struct audit_context *ctx);
 extern struct list_head *audit_killed_trees(void);
 #else /* CONFIG_AUDITSYSCALL */
-#define auditsc_get_stamp(c, t, s) 0
+#define auditsc_get_stamp(c, s) 0
 #define audit_put_watch(w) do { } while (0)
 #define audit_get_watch(w) do { } while (0)
 #define audit_to_watch(k, p, l, o) (-EINVAL)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 3c0559b01677..23f72c14276d 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -994,10 +994,10 @@ static void audit_reset_context(struct audit_context *ctx)
 	 */
 
 	ctx->current_state = ctx->state;
-	ctx->serial = 0;
+	ctx->stamp.serial = 0;
 	ctx->major = 0;
 	ctx->uring_op = 0;
-	ctx->ctime = (struct timespec64){ .tv_sec = 0, .tv_nsec = 0 };
+	ctx->stamp.ctime = (struct timespec64){ .tv_sec = 0, .tv_nsec = 0 };
 	memset(ctx->argv, 0, sizeof(ctx->argv));
 	ctx->return_code = 0;
 	ctx->prio = (ctx->state == AUDIT_STATE_RECORD ? ~0ULL : 0);
@@ -1918,7 +1918,7 @@ void __audit_uring_entry(u8 op)
 
 	ctx->context = AUDIT_CTX_URING;
 	ctx->current_state = ctx->state;
-	ktime_get_coarse_real_ts64(&ctx->ctime);
+	ktime_get_coarse_real_ts64(&ctx->stamp.ctime);
 }
 
 /**
@@ -2040,7 +2040,7 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
 	context->argv[3]    = a4;
 	context->context = AUDIT_CTX_SYSCALL;
 	context->current_state  = state;
-	ktime_get_coarse_real_ts64(&context->ctime);
+	ktime_get_coarse_real_ts64(&context->stamp.ctime);
 }
 
 /**
@@ -2511,21 +2511,17 @@ EXPORT_SYMBOL_GPL(__audit_inode_child);
 /**
  * auditsc_get_stamp - get local copies of audit_context values
  * @ctx: audit_context for the task
- * @t: timespec64 to store time recorded in the audit_context
- * @serial: serial value that is recorded in the audit_context
+ * @stamp: timestamp to record
  *
  * Also sets the context as auditable.
  */
-int auditsc_get_stamp(struct audit_context *ctx,
-		       struct timespec64 *t, unsigned int *serial)
+int auditsc_get_stamp(struct audit_context *ctx, struct audit_stamp *stamp)
 {
 	if (ctx->context == AUDIT_CTX_UNUSED)
 		return 0;
-	if (!ctx->serial)
-		ctx->serial = audit_serial();
-	t->tv_sec  = ctx->ctime.tv_sec;
-	t->tv_nsec = ctx->ctime.tv_nsec;
-	*serial    = ctx->serial;
+	if (!ctx->stamp.serial)
+		ctx->stamp.serial = audit_serial();
+	*stamp = ctx->stamp;
 	if (!ctx->prio) {
 		ctx->prio = 1;
 		ctx->current_state = AUDIT_STATE_RECORD;
-- 
2.41.0


