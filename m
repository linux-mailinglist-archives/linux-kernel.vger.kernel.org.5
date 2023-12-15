Return-Path: <linux-kernel+bounces-1766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 390678153B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F9C1F25E8E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9535818EC4;
	Fri, 15 Dec 2023 22:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VOH94/AM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1394C2CA2
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679657; bh=Cj3o8DDeOO3mB2stYC+RNoE7w+k7QDtNzeFRm8yCL30=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=VOH94/AMCtT3XLQN3JbYEDaP9EXBH4lav/Z/S7RpX/AM8dUHG1/Pzl70sGxr1cy5JVjvBDwIK9kygK902MJKPQ4LcDufULNxVQpudI8S1nEVNQJjKPf5IL1BsDRMTVtE06zVRf4+EV0QtUe7utm9TusNBjJCubAHLlQ6b4/Hr78z37n4q5Gsjv6QHr2IME2JoVK+m7TVk/UXVi/VNTimSy4Y8fTHlhd6SwFdOXzdqKHuF/UL3R5rccOe6FHnBPpCwf+R3Yk27AI0wYKT7mqdka7hUBCZYn7xdo0bg+IeNW/pWB1BKR4CYBjf++ifRRfHaSEvO8Lmt5MzTb82VpO+DQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679657; bh=9V75+0NTxvTdqySoNPi8lLXqS5Hh71vBXC/3KK7dvpn=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=RVCLtmbKc87y0mj7uQEh3NTyd5tN51nvRSl8e9nq4HJep6NpctacJUQ5NfhwXsE2t9PFu+BmQW/Jij4iIVCLwSHaGPRX0fFOFzkgCc/7uvh7/WCOLXxhJaPukCl4q6IcyN6EYLY7JQDFyJvTIzFoKYWLjWR1PbmarZrRpxFhpFaNXOFoL6Gt4vdVLf2WacU4UW2KTQ/pHsOc/27nocz2g6v7mUgxhT7x5iP6Mj8Pb04IoHYRnCk+0Y/L+kY26Kl11bFyRSaWG6XrmUzHhNDWp5Y16EMYC8D/Xxzcg4lOrCAcH1l5yc5v6wWSE5c7JvQj7euaLbm2b86UqYGP/wUVeQ==
X-YMail-OSG: IpwwlcAVM1nFyIeUx.iyrETs0wI1G3Hy1EN47o8f5N64TEMEzyzJb9EH51zNjlI
 qoBc1RfKL4.e0zXPZST6UnAJMxOZEOAQEyatgOwDijn_7dGDFUJCbBPBiHhcCsOyj9pllTM4e2hI
 Yw6kj8RZWjqxdk75sIcQoYTqbmupi9bTGTrARIreTlC54nbPa_vmQHNwwHHpTmmb7k20N7tmMTo9
 q.i1CB5.CQ82smY3yu0PFqM3v6jJLqE6JaS0aJ1LU3Orcf0SY44DuqKyTbshY_c4nIlR.KGuma48
 9iszMEYGDTZ47OPtRrMtb2q11TSPWREV4kBd8bL2VsxQfI7H9kT92J8UvOpoIiFaesyB_9ci2Nq9
 CoY24_SqAyVt6crxEQvL4EYREIJ.7iaM6VIQzhVDSGU5U9i7yw6tZZLt4A1XBZXjigLVpYNNt_Bt
 QCWf2nAbBHgLx9lMZPqsbLSA4mz71ac0zwzinjsqC_l25WTg0pkrnNovR2ROyr14ekKNw73qLmWf
 NKNshHl9V_s0yejFkQtkUfv6fa5UiIG.qMad.AKYwEoRnJt1NOjuLmWBxoaoU_Xn_g.trwku3D4x
 _2PCdRmqP9awKqDhoxVgNOi9BljuYRmMl3y.5.qIhN7zjECxCg61EuBTjg1QhkOgzdKE.lV6Ml9S
 GqANN.9_tJdAdt25frtNcRZ2Pw2SeqI6_wpLvUbTB4dZoihtpcTVZg.Ue5N1pjcTyrn9oM94rqJ5
 zT0QACgs2hnWLwjOzms3mWV3zDefJ2cXtP351VvDqkCFysq7PmgzUMp6ZcUoNE7aNcPsPcVT7vcK
 2Kf0wchKI8lFHLo76.110d6ImFk1rDHgi0Co618JcO4iYKEXUMLADoz1SGbWs6k1S4eGVlaYCAVN
 WIj0i6JDqlMUdUxUMSB1gW9wEIewv0hgGEgs9.TOi.E6G9v84WXP5TR4rP0MjMMz7E4KBGmgngba
 KAGCazWvYfzacKHeXr2QWXQ9dclVR0XXxz4FzaOs1wTm3xWB.2E5ga_7SwXVm4LlawgLknmC2ZEQ
 4KZd9wVWxlsOGWnxc25eVbcBABsMFj9hPcDA5J43t2b1Ws75uWbMT2b7jt_7Bfqf3DAtmYBqU4B_
 jKodmrhcx57PeLKukaZbiRl3BMZbCByuoIGyAfSQktifD5V3s1JykIQBN8tLpH2TzY5UE8l1wOp7
 kjpz4sxY.Fl5ppXmyeRt6SAnD0ATNGqu5kNcZ0Z4JWQOgkAIFYT.DnfU6OFMb2aQ07Fay9u7fSIo
 5cSLcEMOR.vG8xsOTUZ4bIj.sIe7DFep5IFkEJMGPqFz7PjujlD6Mi_laQ12hR6iEEVxKQcp.nXc
 SoXdrz9ZKcHTQkGogfKT6aAC.DqeI.xRn7f0jnVG5u7ZVSn2EgqfI.qzSiiIS0W16B_psTUaMrjs
 o01yG3WlNiR0_Pt8s6xjPbcfH4TxBKED3iWxLSUf4T8d5lLJ.j5XYZVRb2XD8W3iWO8qvNnJEEQD
 Mfc8qrS0eLqKdXKOlmwS8E8EPu5gcURRBzjkhYXTnQwG5Lt7CaXWL4gTGn.HD4gvQ0MoVcmxIln.
 kpI0nyZfByL5kzf0JnreE99VZ8of7GUt4GpzvUk471udt1arA3ng7rx1tH5Z.tWvv6xE6A5Wa.nv
 wGAUTFUjhHRtrzQxpahhWb4bbfH4kZRveipKoPUM3QbLkX4QBeKl1BDtc_L0qEdYIYxYPiYR4qjp
 rPjCTefDGGmZJAn6UXgC4fhodjJfn4MI4dfENgic9EV6paZFdv0lbxYKU7mQBLtVK61wiyfsrE14
 mcxFDUjbRN4pZdftkeP5fw1B26e6Yqq02duHE..5k44EYKKlvvJT25YVRzmVHuErn1.oGamBJQoG
 XGnpSixfd7oQL8pAg4EljH1wXa6nVQwqY_LQX8g5izNX1O1pJW3jHenztTwTNmG3sSPps77o4xSh
 PBqqkqvFqgfg94.NzDAiuvcNQCQ3i9EH3w3RkE46pAL8.Grzduj01Gs5AqPi5pgsxRrsbseZYqv9
 U9aF8VeoVWcr68DjaKAGPwxvEv_bVym14zwZ.MwmgneB2A1mVHo2LISmUTGs.2SiJvDQ7oEu_alZ
 e_WmV2f2mDA_fXkGLFI95.Igp4InJd.Li6JBuBhZsbAlN_DI0IOEZwa5U3Ba6Z9otnWrBVrKmTgu
 ajPlNr7Dq_qdNtICzkCt6EBDfA1EsLx8YbdqZ4REkHLUFbt6ivUNXWh3MBECyYZcZQZtab.6jTee
 fjlIeJFg_qEud3fxVeaxm7SP_PCOkL23yJ3xQ0XVVcWbu4tyYgEH7orVeTNg_ctSAxV3A781Uc0O
 0K1pxPHbvpfbq0prxcBpvdkKHYOBW_g--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 649d807f-2ba2-4b35-9a62-bb24e6295b3c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:34:17 +0000
Received: by hermes--production-gq1-6949d6d8f9-dpfkp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0a4ea853851f0b1cf5e01328013d4c00;
          Fri, 15 Dec 2023 22:34:11 +0000 (UTC)
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
Subject: [PATCH v39 23/42] Audit: Allow multiple records in an audit_buffer
Date: Fri, 15 Dec 2023 14:16:17 -0800
Message-ID: <20231215221636.105680-24-casey@schaufler-ca.com>
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

Replace the single skb pointer in an audit_buffer with
a list of skb pointers. Add the audit_stamp information
to the audit_buffer as there's no guarantee that there
will be an audit_context containing the stamp associated
with the event. At audit_log_end() time create auxiliary
records (none are currently defined) as have been added
to the list. Functions are created to manage the skb list
in the audit_buffer.

Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/audit.c | 111 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 89 insertions(+), 22 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 5291f65a01c8..b194494c4dc4 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -195,8 +195,10 @@ static struct audit_ctl_mutex {
  * to place it on a transmit queue.  Multiple audit_buffers can be in
  * use simultaneously. */
 struct audit_buffer {
-	struct sk_buff       *skb;	/* formatted skb ready to send */
+	struct sk_buff       *skb;	/* the skb for audit_log functions */
+	struct sk_buff_head  skb_list;	/* formatted skbs, ready to send */
 	struct audit_context *ctx;	/* NULL or associated context */
+	struct audit_stamp   stamp;	/* audit stamp for these records */
 	gfp_t		     gfp_mask;
 };
 
@@ -1763,10 +1765,13 @@ __setup("audit_backlog_limit=", audit_backlog_limit_set);
 
 static void audit_buffer_free(struct audit_buffer *ab)
 {
+	struct sk_buff *skb;
+
 	if (!ab)
 		return;
 
-	kfree_skb(ab->skb);
+	while ((skb = skb_dequeue(&ab->skb_list)))
+		kfree_skb(skb);
 	kmem_cache_free(audit_buffer_cache, ab);
 }
 
@@ -1782,6 +1787,10 @@ static struct audit_buffer *audit_buffer_alloc(struct audit_context *ctx,
 	ab->skb = nlmsg_new(AUDIT_BUFSIZ, gfp_mask);
 	if (!ab->skb)
 		goto err;
+
+	skb_queue_head_init(&ab->skb_list);
+	skb_queue_tail(&ab->skb_list, ab->skb);
+
 	if (!nlmsg_put(ab->skb, 0, 0, type, 0, 0))
 		goto err;
 
@@ -1847,7 +1856,6 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 				     int type)
 {
 	struct audit_buffer *ab;
-	struct audit_stamp stamp;
 
 	if (audit_initialized != AUDIT_INITIALIZED)
 		return NULL;
@@ -1902,14 +1910,14 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 		return NULL;
 	}
 
-	audit_get_stamp(ab->ctx, &stamp);
+	audit_get_stamp(ab->ctx, &ab->stamp);
 	/* cancel dummy context to enable supporting records */
 	if (ctx)
 		ctx->dummy = 0;
 	audit_log_format(ab, "audit(%llu.%03lu:%u): ",
-			 (unsigned long long)stamp.ctime.tv_sec,
-			 stamp.ctime.tv_nsec/1000000,
-			 stamp.serial);
+			 (unsigned long long)ab->stamp.ctime.tv_sec,
+			 ab->stamp.ctime.tv_nsec/1000000,
+			 ab->stamp.serial);
 
 	return ab;
 }
@@ -2165,6 +2173,57 @@ void audit_log_key(struct audit_buffer *ab, char *key)
 		audit_log_format(ab, "(null)");
 }
 
+/**
+ * audit_buffer_aux_new - Add an aux record buffer to the skb list
+ * @ab: audit_buffer
+ * @type: message type
+ *
+ * Aux records are allocated and added to the skb list of
+ * the "main" record. The ab->skb is reset to point to the
+ * aux record on its creation. When the aux record in complete
+ * ab->skb has to be reset to point to the "main" record.
+ * This allows the audit_log_ functions to be ignorant of
+ * which kind of record it is logging to. It also avoids adding
+ * special data for aux records.
+ *
+ * On success ab->skb will point to the new aux record.
+ * Returns 0 on success, -ENOMEM should allocation fail.
+ */
+static int audit_buffer_aux_new(struct audit_buffer *ab, int type)
+{
+	WARN_ON(ab->skb != skb_peek(&ab->skb_list));
+
+	ab->skb = nlmsg_new(AUDIT_BUFSIZ, ab->gfp_mask);
+	if (!ab->skb)
+		goto err;
+	if (!nlmsg_put(ab->skb, 0, 0, type, 0, 0))
+		goto err;
+	skb_queue_tail(&ab->skb_list, ab->skb);
+
+	audit_log_format(ab, "audit(%llu.%03lu:%u): ",
+			 (unsigned long long)ab->stamp.ctime.tv_sec,
+			 ab->stamp.ctime.tv_nsec/1000000,
+			 ab->stamp.serial);
+
+	return 0;
+
+err:
+	kfree_skb(ab->skb);
+	ab->skb = skb_peek(&ab->skb_list);
+	return -ENOMEM;
+}
+
+/**
+ * audit_buffer_aux_end - Switch back to the "main" record from an aux record
+ * @ab: audit_buffer
+ *
+ * Restores the "main" audit record to ab->skb.
+ */
+static void audit_buffer_aux_end(struct audit_buffer *ab)
+{
+	ab->skb = skb_peek(&ab->skb_list);
+}
+
 int audit_log_task_context(struct audit_buffer *ab)
 {
 	struct lsmcontext ctx;
@@ -2399,26 +2458,14 @@ int audit_signal_info(int sig, struct task_struct *t)
 }
 
 /**
- * audit_log_end - end one audit record
- * @ab: the audit_buffer
- *
- * We can not do a netlink send inside an irq context because it blocks (last
- * arg, flags, is not set to MSG_DONTWAIT), so the audit buffer is placed on a
- * queue and a kthread is scheduled to remove them from the queue outside the
- * irq context.  May be called in any context.
+ * __audit_log_end - enqueue one audit record
+ * @skb: the buffer to send
  */
-void audit_log_end(struct audit_buffer *ab)
+static void __audit_log_end(struct sk_buff *skb)
 {
-	struct sk_buff *skb;
 	struct nlmsghdr *nlh;
 
-	if (!ab)
-		return;
-
 	if (audit_rate_check()) {
-		skb = ab->skb;
-		ab->skb = NULL;
-
 		/* setup the netlink header, see the comments in
 		 * kauditd_send_multicast_skb() for length quirks */
 		nlh = nlmsg_hdr(skb);
@@ -2429,6 +2476,26 @@ void audit_log_end(struct audit_buffer *ab)
 		wake_up_interruptible(&kauditd_wait);
 	} else
 		audit_log_lost("rate limit exceeded");
+}
+
+/**
+ * audit_log_end - end one audit record
+ * @ab: the audit_buffer
+ *
+ * We can not do a netlink send inside an irq context because it blocks (last
+ * arg, flags, is not set to MSG_DONTWAIT), so the audit buffer is placed on a
+ * queue and a kthread is scheduled to remove them from the queue outside the
+ * irq context.  May be called in any context.
+ */
+void audit_log_end(struct audit_buffer *ab)
+{
+	struct sk_buff *skb;
+
+	if (!ab)
+		return;
+
+	while ((skb = skb_dequeue(&ab->skb_list)))
+		__audit_log_end(skb);
 
 	audit_buffer_free(ab);
 }
-- 
2.41.0


