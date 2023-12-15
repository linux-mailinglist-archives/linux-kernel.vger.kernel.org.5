Return-Path: <linux-kernel+bounces-1795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BF08153FE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481111C243FF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE58618EC2;
	Fri, 15 Dec 2023 22:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WtED4umQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E00E18EAE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702680603; bh=rBrX20RKGA/fq/6ZpKrjQGgBq3YXTniSXMxOJWRHlHg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=WtED4umQ89i9DP+27JOtPJGe9d3NXsKNgLFfejji1w7wZu4mfkW9h+tvy/py22+meL6gIkQ0SHRhPBq/3S6aEl0QxSDLQQq2gPmClnCWI0qnUNpsndo0u4sVtD6OLu099nzTjBdGlWM9Q7G8H7AI68trm0kasNN0K3KUb48GK+FLyqJdJA1Bj/P4Djh9De4c9pU+PowMERuYXR+dOwGXKctAHsHWKLyTsDT7ajLgdZU5cASK2jcEO9k3TcTSsDvvcTIssjqK476xPhld5X37GiUQ0033yjWkLtyPToLt7TezKC1fk239wmUeHhQL7mBT080HRUokKw/O/VkNEoYgIw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702680603; bh=cCXPVLJVjTpxa8aQ8l1NNDtJgIgas1pHPmm6wKmj16L=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=BxocgvuEZnoLKRLBuHCyqVkixWK5K4RA1y4IawGw0dRulFGlndVqEJhTCfMIlpcWIxhn6IPbqb8iCXoSTHD3rGm61+klPEuPSkLtFS1DwNUSKIBvVF7FUEXWbsXprESZgf+QKqlaRwIU9ZvgyfISn6VvACd+fWPGzi8UuJgsGKeGf/xEZf2HhF32Nesk/WAHvm1KBzwgVK1kX/IrjCLa9Hae8UMCrvOM3B2hnIU+cHPPFpjr9yuAyxXJD2/JeSUfERUFwqgkksPZr9xhwFkAxfEyh7y3zPO2Ijfnn4Tz9+Aqr2S9C6V5CbI4BJCULz3qCxELbMViE8GNESNvClWvXg==
X-YMail-OSG: kmcwAAYVM1nyQRivV3hBA0khhAbEdFHCub.rsza7.P7rdz2eFCPoeeJ4sx8HNB_
 ku3LC9CjjwgqvSFLFScjonwVruLtk4qOcs8YpZx2z2Wf25ffB93qtqjls0lE_._dtovZPgHEJ2cN
 A5xJI9FxePac8BaphtEcNRoRyqs9y1Vzuc220jbqtYo4z4q.15Q78p6qfNUPUkepwEKjnHg3VlrA
 rasZDFgO7yHhVwCcwQl7x2MtDFLIBxzCZcPhWksxwzRH5I3qUXMsFkVzpNYloUg9o2TbiUxN17Ab
 y1F2N.TjpalA6cOK9qVIfV.ETVR..fBnQQLmKadcUOS0OUp7dKaTGtSfYTzL66Bqu2loQHySAfqN
 lBmBQeaYFB0rK.lX1rjXa0WL2osGdsEH4pioNWY043ZKBwL7DQj1sl8r0K8GalAde1_LYvN.uo6M
 LBhZVVCKCs3wrn1vuSqXr9B40Rf1r6XOoa_v_ICZbrqcyxIpc0DWLDkABws3Ru2fTLX1gtwGOZ4e
 Jd8reFczWzTIHxVuDOXoew3i83YzUAqzVGL0tEA9ZhDPM5w4yTeELdzfta0AeBuC6eIcgY2R0LKA
 NH8FLlc9MIashQmPwCPzmKqDl1ekuV7hmT7bnlovkIlDE0Nf_5rPw3oaFQcRDZp36MR6rpH.Hbzn
 _MQveONfTIytn8k3k6qadPJUrg3.cbJD1b_kPS.fpgk29kxV4gGUgVLhDSg.Zyswb3tnICgzMkdB
 eyd2OZX5US6LgWnnROjZhzCE6EkM.kpW7S2CjD6K6zkbgaYOGQM78ynzlhGIVAj0FhIcgosEgsIA
 D_0oGrzvsdHLxec15pFxbSXqHzKPe04VdJ9Bdb_uFMnWmwDF9hHZ4Dgp0OIDLogB3Ud0jys1ziSH
 IuJErvGSg7u1bY_Z_lz7sKRsqlKtab.gJcZiCyI1SRF.rJx1gtTBeKGmTv.862ZBNk2d7bago_4r
 z9pc4lpkFwvLmJK7oGHUbZ0.SeuVhXyk5HjoNiCp6GOnCModc91R1cI4VJmU1WmpjgJMw8o_.yws
 1BZUwGn1xmMeJt3Ft3Bj3JuAKM2ucrQmtcuXA98STc0_XeQBX6Mnoq04NwClxDVCu_jYV8AXjlvI
 BG5U4zkuYRR0dTPxQtdvXCgkf49leWgsurk_r36WcdM2M_AalvKg9IvApnKgA2O09KL.AYtjIMLb
 fQR.wTbkPY2LJyP2qgNhyrMw3A75VI7aOIC.EcbnlvAZdoY_Z9WIaLby0K604uQr22Dpd5nk_0Gb
 eJ7TQEG0VMKpa1NqXIQlbse_mDMeWwrRsh5GNAWDHK8RwTAJnMLOJTIUVqQx2E_Z1udTScFGiogP
 24xYuWNv8mS4BcIT33BScQJ2AbgQwoeQX05vGXr2L5sF1DW5fKnGZrdsp0A.rP9PVrOvxqshzwWs
 Im.mxm2C.uZT1aCiQd_PTHvSfQuIOiIED9nDwP_MMvh6bBXVGPSHbh1ZYAFIYhWFgH.nV.HbGV33
 jnyRbB6nzaMi1iBcBaw6MuTkybOrkSHQ.Dddcc08aEs2FXg_k4B5uwhKvjLU43KcaY0ZLAG0l8gj
 UAKIca5LJxfJRBMQEULYQYZtY5uHVoT7KBYcwIQVEKBp2oay_CYHnJCryQPa5qOMCdo2YKywwue0
 sMGfeNMgT8oKKRSEDKge2_t4KvTgk5LsL73.XAlULL7QmakMaFqnHiaIzb3GjGo61MS7tWkXyeOs
 uJp.jGROc2JS3wLW6cKiEsCz4.ALOEeVqhhgTq144iNAAb1BaOtP4hc3KcdfE.f8pZ0XO6tAaJrb
 7n0pDb0y9LlAHZYePNodyQUMAOK4aeQiOs51lPzJGbB3e14qHMrmoR4683bipgDPU85B2cilzfgp
 KSjMn9r9cLJC.MI10dVS9VDz.Vpq28FHTq_7ofAOpZo4Jq5f4ekIr50Jz8O52UTGgu_yMAAfqrs9
 brj3w1rdO1VOXU8f5FU91M.y4caQlQCHnCoQmPLQObA8HZHlAElv9aiVwHdSrm53adPgdrZa.ypk
 xZJwXdiuE6gtHqUpB.RWRtmwg9GL3jF35EJlZwdseOAHFGNBlLITtjErih.nT4iWV9k3vBGO27gh
 eR0FTskk9VEMs__zRR1Wq7g62CcQ5xOSeaPFh1LntoscJf_THYk8QZt4hfJTO9dsaQCukTSoULJ_
 WjLgn9507MdbhZKMmGBd_lLqgwAar9irq6VVCMR2mfN8z6hT7ej6c.YYKIyFz_dx.yxWe3SpINVV
 Tx9YdrLMwBcWPWVscNT5HCvWEZceWPRzc2YRc1LPl3xYhDFaPPgIAU4kfbVZk7yy3FYAYr18MXpk
 dIN7rgjLJJheLtXegbHmrh5YWISbh
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 2be22b4b-e59a-4cd7-b2d9-37a846ad2914
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:50:03 +0000
Received: by hermes--production-gq1-6949d6d8f9-pmzmd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bab51986ed5b5f266b6ddd6db4744dbe;
          Fri, 15 Dec 2023 22:50:00 +0000 (UTC)
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
Subject: [PATCH v39 42/42] Smack: Remove LSM_FLAG_EXCLUSIVE
Date: Fri, 15 Dec 2023 14:16:36 -0800
Message-ID: <20231215221636.105680-43-casey@schaufler-ca.com>
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

Smack no longer has any behaviors that require LSM_FLAG_EXCLUSIVE.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 9f5a37a5b47e..7bf2a3fabf33 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5325,7 +5325,7 @@ static __init int smack_init(void)
  */
 DEFINE_LSM(smack) = {
 	.name = "smack",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.blobs = &smack_blob_sizes,
 	.init = smack_init,
 };
-- 
2.41.0


