Return-Path: <linux-kernel+bounces-1783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5337A8153E3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0970B2832E9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B5F13B12E;
	Fri, 15 Dec 2023 22:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LNfEV2M2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EA718EAC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702680221; bh=NuchN7LWq+7dR5oCIrU3dqcwUFeyKlFDBPhpyQdG6gM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=LNfEV2M2x3AhAouQU996hBof6gSHadROPBvcNl6jSwDmqAgwTMwKD51vgsF3tpnzeTm+NiJwX/pZbQCcpNRi4pytUnEs3pnEuWOddteKmTIczsgLzw/TQtG7os7uP6FC4B5blWE8IzKkzy7mEd2zUpn3CmqVIAphpBOZ5l3MVhsvozJgFMYnsHkYygvFzVuIoSngaYEKafP2aH3sytyfNZcFFshLn8ZywnEPZ15Lcu8BhBzDrnBzjWEk8JIXhRmMtYjB4SGA51x0BeLDpv53vsZ1O89754S/bP7ztoIK0u2YEyCGvkevLq/9sMoln7NbqRgqTUPAUqkkbgJLshFjUA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702680221; bh=99tChxCy/47LiTe3kp/zL7x3mbeHpcRS7ymKZm7mlez=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=SVuu7mux7yxU2IT5thac09F0yiwx1pPPATUntIUmqOMbjwSiHKk+uXqDt98LtxdtxkjlBKi2RNx2NTl5fLbWrANZn4vQWR0LxEm80RelLHrMjR2bcBg+6Em4zrMGcMhJ90HHTWFA7usHWTKOnXjI5ehjG0wQfwqZ5NXTGPw5gY4TGlJNPlmEpv8HPBfYhsRv5wNMvxjcPIwqs8j7BdGflombzlpoOVILzyvBrVxNFhj/+GwpDXBv0oIr3YcHqbT3ieUcpzOZyJP5iiDfzCMrmqmci0soihPeFmS4xaWucwKE72uYf/cNsDSEn8zAV0YvkoaQBfXE/UNI8WGvxaVCDw==
X-YMail-OSG: 6F_hx6sVM1l2Sp7xn_RpIj6KUhGj.KY8cx1OV5K6jzcSd0YKqE2AcPtu773ohVu
 oMgpvLNX9lt3nkZbLC7NvmkeYu8iVqFjVP.2IYvwsR3aJ7pJk0D06xvdtu0US6Kn2Ih22QBILbAM
 zDyzValcq7lQ4o3TxYcYEGwd5miELrMFhhpxLNfrQnlcQXz7J48tHUb1VvO300oFaNxOw.HGXr7d
 uFeaKRSqlFty2JXns.wFWUEoQcShd0sGXlPZCIseoXFzjy5nX0UemQIojiALs7B_uIPBqQRT1kwG
 F6Kf1mcCfWL1z3N1CsGfC8b.s8WsJA.YrIKiU3aFcWc8LTLER18gSPoMlrn.aUMwREqFoJ.14PYL
 I1Fi6HbpfdtsFFxqR.8BIgMfjqOkyQMba6YJ7mcBHFQUXLAzuV88EHTR9AWKsLQExpqJV_QUJeuG
 1V4T_EbuE2KzxLidclOISihL8PWmFdWXL4fqvtmSz45GgVJMm7jvCNw8J318TfwExMlpDM76RK_z
 64kwfl2RZAUbIYjDCpcN2_jsv6tNBwwomrz6.fAYCjm4dL2jp6nHfOreqib6hMJfr1xQQlj8zAGn
 neEvsjJDkpIoKE8BYDOsWR6pTiM6Py_csfMVsPZF0dpSn3II4mBLPeWFVT94dDYmzgn4rOlYlN78
 2Nn9nahaRnQH3jjNHfF9BegGYhh0dAQLJImQw9pU21MzOVp.fOWdKHeZ.95t7C.TB8_mo.z.02U5
 G1cd_VWlXzjTdCzKh3Dql0KITOmUMaxSojJbyYhHHp42X0HQIc0.cgPdRSuRrspM2nUbSUpisXMM
 _akftguzIff5aI0W2JXeX_Lzxp0q4j945ZGpvBQdUhebIqTbo_gp_j0eKJk0e7oNBy5e14idix7N
 nV2v9AQhIKRVFmWo9X5DLFBy6GjBCOhHiOGbnRYEzHk1QVERGlP53kg0FyXoZPLYf_On8AT5MZCp
 bU9XwAwE69L280c5s4fBdGyRqTjlUSlQo3Cx6EBmpgVl7CdZeO.8939Y8KdoCQtOJWkiPZXXMRFY
 WyV1b59VABlD5eMwTUd8AnGsXDENVk6G4NZ1RHwux4uv3fMlQcu2yCwAUTdedm1YTen8GsojzpPr
 BVRxPEna6QX139rnhZEbsP2NjDWO0pIU0SqMw0axLNYCDdLYa0f1uYkMSSMyRhVlrJJfBvv0ceAl
 SJmKwG_r7_CBmicBThuFRzQHvd_COHURz2rXOELXxrNvDt7F3b7ohjOeOU2arMAI92h0y_yXKVRP
 n7cVN04VqPQYoZONLAYYYI7ZktrxxSymIZ6sdsWDX4bKSzAlm3lRKon8zz5aiSg.ieYwWTQYz.ik
 XYDPYT5lgCGIq8CtYHjsuc.VN52gzeqkdPKPePj.SD1ujM1sV.jNGKvOmXF7ELJKa1xifemUvoow
 O9vjmrj.ShX7kmMKksLx2QE2FRZOEJs2EyB5Scnhdvfcef5eE71A5YhB10SUdZW5jI.CzRDgkajZ
 6csbnhkpT_AErsApe6vZ8cf7CrPofh7HYTHxIGCT5czkflxIAgDZQ7LpywlQcbzhfTMmjFX6MKMm
 S4P9TcL1VGEWA33361AlmuzEz4h4phtplgi3YaWCxnWIw0W69tf0WnV8w_BIBgywxcdPduO9ZUJu
 oM2QPNX8Ku93wKFP04GcbJY1iXlVLuSvRJv9BzVvOxVsO7ju8Q01HiZVJh37WiXdoE9M5iR6HRak
 slutT817fDY.E6yzw4kHeekra.f92TxN8VAvHd2qw2rbuyPTGlq2Yj1PzlwaBqx8oynG5GMdZPH3
 .QXbyqMMBpXEuXDJiqTNPqxtpixsYpaPm0O7Qc7O2lOBueox9yUshrOQFLMlWD.UfwOGTCcxmYc4
 lnpZnol7IYTloIWsBpYyELb3wJuVLdo1x4FcqZ69.WnHwkka2yCG3bnnReshabgKfBVAlL8saI6o
 r8FwQl4c_7BP7chJGs3RPs8grYHGVUZm3P1RZTkT3THF9O2WqQlGezYKyldaZMBEe2OuGiXdXxdv
 QPZTWgWVetcH7Za5agtYwtWQqG5BjtlkCme2o6xoYkFnlX3ulIPnvySznHP9291ZR9Q5NqhOmy7L
 Sld9r6xx07lHOIPiFda4Ivpkg0VYYI.V9xZ1xvRQ5OLx8QASs0ac6J7WfnZCURHFPkcp3bCLuawC
 Yd3.o9I6ZlpTCJKVXjctsRG_BcK06Zt4.Ip330f7Cc6rzWDrHX.t_Z7BM53YN4lxHx9TJQqXki3W
 qfQLw5zbM68oa7NHc2KrbrFhJ856Hla1.XR06SlGXUD9I2BmBLEFOv_IkHuW0hOja21XY39_KTTS
 bXSehd6gwn.2qrOVgXKLDejkZXys-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 869ce3e1-48f0-48d5-8d86-93a5ceaf74f1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:43:41 +0000
Received: by hermes--production-gq1-6949d6d8f9-k52jv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ca4128361bb8b08e481604451b6f4d3b;
          Fri, 15 Dec 2023 22:43:39 +0000 (UTC)
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
Subject: [PATCH v39 34/42] LSM: Add mount opts blob size tracking
Date: Fri, 15 Dec 2023 14:16:28 -0800
Message-ID: <20231215221636.105680-35-casey@schaufler-ca.com>
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

Add mount option data to the blob size accounting in anticipation
of using a shared mnt_opts blob.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  | 1 +
 security/security.c        | 2 ++
 security/selinux/hooks.c   | 1 +
 security/smack/smack_lsm.c | 1 +
 4 files changed, 5 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 4deb1a4d2d1a..59085248809a 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -81,6 +81,7 @@ struct lsm_blob_sizes {
 	int	lbs_msg_msg;
 	int	lbs_task;
 	int	lbs_xattr_count; /* number of xattr slots in new_xattrs array */
+	int	lbs_mnt_opts;
 	bool	lbs_secmark;	/* expressed desire for secmark use */
 };
 
diff --git a/security/security.c b/security/security.c
index 8576121fadb9..fd429f67d2da 100644
--- a/security/security.c
+++ b/security/security.c
@@ -232,6 +232,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
 	lsm_set_blob_size(&needed->lbs_xattr_count,
 			  &blob_sizes.lbs_xattr_count);
+	lsm_set_blob_size(&needed->lbs_mnt_opts, &blob_sizes.lbs_mnt_opts);
 	if (needed->lbs_secmark) {
 		if (!blob_sizes.lbs_secmark)
 			blob_sizes.lbs_secmark = true;
@@ -453,6 +454,7 @@ static void __init ordered_lsm_init(void)
 	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
 	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
 	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
+	init_debug("mnt_opts blob size   = %d\n", blob_sizes.lbs_mnt_opts);
 
 	/*
 	 * Create any kmem_caches needed for blobs
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3e590f632f59..e0f6f2093708 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6970,6 +6970,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_sock = sizeof(struct sk_security_struct),
 	.lbs_superblock = sizeof(struct superblock_security_struct),
 	.lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
+	.lbs_mnt_opts = sizeof(struct selinux_mnt_opts),
 	.lbs_secmark = true,
 };
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index c93e81facf1b..573d5bffb9e1 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5064,6 +5064,7 @@ struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
 	.lbs_sock = sizeof(struct socket_smack),
 	.lbs_superblock = sizeof(struct superblock_smack),
 	.lbs_xattr_count = SMACK_INODE_INIT_XATTRS,
+	.lbs_mnt_opts = sizeof(struct smack_mnt_opts),
 	.lbs_secmark = true,
 };
 
-- 
2.41.0


