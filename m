Return-Path: <linux-kernel+bounces-1792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 140BF8153F6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382241C2482C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0018C18EAF;
	Fri, 15 Dec 2023 22:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SoLgQbXf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7CC18EC2
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702680508; bh=gRUGzkRraMOtA1ZY2czwdZ1ExZidr2K7SF6xcBYCs0k=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=SoLgQbXfqsl6Z2ppYzwDp3aZFtcDuN8Ap/5Sb1//P8N77OSclDsUQWqP10Vm3PR9SeDuv/9rIGT1QvxBKQ8gQClfO5tSNr2OTxp3BhQpFO24a91x5aEhahdaL0D3QN72a2pUbiFm9YJ2zTwBtWoMWARzqiP/bhOb2cIxMAaAas/OXH5+nL1Pfj8T2ooPdVgEJEOmggjYwYfaxnlKx+hDvntT6KeJ127hL8OEmyP4hYXMhyrwK8TYne4/KfgAKpw5YDrrY/tkb478YK30kDHL0Z4a/0SBWNNaH5K1/A29R25uoyFHiII5zUicW5ngsYjQZkNRMyQlWMCj+UifYZq61Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702680508; bh=TG4+ZQ3eMtuA1/dVf2s7hxpLGJv/hfIBvoPy8vStqlO=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=AiS5ytJpZkKbJIzmyPftaTWIyTtA4NkNcmuoezVuMs7QFC7tzT1P5zKTsILuIWezeFakwo5ZVmMIiRCeO/NucsN4rixXXf1xBqdA82+fooKzdGq8cNXQBJoc/cqpTiRSl5qsXOX+JLIVO6OoLKj2eZk3GL+m8buGQmMJNmlrE+wpIzQ7dhZCed5u+ovvketq1RwnsyU+1lOh8G7Iw/EJkrhU28Mf5ntl8gDelpLxiGtj7Oz9jmHwYZ/lhM+pDj0aDozWIr8cCGVxR51b81CK2rUTUUR4PqGetu7LmUK++otCEZPJtfBXvTllxja2hzV+Gz/fmc26nTfPrm1tIxBbMQ==
X-YMail-OSG: Q6tcmVMVM1kHYAZa6zAk9MP6WPMoYIpea1s1q_SdnSkihAwjvLxe1ml3z7.Ote8
 LN7Rm2bGsrYjOTR3XTUfmQ5KlXhw3ndhKMIDEU6jq4PrZpbMJp3EKnddjf4EqyV4tfUhTvAEyuhb
 iSTKUlodXEKQB_.lead3bPAMpJgMJjL7zQh4EzFO3G.i2ZhYuXWShK5a6OmqQVHNz2JpO7b_vxoH
 ZA9q6o_yAtdQgkzcNx5SzUeCKBbLtT0jDmrSzZLl_JSau_E4L783gQ3eOveBYnVOrY.PVwWDQcbc
 BvIXhLNggN_MzIEjP2XtrIRqD.5Ob0HNigbTiGRFcHdBO_DiugA936NPg_rTNl1uZotyT_42uCzo
 91Ttz2KMb7sctJdbAB32cn3KLbXO7D4nkC4ziD33rq_0C3exgDCwFZbZEdkBRfcimujKuSTlje0H
 uUj7XgJrb1EoaTs887Kx3MxE_c1h3p1svS_.sSYWd98ii7p.eyJRDJIE37ggJVPWEoVl_uRccEi8
 LrNtz9lBSIj.st0PbvVK.gGtFSdz2PWYVshUXuwnx.PL7wfJgKWz1h.L55XZrJs5bmUTXd8TS94L
 xeAefLZMUEYUwq1rDIDa5z9YrhKEWn8PtRp.fwATzl7WpvK2d6u.1JdysV25mJrJkFXAH2cjnna6
 UN42QDLRnK2cbyuTFNcZds532kAEhRzxqp7y8KPQrzVP6hglhOCHOf0V2ab99.gmsODf_aFnjxJ2
 1JBL_MGWPjTNASsTSrrVVKVxrXd4X4GOCEmToB49PaXxTw5ePAGHD0cxUt2aTRDOK4BF4soL5wjA
 mXTo3oZu061MI.4Yhjcm8F3aSZfPnjV_tqIpYwuAcYN_WAxAABW3Yj_d.YO4ZZkxvhK6Pp_v3612
 2lLxo_1Gr_112LmqkIt5nGjfq1XavKwafA.xoF2UMP0vDo_4R8agZ59nOqQxbV4VBDFuhtAAHx2u
 __VzA_uhuzjlSZDraWYteRUABQ0yZPta9ZZGC_QhEGxVPaxGzbbGem.hZTVcq7lZ2DXQtHVznIw8
 12DWT40cV6KLw3D2dEqQ3Yi4xSYq4aAYxziPDAHBe_5ffDWIv5_dROJDqMGHpqWGJlkFVw_Ssfs3
 ZQuM23k70wGHezjq21MV_X8ROko33cwtlimxB7cIrvMC.Zm8K3OuiTa0LrPXL.fLOHvpcHltde2c
 oKl_c1O8X6P_s6TPCXpFrxaDl.MrIlqyFiELedHrFV6LbrrhOwmO16SOacuM1bgM_ShPBcK1bbbh
 n8WwWGjYlCwYfhSC8BjBXRz404iJOFpN8hp1bY1Nem70ooG89Xvr6xz7GrS.uHY48FUR6OzX5lP5
 EEKgJl80JRw_95Wc1zCfDp6luPLSRteX0hy.zYyeODyzHV6geJaYa1scbRHo3eo6B8FOBK9QPzUq
 _4zDV2F1oVMRvGdKWYLEYqmp2iq.L8xgh9T1_oJW.0V0fOq1DAeDIFY7Cfz3_FzW7vRwXnQDoYiq
 ZXLbj4_uN3ibmDZmcDngQ1hJmqSJ2fzC4EXUiuBPP1mTWcukKKN4ELqQBeNxV4ekcrbFBjA.7lIi
 Uy480nNKhBPWE0dMCVFoxielzfIkEPpw0LKL4LhCSPTfL4a3Kc71POymfJ3LqcMYe5G3vSK0OlDG
 UcRA8pKx16WM0ixwU6Oj9jkZEau0KYWcu8mQJsIZyId63f32s4bVtAoHRrjCM5DHLFkYGfszvUkU
 tEhdCxnTpBa8.oH5dzd2QBKNpyRlU.ZlrlKwWoFXXPhsSVuxBOfQFre51JhQOC49qXtOH6R0D1d4
 bxqkdxf1WRlyICf.XQ2.Ls66GHHlScfavr0x7MeD9HfrZf45.QfGN2mUJO0V1coXxRHavJJfG6_.
 f6mJFXVFdHofGu1Tjx.3EnMyCtW1poLDpEeyJ3HcVHI93IUJl64JhyTrgj5JYWmb0w8pElJPliYr
 lQFeZU0l_c7InV7pOPGTEl29c5JMc0H.DaG6bmAs7bF9jYLKItirwcAMt_mIf8aPSAKlpZmuMyS4
 7KMcScAmpPRYYrUz8NdYxPH5QlxdhsSblvuO3_y1j97XoKoa6HHpv9YNimu_KX2KejUrYiBS84RT
 YwoBpac93iUPAHJuIJYHxPLxWmktzvDvTlYso7F1bOoh5NyoNl1c.ROsMmLdyju29rQMdsKftTl5
 yOIqXD..m4YtSHLvS7F6iUpL0WRSn2WF.1niPrGj2Rhtfe3haV5J3TRBeFON8BYB90m._Ruw7WCm
 UvkWglIrhmhPexWxIb22BpNrrKqVhlUyV7KtFg77tcJWtHU2Nfae5zj8NK5Gk6XJ5kka1B6lLwVy
 GQuI0MFegwi0D_bEa30wY.RcVMIY-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4611144a-9a8d-43bf-b7cf-99a84dc30b45
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:48:28 +0000
Received: by hermes--production-gq1-6949d6d8f9-qkzts (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 98319ae8e5188ac722d06529a3337566;
          Fri, 15 Dec 2023 22:48:26 +0000 (UTC)
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
Subject: [PATCH v39 41/42] LSM: restrict security_cred_getsecid() to a single LSM
Date: Fri, 15 Dec 2023 14:16:35 -0800
Message-ID: <20231215221636.105680-42-casey@schaufler-ca.com>
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

The LSM hook security_cred_getsecid() provides a single secid
that is only used by the binder driver. Provide the first value
available, and abandon any other hooks.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/security/security.c b/security/security.c
index f1bff6b5b076..504dfc6d05fa 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3157,13 +3157,20 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
  * @c: credentials
  * @secid: secid value
  *
- * Retrieve the security identifier of the cred structure @c.  In case of
- * failure, @secid will be set to zero.
+ * Retrieve the first available security identifier of the
+ * cred structure @c.  In case of failure, @secid will be set to zero.
+ * Currently only used by binder.
  */
 void security_cred_getsecid(const struct cred *c, u32 *secid)
 {
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.cred_getsecid, list) {
+		hp->hook.cred_getsecid(c, secid);
+		return;
+	}
+
 	*secid = 0;
-	call_void_hook(cred_getsecid, c, secid);
 }
 EXPORT_SYMBOL(security_cred_getsecid);
 
-- 
2.41.0


