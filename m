Return-Path: <linux-kernel+bounces-1776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CBE8153CD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB25A1C24735
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8670C18EC0;
	Fri, 15 Dec 2023 22:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="s8E7a9Ht"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B1418EAF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679938; bh=vw4D+BEaDQJfSHAGsDrE6ropoXZ857wJv+qK1Uq2Fhw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=s8E7a9HtnwBj2iiRElPv7y2OTlbx0dCRAAA6Or5I/05O5N4cr6J1nrWYTkW6kVIbRI2i/KYtGGPGF6pH0JQ4Gzx6xHG62xwnWN4SxNrYpR2OZKP1lUykR2lPd/javdaj3N+znlS1+3IO8z+1JzCIy/hC9M7sjLwGrb6X1UfXBDoaG3EzcErxgWfioyVoTkjesWsKFyRuqrwbmNM3p99JfS02u/U7za4IJb1FyIKF4EXBsS7Q4tk2KYk2uwgqU57CoQLAGG1CLBtYhVqCgnfo7fNHrnzbwCyNVfnpXwlTUwMpgnSY5rfDppPAFNvYnQF/sx+3TY7rK1eQhK4bS7PNyw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679938; bh=2LzbYmbZES/Rx27hObskEXduuG+XqU8pv+hZKjvn5r7=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=dTX/HxkqVX5PK0d8MQO+peyShfelnwP8wEJpgP5MijcaSk0LSP8OCbQc28xaIYckvSRYLJ6PbM2kN6Nq5G4qmV18kjaCf/9jkMH/IN7vqjyBFDerk4hHuutLOR+Z1sUgbPapRGOzZCKv/Q/F04Rmoxk8FcZl2Hkj9bcqFzRGZ3Za2Tp+6yFzNdkq+nWGDv6yY6bRK+5bh5SHdBdyBZWHcpDHEzpNjmbKlhogrubXOrgY5LAPoKKMItnZSUUtzwG3CuZmm27GdYZytU/SXnIiT6gKc4KUSXK2w1MzJFhXTIOXl/xNwKbbWezYnldeGvO8S9sexpb0B4zBzhW/SlyOqw==
X-YMail-OSG: ECI1w1QVM1lUPGDvCk.pmrmMnDdEK5GNlLDmCYaPQkgnT9WuOsTiEo95cqhIlNo
 TtgRjn6x0bF.d5_TUduVxhGFXkWD3CMsERJM8o9VRsScgjM.08rjAE5yRAycJOBnC8uuLghnGnkX
 AA7OSgDi4gmXY_h9RwVM6oBmdD9iOFGFhEcrUVXXYD8bxgFBVn0PpxcBVU9LYlSm5GHBFqZVWBKF
 JXaqm3VGwFl87GOQ2zwB4Lk8s.5hPq6snASDUR1sMhdjGhxf0BvCq.gA_ZMQyoHVAFuyRPL6Z_lJ
 5cn9ORu8NnKWsfehnZz.oqLHFaT_XevKQfv_v84t48Hi13BS_rKAMxNWERqR48EwudIS7.J0gk8P
 qWMSyVACNSZQXAUBBSLz_JJmG2DWuN6a3gd54eyHyq6emy.v0vexGBa9niv0u3BoEaagTOHAmIRn
 fkUK.1I33xYVw43RgCb9mbv9WmKHCjDt_TnWTDsKMLLLPxXzeTa3lAK7lQzx.OVRXlq.sMFGwegG
 lAcD6tf0_7f134E_HiyzD.lcLliPWNM6Sa5mtXgdg1y6rRLRpavf6l4RWjXE.AFRCxDRoJCoMP9s
 o0SEYmqhhLgaaYU15xc0RgFCNXtRO7oxuQgRW3PLXORDTZcOeqVUpCHdsO9U.NFEsFKjeZ4VZDuk
 l_izfvqkq1Uf0km9NNJIj0o1MUwlguu_uJiR3di52XdC.15C2yb9D8mrByaag9GqRxG3EPOGlOZI
 r2cJTbNJHZy9sdmnnuQppw7uDGYDRZ5BiKA8olF82E4gyEcLHuqVieBAhfVnvuvLIWZw9kHe1TNw
 HNL64uvBFGoGC2.x5OTpfWi_JEncu.PpcY3Cjo53fMQh7FFJ0mLb0S7tuAZrDtuA3BgP9o9tczT4
 4IA_Ffmt9wuOHr7B0On4bQDCr2zMQAeldPGlc9idMJUa9JBXU17ZWt9N32M._skMb33xx.ZvpPK7
 hpadrCUNZYvk1.SXK2K40gBw9P75FvVXrmVTb9n9OeVtaXcbEcVGxgz9aeshLY39V926WSz4H.Gp
 yJhC_JsjCP9zh8O3NNkrmfn.Tp0RF1uOggxcMD57rqz0J3PP8qZSwe6uKrQONI2X.7WxUcpInwP9
 qC0TQkp6aXuJnVVZxChvW6Jh6EQ6rlOcOgpCajM_k4yHL9TDQoxsmkzouNctX.XUnAq02vyuTNKR
 VanQ9hKbGIZC99faHuGSsRp8kxnOHXRj2cZs.tepmUuRo4_xyjqc2WfMaUPx.tgS7iSnpgq4KvG2
 rbFn_1RciW2QpNSh0l_.5Qvz8cCnXgywfux55G4XW4RcDUfuFFGGMIFu0SppUUlXcI6b5cYumnLL
 6B0lOwJZnCQSqLGr8RsvlI7ERXYuTzVNLY4v_KX3GOh6LaOqS0NSQTLahvf7GMYTzvXKMa9t3yNs
 Ih7I2XOggIpXASE9FQXqsOiji0vGWvu96G_z6U2uBvfEl6zhml5SJby3hJCEf7BVVGHe9F_EzXzC
 qGGgWpm2pSWbS4wCcUksiuatvst7WyWjXV0iSngbdXZQt7LMRSYlCOn.B_MRUxw.EkOOpkyRlK6B
 plIwXU1jrjFDv_AdDn58zIFFZaC8KV3qmsQ8WNjjuh5YBHMrgzY7Z00mWVM.HeQFpxzlSqTuB9G.
 QhXaHiWRjTVhMr0nBFV3.XP_1KegolrudmhQgNwpjs.v18WB3L0L0Aowpp5nZePzKElyMmTEDE8n
 TWsaE8EYCnmTUplsnE8idnnKDZx8MmD.TIvFtxof98bJu_kz8ypvBBkrEC7EjsiYD6y0SUlc_05p
 eu_MuDcrn0WCZSOh7RZ_ATZZfE40kf6qfK2FycR0E.WGcRsK.F2v4wFHr3bxWtQMXo.bxZ2euJ02
 zSzJuUQBYgzaSa47VXlM9cDmKtIR7ijgfS_Uwc.7pLea66fkbptD2vW4mw1FqnB_2l.iC1udenJk
 C_vAz5oYhBvgytwh16qeHZHGo49D08N9bEYLMD7.QVfCrUbORu1cJJT3zbjv9IxJw8AFBhnHwzcj
 DAYhTxAFcNQiZU6edrIBJD5EOQVlowYurYtjo7ZMQbBy75lbIK0bKvpNZ8dkoygMlzA5z5qybYxa
 1Idac7UNmr3RwZLOZWzDc0frBzJNlA4vYkKMbSBBgn0jusSM8mdJxwaYZBpIbnf3URPT2oPwHdf5
 xiFFMMiLXbSY7GczQ6F5Z.0SD6jLkjoZ2wQDct2FMI1QjVeuV85YI68Fugh5s6kEV59svyA0UXoM
 JSXGtfKEd1LTAU8pJmUNVuhIwUJiyhpsqPlQeHnLHufJhjHA4vNFm_EjPy3OznnLQHNTjQ4ii8ia
 zXrMrUIikzIyzmeMacTEuWMl78iM-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e49cc921-3fa7-4678-8a0e-ca413b7682da
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:38:58 +0000
Received: by hermes--production-gq1-6949d6d8f9-q7525 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 522caf1ff66b851381e701962a25c33e;
          Fri, 15 Dec 2023 22:38:54 +0000 (UTC)
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
Subject: [PATCH v39 28/42] LSM: Improve logic in security_getprocattr
Date: Fri, 15 Dec 2023 14:16:22 -0800
Message-ID: <20231215221636.105680-29-casey@schaufler-ca.com>
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

The conditional in security_getprocattr() can be simplified
and made clearer. This change does that.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/security/security.c b/security/security.c
index 8ff6cef26e6c..f2ef6032a925 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4107,11 +4107,10 @@ int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
 {
 	struct security_hook_list *hp;
 
-	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
-		if (lsmid != 0 && lsmid != hp->lsmid->id)
-			continue;
-		return hp->hook.getprocattr(p, name, value);
-	}
+	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list)
+		if (lsmid == LSM_ID_UNDEF || lsmid == hp->lsmid->id)
+			return hp->hook.getprocattr(p, name, value);
+
 	return LSM_RET_DEFAULT(getprocattr);
 }
 
-- 
2.41.0


