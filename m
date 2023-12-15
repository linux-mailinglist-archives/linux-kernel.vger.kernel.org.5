Return-Path: <linux-kernel+bounces-1784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988338153E5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE8611C24754
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C96C19452;
	Fri, 15 Dec 2023 22:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Te5/75Ah"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5509718B06
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702680223; bh=OP/fe7KTWBlNrxCDPndD55sIV1PdVPH4756etwgkPBQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Te5/75Ah40FU7JV5zv4gA6YC/GtWU4lkiluweGh8clYFZtrSecHKgjyvJcnL2vUHmln8cpd1eBYM34ZXb59MyNxqxEmyTYETJkF2f5S4GBbS2MZKRvEVg2iTguKW8xcOO9W2vETPJP+rAQtEdR3F8NksGHm9KMjQVkuugnCdrrpUyfIBesDpVJnENqAqW5ebAmDt/cWlimu0gz/4fTSjnIJMxLV7vlhxm0gRFvj56NKNl8/2n4yikBUHyUXeIogyGVNvj7XwEs5m0djCVNQkPVk/mssQefrMVnDt+eP1WhfDPFG2VAoRGU+v/olcB3Ev/78CQP8IX13MHdffadM1sQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702680223; bh=7cFt1PnR65sziyB7/ELmNrG9oDxSfh9AtHlEi4CMFj3=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=XZkZ0BrR3fReGnMSvRUVFxa+FWXY1wSRN4ATIbczwhmoZznlZO5P+tbD+xrnDR8qQk7CSEKN3ALVI+ESoJGlSXwRvkL63qsQnRmi4tHO8+5Sjg8gqSv7OdkhDs26UntIJ1MZLmZLm9hMQuulpUpSJXebh7Kv5XDrGLD9gbkQjOA85wimp6X8ii9lRQsgobAQ8NiZMLWd6ijPIMneKIjNZ+8JCv5zQt+4SLDUI57Jgw+Ulr/YntJ19MVAsJAMXO2P7GmK09Sy2pYDI9nISVmuCEFs8+CR1ZxHtezdcMRxeZcHoe7Bh7ijj9S2tyq1WYdmENan70m67yEoQLGPvV1frw==
X-YMail-OSG: eciJ4hsVM1n5pF1jj95VYuHjVLjV.aaiZGxotjXzMoKI.BOXVgAVgqMmPG6tuq5
 oNHFI65wJIE59K.OLoIgW.9DdrNZjmQwKCHRSBWuDNVt6zecmseorjWPzmo5QXzdCOSBd9kfX8fG
 2L2_g97ZxZ8VsSO0WIRe8BdhtiUh1JP5GVeJLtW22MTCoNYIjnOuzrIyek5h.CcD9nPSpuba.ZA0
 eA7TTDsLlvWefCfvaLdvZUltxAFR_FVTbL0j0r_rd50OVSZCxqPJNShF8sSBqPO0x0FegF_u4jC4
 gtvy9SIduFMYwLmmHktPMaSeVtAYdLFEjCSQKB8Nq3NZjgvyi0F1P3Mij9u3VV9xqZSAnpR9mEqK
 XS8JUGWe70fphe6h1or6mJ660l2Lq4XaOAycECYj9Co3TXYA7UJ1zNgZm8xbPvQnqgCeb__a63MI
 LPiYdFKPbBChOTqALqaNQ28_ZwJQGApRiey9TDOTSI43wHbkogIhp8IEx.ntF7Oobtr.kkK1GO6V
 j46eO_AvuX4bffOyGBz9grJDdcDR64n808WsgC35FwfE0WTHqptLV3pwckuHVjoViqjir0uFDwHG
 vTZ2R2VcHtZOFjRWPfJhIXLk20Gfim4VsBiOkFCBWrAmHZjUTPQpl6NBVq_NvIiZ4yZ.u_3ZkUCp
 ZImS5eZ3mxjwnK0QdeFIg3BAiBzY6FON4X.kdLS6xW82xip2QCYSQ0Kj7OHvkkrhAxKDRarWNOiE
 FiKptJWZ89NrwQYb7QdGYyBj2nylIDXQk4O5cMggyrOMZNbkBOQb_amksd1KgCMm4zX.RbCAU0Sw
 PmVC1GBdwdR66Kn.kIUWPV6WntiIp71JpecCw5HwsSgxvFH46QrBFQnqaEFX9fCfNk4cqKfy0DOd
 _g7oOrcPjGJgX.0wIQ3y_ytSvymxpah0Nv7XinVeAQGyWtFL_LJem.yGsd5OSM4415PRqR_AQ_WS
 MgwzdeXyXWKgv_mwKKqxxj9gguQwa3SCSZnXvw6SuEZG5o4TPnCQESOOPD40CWwm.aH4popS3pmT
 ST7d9edcPJZocwXjUwoEB61ibRYI6eGu3c3evE.iKzZkgBRxtWGwnl0RtlNoF3kr6XbKK7PNSNZ5
 6E9XbVJ.e9DtT5eRMsFP3Ld3PZXl0L0dH7s3RP19eDXzonhHATgOQMOsx7k2vrrxuIHiTKHrmcDG
 RVBX.ZGV3NgwbTS40lMoJQz7G4aSegWDXxlRh59l3h.lkRv8cHold1ANAKGbgpCIxi4QDqORIqIr
 n2T50RsanKwqS.xpLoZlztfyA4Ck2QyObh_l0tA069NC229Kr0xA4O7rQuYxMWJgrUbKY1yhheoO
 iU14FWi1JLQlZmJBopNOCEt_4D.CJlbV7fVk8WHd0ZO2OyDsH_7RSmTs4faXJXIOQ2BbHLipsx0s
 43ZAtl5cIaJGT.lyjnm_ZvQ_xaKqp8iJn3aji7BJTKiaFN8RctW9GmnR5lMzpHpJDRxJMMjCedCz
 YFpjB4oDalkz8KXvsAAYBZMo20uTQ4w456yWe2J5qoi0WxMzKWEscWijRgLjazlypEXkJkpj974X
 FHgs0ATyBVx6tNw9uotJIhWMScF5uxWlIMhMufGIzHg27fo3vGZOssjMCvbtyeRkZebSo0zFmWtF
 4kzgyWSBD2GDbwn_aTN.NYlxPRCXf7WETO6Ck6nSepv7ya5MJWW24tJtg0rUXT_tZSjTay3SeoA1
 TZxE43YtdBCRPFNIe7orin_pk72OoXOcxTrEWgwBozCqhnsEzrbMGdT_NkwzEhO_QA3B2hK8Sipn
 8_KWSoqbW6JOLOIwZztNeJPFBTdvFT6rGepvuwtBSBwM0OzKXgDx9_Oe4J1f0fbrEgyDgrxgABd8
 33HhBI_S8PgfCcqGrwOplPEcLlgcU0KPTYNa3IMxP8N6eLA7ASIBsYH6iqiTDgBx0IPp.Vu1sSF5
 v9ZOS3IKtpof7wlWJZcGSYzRciEGcPV9zZMGLQTy4N1.aFkL9EAh.TBpwSBk3jiI6f7K5KT0QrTy
 B1DYNslbtD4hx8PJyR_oOhpfprZH9nt.eE6Z4y_31OJ1ld2N9iJ1jl47ChHFxlex53NyhlO4JMDL
 VTFD.R8Lb61F6thncA6sn6Djaa7eYa1NS1OFzQkaQyRS2apCxRsZZwuLGxwEgPR_oG5npcHCdxXS
 SglOwZ9ZGIZtYiPrdJFbDxU4wQQuzuPt7qVmXFJ.AeHaAEZlN_xdsACSeDGfJ.d.eLFi418D_4yO
 qdxWumaX1I24q6cIN39TRf1SEgyQk7v_zhmjh.6oQzszOrtL2BmEsJ6YMnwGGLBofdDkVWBP4E1y
 0Xw_lRfrOf9pX7TbfC0i_VI1JWw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 787729f1-851d-4e07-aff2-45c0a9d88a4a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:43:43 +0000
Received: by hermes--production-gq1-6949d6d8f9-k52jv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ca4128361bb8b08e481604451b6f4d3b;
          Fri, 15 Dec 2023 22:43:40 +0000 (UTC)
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
Subject: [PATCH v39 35/42] LSM: allocate mnt_opts blobs instead of module specific data
Date: Fri, 15 Dec 2023 14:16:29 -0800
Message-ID: <20231215221636.105680-36-casey@schaufler-ca.com>
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

Replace allocations of LSM specific mount data with the
shared mnt_opts blob.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  |  1 +
 security/security.c        | 12 ++++++++++++
 security/selinux/hooks.c   | 10 +++++++---
 security/smack/smack_lsm.c |  4 ++--
 4 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 59085248809a..24a0f62ec2ac 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -156,5 +156,6 @@ extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
 		__aligned(sizeof(unsigned long))
 
 extern int lsm_inode_alloc(struct inode *inode);
+extern void *lsm_mnt_opts_alloc(gfp_t priority);
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/security.c b/security/security.c
index fd429f67d2da..7a9fbe706525 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1385,6 +1385,18 @@ void security_sb_free(struct super_block *sb)
 	sb->s_security = NULL;
 }
 
+/**
+ * lsm_mnt_opts_alloc - allocate a mnt_opts blob
+ * @priority: memory allocation priority
+ *
+ * Returns a newly allocated mnt_opts blob or NULL if
+ * memory isn't available.
+ */
+void *lsm_mnt_opts_alloc(gfp_t priority)
+{
+	return kzalloc(blob_sizes.lbs_mnt_opts, priority);
+}
+
 /**
  * security_free_mnt_opts() - Free memory associated with mount options
  * @mnt_opts: LSM processed mount options
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e0f6f2093708..3d046c9d0121 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2787,7 +2787,7 @@ static int selinux_fs_context_submount(struct fs_context *fc,
 	if (!(sbsec->flags & (FSCONTEXT_MNT|CONTEXT_MNT|DEFCONTEXT_MNT)))
 		return 0;
 
-	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
+	opts = lsm_mnt_opts_alloc(GFP_KERNEL);
 	if (!opts)
 		return -ENOMEM;
 
@@ -2809,8 +2809,12 @@ static int selinux_fs_context_dup(struct fs_context *fc,
 	if (!src)
 		return 0;
 
-	fc->security = kmemdup(src, sizeof(*src), GFP_KERNEL);
-	return fc->security ? 0 : -ENOMEM;
+	fc->security = lsm_mnt_opts_alloc(GFP_KERNEL);
+	if (!fc->security)
+		return -ENOMEM;
+
+	memcpy(fc->security, src, sizeof(*src));
+	return 0;
 }
 
 static const struct fs_parameter_spec selinux_fs_parameters[] = {
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 573d5bffb9e1..97ffb07797e9 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -638,7 +638,7 @@ static int smack_fs_context_submount(struct fs_context *fc,
 	struct smack_mnt_opts *ctx;
 	struct inode_smack *isp;
 
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	ctx = lsm_mnt_opts_alloc(GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 	fc->security = ctx;
@@ -689,7 +689,7 @@ static int smack_fs_context_dup(struct fs_context *fc,
 	if (!src)
 		return 0;
 
-	fc->security = kzalloc(sizeof(struct smack_mnt_opts), GFP_KERNEL);
+	fc->security = lsm_mnt_opts_alloc(GFP_KERNEL);
 	if (!fc->security)
 		return -ENOMEM;
 
-- 
2.41.0


