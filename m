Return-Path: <linux-kernel+bounces-1773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 258638153C7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489F31C2452C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A89618EBD;
	Fri, 15 Dec 2023 22:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bysT4xYk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88385495C9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679842; bh=AY20ZFrU1wbcN7ypVt2+incPtgkBfYNVy9D03vUKxiE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=bysT4xYkSawnxm4xVclXf5BSqOa/dAXgZR1opyCdJq8BeUriarGLgR2pRG4SlyanOe4icu3T5DdTolxgv9xIlaRuLOVteAsLefQiGrtJoQI/bTsPbo5+LAOzkdyCdJDYbtfK1JCdAcL7gRjZeY7KsrX6P6MNWY3gd3UQ2m0RqirAyHCjjy1PVWd4eo39VNXn/939oX31FkVyfDxBndCXBZqiXxDtMB7dFahuK8aS58Exs9NkIWZHQIeMnGNAp3M0oRpCl+hrnu5VITHqjgxvBRFBqBA3eqHcArsYTdV6+VfF4fykAReZiXUJH/XGL1z6wJGK1WveUz+MwdX2vccaSg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679842; bh=IXnnuOyJkeRjF55SPtDjdc+TVP1mutI/FpT9qm3+Hs6=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=kevNW2Vmly6srcVMOg2DDaCLXsDyDwC6uhvSE7uFvg0V/Uame0uUh2JzN5ejc2s5sVjd9IV9+ug4kmgKC+zDtlbhHb0gMUE6gHxRBvjhx1YHYikY4EzeyivHAGjIO4UmggmQBWiDXi5+7u98Xs1ijJavcvDrgc0ewUmGkpENWX3m5YBa+BS7qEFQCz5bgX52g1BjNuJkX/KfvDqCq23eJ/iw72+ZcDt+kluYrrmAL3lAX43c3/j3V27XiL/Uxv6ebe+d25s3aws2cIy47MRvgo2/oa5dz5A883ObuMzeNr58fvsMPrJARmMTQ34x+Goi+L1LaL7YJkNhrhxeELaHtQ==
X-YMail-OSG: lIV3mRMVM1m8JyYYibsBE.59mSHktsLaZm6jE2.8x4nksF6kKd.iiSZcEXvXgyc
 _QHB3Trgz33IAHCW1dzKe_5kobq16.A3ENtMxZWCuttEOS7SHIbcN7Joq6dp9u0UXGs3Kqkd1mhv
 _ZuKGsOomYIORjs6CWyIE_gj0SPYnwntCm_bg.01knLqPaQt9vXSGmImgGOa2sSF2F1vZH.EOJNK
 SAuKW.UCx9NPQPwiczgQPpsaWLW.9siMtrQBXIz50wsKYbCNSepniFfyNb8QmRK1PY_U4u6BTGPF
 dk6GBpKzTO2MaN0FkJXhD8hPK1LZg87PIawmONOxrQARVRzxGrkZcqvxldBQHq2fM87RgL8eDmun
 NB.YD_B1Q8VMYQHQTijo0ThdZIipVdGPXULkEXxxDPVehFglrg6HNIK1Rp0965VDjkIoKPiBrIhO
 tmZ1e6ZQVFyNSCuUv2a7QYxhASgSZUfkP80K9siKp0EJreYWZXGZ5V24cgeesV502hGaxRehZ6Al
 rFstnkHHHE8GI23aLFu1nUp80U0uT1Bv_rrHS9KUydf4iCggt5olB_gJPRyROlVDRfdQVrguzGVi
 D0ZhTm6OSLEf0favkSKug4Gx7PoaxLlas620c0fbKEnime5S7UUFGfAysrjmaz9GVh51FxFbsDh9
 Rcbci42Ef_b555AWQPiOxU2rxUzAiRgu6ZwEkjRccEmNGTtcvCXDaX2FeaxVGjkzX0dZ2Uh_586I
 jMlRE3DzjUdAj6floNgokx.St.B0U7M_qo9_v5gQlz3qw4UBdzAU9wX2pxt8hiWUi2RAsSfd1ULm
 zpoVXwdmee1yxLAyi092w70P09jPVEt5RfUC0VZBqQeZA5es44.RH.uALfG373f2rJI8r_MjnU0l
 B8Ziy8csoCoyyxlqUzKROa7_pMaxheCZb7PsYzLGF5klFk82BaesZFxDzME.qH4V17rHoZwjpn9F
 Pb.oPr0g3wBtX3Pv0DoV.x9y8pB0Ppgfw7SRzIilsd507ZaQon_2vErrL6JQKY4Ba_KbYVwL5nSg
 v_6ebQ5xTyauwdU6Bw4rHixIXwyX_hf4sev7rKqlf6JUA7VkjVu1dK8muDUS2mjdMwDBFjT6TV_W
 QN7aJasZm6diZXw1RWDQlWnn_tXr5HVmTpq06BL20xJCF6lV7ODbDmxbe.jST62nWsV8LNtQZcup
 8Ocj7g2poQ9p9E6tTy87qgeYS5FmRKvfvNHSd4JmDdV9RLddDCSLRj2KtZV.m2l0kS6muJfqzAd8
 8PxfW6yDtpq3feyeZkvY9.lwX.5hTCkA.KRwRf2CVbtk4nP9Tx89QEOHN.6.TSNvVujy2Bu0Y7pU
 OGt53Vag5CCXczyNegjr32ICppqMKGpitXpFuai4lyoAC__05c4dJRQAF1ybc2XTCXPaiXUR2TpB
 wJgIgXKc2bwW6Rpfz84kTiVRmnazwxMIhjrTyeLc5O4CAC6k48MZy0X8CM_pp1XwzWpuphTF3e00
 _TEvJRrQdZqNuiyUdADhzazNyeccQFQ_4DM5ny2tnjSCBwjLW.skUiaZg62OkRbEZkWhGO4jCf4Z
 tX1qXUxGwyiHr0p8vz8eQ0nq1u3VDZFuX9dOe8p3Y2U2UM2Y8l1UcCio9g0wPZtnLGyfhdNwZGPM
 L_NHJ3jmwWScYTtZtYKuR9yguv9OhmyA9cof3pZE15PrayqWp85ld6Oi7V5yqYjyUyim2r3RPrc6
 mcNMhXyCnv9YK36j52pXzTvxRKa.VTb._My7yARBlb2GzhNg6vRhMAnHlkaI1.8nJUt2NnO.vt8o
 vLKdBOOd1_hRAofD4Z9QVLOkzYeLDizstcbd_iSuk1WFudNiqazymYIT4DQgJmpTK9BXuuT3Jn1C
 sMKa39EDG53lgpPN4vkZgprLX8Oq0717QSADFgwq00RtTelgSgLKx.F7RzM8WYZO7mEJgFYnFrRo
 sofBcORMSeHu5tOCbyVzrUOdLqqTzxO_aU6VdX7pZ.3R7CJK8O_h2mSj9b.Es4CQzSMcBUP57WK5
 LZkSsF5RBCVEPPbKAvTFMaD35uon5trQqMMev9wzNxNSIY_QSwP9NB6B2BTaxXeG1NgEnv_WV00c
 dpzYFJfj2tgKG5zWYsvKT1uMjGNZmcZcIXObiTsHnGALex15uoI..QV80i.5hAa9CsrEg2HYo1UD
 WXnwrNjlTYUe7lQIEvA5osE77kLutJV4txEtp6176142F9n9Jv9Ghuu8dB4R6gCQL0FMr3LMyiC_
 0tH5bKDrIE9UbcwKibYqXdNsmFtX14HVcBRDyDon7Gp6jsQO3
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 9755b1ff-cb19-43be-bb3f-72b0628282f6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:37:22 +0000
Received: by hermes--production-gq1-6949d6d8f9-7dnvp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 99c4f57f4ffceb7049a22eccaa6e59f8;
          Fri, 15 Dec 2023 22:37:21 +0000 (UTC)
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
Subject: [PATCH v39 27/42] LSM: Remove unused lsmcontext_init()
Date: Fri, 15 Dec 2023 14:16:21 -0800
Message-ID: <20231215221636.105680-28-casey@schaufler-ca.com>
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

The lsmcontext init functing is no longer used.
Remove it.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 947cb3a35db4..529671a89ce0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -160,25 +160,6 @@ struct lsmcontext {
 	int	id;		/* Identifies the module */
 };
 
-/**
- * lsmcontext_init - initialize an lsmcontext structure.
- * @cp: Pointer to the context to initialize
- * @context: Initial context, or NULL
- * @size: Size of context, or 0
- * @id: Which LSM provided the context
- *
- * Fill in the lsmcontext from the provided information.
- * This is a scaffolding function that will be removed when
- * lsmcontext integration is complete.
- */
-static inline void lsmcontext_init(struct lsmcontext *cp, char *context,
-				   u32 size, int id)
-{
-	cp->id = id;
-	cp->context = context;
-	cp->len = size;
-}
-
 /*
  * Data exported by the security modules
  */
-- 
2.41.0


