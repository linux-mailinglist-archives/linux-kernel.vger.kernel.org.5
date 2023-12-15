Return-Path: <linux-kernel+bounces-1782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C4E8153E1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05BE283C92
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6450E18ED6;
	Fri, 15 Dec 2023 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ztiz8+Pv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0988318EC2
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702680128; bh=ZI3o3PMEzb9gnitNsbuB3iBlot4aiealGMA8AVY8gd4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Ztiz8+PvN+jZx4/zNPAG3bcpLK+DYIGrzdgqvTcx9ps7HPagfCTJbk35iW7G6kgl9YJ7iD4JJQex0NJwW0I9jxXGP+wy7WltuZ8w/HIsgH/LR2+PZg90vbck3NA1KcXpGEG0rc+pxy4NDjOk53xrUtuiEi5NzDmItNDBcZe7DhNdPZvEKo6xIIQJZW4a2X/E4aQmlbuEQvbvVMpBMtRmiYe30hAvdiPkEiZAw5A1sVry+IaeFhUYTa5prJDqQehz4s3Lo9NDBjZp6Nn+AQyS9udvh8ulC6ObdC7f3XVDcEfgDR7Q1gJUWUoR53LXaXPeWxHU4yHyXVBdF2Vnh46YmQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702680128; bh=6ZYf5huaZmC9UCs9n/eiabsPtkOvK63TXZvyZflzODb=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=WfNrh7/wdS0hnDSscJ3M6HNOCYETyZ4YVq6LuCht7eRVKiihfnUpa6qCD2g9MMJplOKHHKSHy1JtfW3wFq2rTorIlZ3PBWvzzzt50yVtxKdJ6D+ea1Rh4TdYqzifxl+aQWc0wcettM4IrSGm7F/2HDsBtiJ/kNSq1TQqNKL+FtBocRebBGttFZ3qbZxH/rT3Rj7Jy1Scn4xHOn5JqwS9x5REhY3BMu0d6NuJg4kELUbnidnWlDwgoFCYDH+RtEQjwR96HGwTB1HoWFdrQAI+MnrjO2Of/RommYQEEH0hMEg5Dber3kgQiBW00X5YiV6uqBqfj9iok6RDvufV5YjqbA==
X-YMail-OSG: sVzvT_YVM1nT2E2zuucRPLt_6v38mKH.6L16gk4SfdU7K03jPqXodH6Cii2vDHz
 kmdMC5Vrn.lhaWfP6ZukFVn1bU.c31n6AQw.vRypoQrzxbOQRnupGbHTDGRWqcu56V3ezjbHw7Qo
 TKC0mcDpDWVvTZdFnt51w94XIr.O9rK1fj6k5VLRa.faP6X4fsSD9StpxJ1tybq2qVqKae5zjNxS
 iXPX_LMUjr1vXAumcSDw3JH6xSWiRctahDp6O0QlWFBPHrwW2vySLeAJAhDs.WCw0erLwfDVdDfO
 CocLyy.cCEeFSjTfUMmJZbbdo3yUppM6xN6z2B_v0NVr0QTKEIzqHrJAu0gfaqqm4GWmSQhhzNaM
 i0S5XKnvKwSjkjaRz46rS8zkEzu6lGIYbJfzGnZXZMNGbCV37vMM6Lp5M3aoGwecVK5K7TmioDpL
 lRfOdJDs0Ar52r._b9PpE0E6xRBgfZPZbykEJx5OEEVtgmhBhmkOqVu3TH6Bc6TR9zkcR58cUGDu
 31ujZHQUnDy.zttBys2HcyzXJTpzYU8MFLkzm7ArVNYOKwl8m.czF3INKgPrWD0S9Ez8VsHvFp.m
 rqO6rjLsJI6Cy.ZGdP9FCh_u9Ib3WBx7EJ8kSfOyO3T7tUEYugwOgFgtoH7mCm9md1agNqxbBvTm
 EpGBao5xJPtPWDlkyTZ3kzXskDBdYQc4oDYWz2nFpnCAoVMZ6Fbt8b1oKP5EoSpLSWhD4laX.rVK
 1QxlORlM_HMHq7hSYs8_GmFdgouWyeeiMOFvFoQ_LvH2zj5Dcq0zWBhM0rBQdyraXuSsWJfzw4Xw
 AUqWfTmueDaolIFAz8vEhgXj0fXINeQvamPa09X6CVnd1iP4Sl00sGckLuXf6p.mI_dPgxA_9ZhW
 oLgmt52wf_VDnUg5BTNVHUEvjPbjTpslA6qPkcy_uZ3AVA6AN8prodsyf..imriaz5tabvvpGuoo
 t5uehv8O7o0QsBBD0bVz.V.agEfKYw9lt9r35OlVLZPh63IMOfC4v8I6dFQfHe_cYjKs0MjcstZN
 GlcbNXxguzwuqnXf1Yg2n1FcXedIW54SjkVKOk45uX3rzPAgkLCNxe5zTnqVaoN40HI8hCzS.Yf.
 3ZfLyedzvdfxSKaMQGlx8MA0LQgp4.oPRxIQKlNP_YvAW4AMi8VlQqLluaHhYSff08.gDLwKW81s
 TiyMUgYzp1e67ouzToRrTyhWM91oYd8KQK6tIXNrWeUU39lAzCVy6h7.rv9yJVAEC6QOT3bZcJ5a
 2yrnPAMtZwJoVJ.lyT3jEHiLxk3wLUFSbucJ7xRGe1FZ4ZwIRe8n2z4UCAflVeo.IixCpHSuKvxJ
 er3lPHdGthLxpx0WGNn_yHeUuwwwycugYINk038qV4dkcSxxwuuOwV2M2WFoVpIMOHmde6kyTK1M
 hAgyUDYd4qVuZK07wHUEWp_EMeOGfbAGztOMNq8e._jWq5pjMExiNFtTYRPOJNcMX_mcd1wS0kkh
 aixWX21YHLnUhsQwu1qnwTE4g561MjHOGTHMOXtgONGmV1o_TW6PodCFYPj9La5rRB9G8R0qepSp
 qI8iWNkowDHnl560qib7Il9aKHehcI49bwgY0omWbZTJiHANkz7RwEjywIj1Wk22F9Hk8aVbQsfA
 h.CUbNA4dK8fCUHjSH0eYrJHZz.FXfstkRxpAYRxd8O45rieF3TtmfB.HL8Wx3R0Va0v2xkFcTmB
 DXuZTJnjaOQb9S3qp9BE7S7_knMcDHH7CXlrZaOWrFFXyJGQOiEmA5m5Fcuieyc6u_04BleZVqRI
 KZAqqOEwoTLCorG1KljQ8K9pJ___7uZMN3jaVXvpUjVnGH0FnK.V1qMrVKD24LfbzQ6z3WoZOpvI
 NPzVJspsYY27CIFyhkK0jsuKZ6a1IQ7.Y0BWf1CNt9DvMpEpbcowmtQtqDuvMLD132co54u27hiu
 exAt3SzUyoDTDeKeVMlDKcoSfMx5vc5d2nvFQUxIFTC.zWD1KRbQePXn79aMIukqFxtXruB.Bt04
 .RgMfLlarCgEHiK_AwbpAFfqzR._hXfPSeetQgZndXEL73_EpZi.iMEcLVugyA3GJF2Oxm7Cnxxz
 58kmA4D1lH22.VSB7WEyJ5lkLjyWZJkDeAkA3co.uSR_N8yfbwCAQTROPvlu6099Mrbyej8czJ3Q
 dSV.VZ9TEFLg728FsdmttKByY2ostFvG0W_kbsu8O94bvPzpYW6NLs0sejUEcmWjQc4LFsT8nm2a
 lwcPRMIHJDiKkb94UgGBeYriETfcakAZ3PS9VQ7HaS0fUQxyxNYHUrSKzLei1q4zHZhf1o4bInIo
 0m9MmQRbxm8osGYTU19aawRgdBMDJ
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: d15b9472-9cd2-4430-a308-5ac4cfafeb7a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:42:08 +0000
Received: by hermes--production-gq1-6949d6d8f9-bvfr7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7cf3dab1b010cdb86f7a13f4b7451804;
          Fri, 15 Dec 2023 22:42:04 +0000 (UTC)
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
Subject: [PATCH v39 32/42] LSM: Identify which LSM handles the context string
Date: Fri, 15 Dec 2023 14:16:26 -0800
Message-ID: <20231215221636.105680-33-casey@schaufler-ca.com>
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

The security_secctx_to_secid() call can only interpret the
context string for a single LSM. Use the first LSM that supplies a hook.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index 8469816c0472..8576121fadb9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4248,8 +4248,13 @@ EXPORT_SYMBOL(security_lsmblob_to_secctx);
  */
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 {
+	struct security_hook_list *hp;
+
 	*secid = 0;
-	return call_int_hook(secctx_to_secid, 0, secdata, seclen, secid);
+	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list)
+		return hp->hook.secctx_to_secid(secdata, seclen, secid);
+
+	return LSM_RET_DEFAULT(secctx_to_secid);
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
-- 
2.41.0


