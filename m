Return-Path: <linux-kernel+bounces-1777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A4F8153CE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519EF1F26809
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B137218EC3;
	Fri, 15 Dec 2023 22:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tTllBY/E"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EC118EAE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679937; bh=9keQf9g8TT1WOTQ4FMsX6B5QIMK24lZJ/xlVXj6t8WU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=tTllBY/E6SGxl+s9lXFNHY+lk5xjxPuWSo69GbT05A8S6sbVEqBokVFaoZrIgEA5jIPPb7YBUrjSfIxQPUqhBSOgd0yEFArlfcRgEuxbER2RGlQddeuKlHAKTDMSB5XeI/f8WmSOhfydOex7RYluhhpkqlsOvtpUKLsqfQrUQ8MSJxMiAKg1UCQR3YzKaoXJmjEjOdhVF1BOHd5nAHT2394anIsFJf0gN4aDxu3koNeWs3OUfyw5u/3+qTCg4QcWSeibEXlEmOExUuvkNyOQnxwwlBEzpuWe4gk3X6jfi3UnVr+oixRohEFbP0+MviJfiuavec3Vwf9z+cczQzRZ4g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702679937; bh=CQqsukU7gsFz0lAYspeBrRZglBXPOm741QE/iLeobu2=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=gZOeQRUBrPQk642wfw4ZWb9K3976Ch0P33u9+zRPpFwsLefkTSLthCs5kE3b+HrAX9j9IK2gWL26RDmdApeBWdu3DTzODujcsPpSEP8SDclAVfbqcVk8rPL72oyH+dXAMAmluZAj9WB05O6LCXA0d1WqiJlYiOXjg3Gk5VP5jARV6nOTbofcwaP/z4IkedNu60XuIuEWd/yWpAAO0hDeZ/exOTRMSala5W9VioWwxIh45ZoYq61kUJPftfuCeeNe90TU2X/+vI8QOKbn9RvJefY0Xwz2XWXDzXMCHFwWawFDFHLiy5lD9cb27PcCoyOl8c+wYLEbWJfkn96kmWxJBw==
X-YMail-OSG: n5fF0doVM1lZUSo11zSkzVfMSBl6JA9JVJAUwgdHa7WOiPISWCVuhE5ZkQaGJA2
 rVPFy.ry9_zVh_EGfz4VEIFv2e1lvYZS11xfPdYjRkpbvgdXlLaelXMBebLpGm2Jn2UAOB8gw.X4
 b9qzT53D2j7zQjmtVCZL1MD..QGM_hNTwyC_FuFzAIFxn3_Rpz3X2NH0ONBPOoUO3i_sc1VQyZFq
 FvdbPWxcCoDG347hjUHgg1IEdKcKV5Ad5WLMeM7WxNlhGoIDJXY3f1CVVkNNP567CnvdnIhGb7fw
 0ezXWyh5X7Gr_VPc3IKpVv.lfUwNV4lTBH6UW7jucj2XxnBDW1k2cDzpLYQ1.b6mgKg7XMVbNTrT
 ujlqzxg9D1v6e3vX2zPk3XQWMHEihYyD_OLHDCHmvG6USTB8fYha1YGvWdQtefmqcmIacU1Rr6hl
 8EGvVN_jYUPWRGHcjWmf5xRhj2VtP5eJteVnRjHnEBoI34l0mImUTPK1jCeoA69VTSy5dG_dIkf1
 lDqy42946hUi9hzLKyx1qXAo3L7zq0fI.5kCTHCYrJtKZqWJvY3a77i0Lem4vt.2nfgsuNbp06sq
 dc.jsXUdPwYrGHFxq2KDfu_pwtefAyoS79WPqI34c2d2pJ0YHhmLQS17PjgJMnpBfTH3XjjMVBn.
 vESvcXo7k7u7kNIzvpzs3Wf.s82bH_AMEZlJgzjrwvQ_SqE6oU6T_vuhokf3Qv2F2dtZ0hhxeute
 aAR4v4NgX5xhqvgCk.kmiQhvMd98WOPq4Al8lRQ2z6h2X_LrV8VDWB1mFMiMw2u6X_jhtThT9q8_
 IR6V5.Aa0SIcUx1hrdfvBoBloHHQuxzblQZsOz8fHSOyt5S52Jm5qWmMHbayrsTLLBeJEWAFPOiH
 99qgSs81nicClkYlXd_WUikXA5WAjCb_J.Mmfa_qHHKGsyIG5qGURzKms6HNm3oRQnV1kB5Fmc19
 6kHg19Bwz3KhuuMNzrBW4yP8mnyR_MqcMK8HwqIEm2BR247cMh_5uxo6mv1pDgvOS4Ss_FWO5O9J
 9HWCSkFclln6wFhiKvrhTWugMN.lPNd_Ylou1vvXbLTqku3YjM6eFELrcOkVMbFm6UMQjiDRSvnh
 FEqeGDy1P2hPrKGdm0Ju8yFD.Oft5gJNGzYyTZMPwUhE0he_YBFYY1d9WSi8wne73CUWQEqxMVmK
 i5Xu_npffOkIGd6qdFVHtqx_tvzqYgQEDfJRkPvuCi6yOAaXt_x_Zow8jOdUrXNfF8rUGmzq86bj
 73OJ4fU1..nUiMoKPe3xluLY1Z.dMKvdt6V8kfKlTmr9N6KDmtz3VpklbN3daTDaVSfgYzeyn_W9
 N99Lx.SST080lpDOFE2toRhjVhqrcKvPHICD5pzeFv.i2cHloU7qKbD3TXoYwmgaqc5sOUu1NRQM
 CuyKPc.kdU4T5S_fTIAiWWWZjeRCTFpS23YwjSdXZuMcKYNwhe15.317.H9UBK.u_UnPC_FvifgC
 j91ACufAmzbjPirK00LKQpPCqHYxpRsbAfUDSf1Kt2w4KgtM9qOXHOHhdRGKxVco1MHIUYKoBLvQ
 s2r1C5rVEys0e9uTrFyMbiIo7TgcpjZ6dvfHIXj0OfuKWHkYMC943rt4BE5Ny0Z8VNxeDzkvaaPm
 m.uo3cg9ROS94.LdctzXdn1BwYoRDS3mPlZBtlhqE6JAPEv.uLMgedz6NTWsbReCj.zvUMJt9BBl
 UuWyR.9uM_ObAmVNDyf8Pb1oUx..Lqq4FgyDDzD0rpZnGmKiuN_eCX2YsUFNDGV75k5f6brgB24u
 w6QXaxwrMahQ04Upjy00dFA_l0e8EjZlnft9mLgk8dStViittzdrR2DkSShmokx3usCgok69T5HQ
 qWmygj8DYb9g1LgAlnqmnsB.GzHcfmn79dQks9zK5nmSsuAI248WKYHpUYqsjcEN_aZejC_jvsEJ
 V7FAGymdR.1oH5d9wps22MJbgV7EGMYTeLOu_YIiJtMsWCUPksV8OoB_7JIxUDKofxq57X3gvcec
 F8uFpZ1oubMgiOtsH4wCLaI6FgNI71IZ_FAQ9vdnVVdaRuLSZlmx2_.IjRIzdRdjLydaAs1bkpRu
 6Sv1PWM9y7GCdIgRcI0.78ua0VaDxjx7PA.WyPTF0OV5yQEY7DTHxYvIJa8R1cB8WgBmIew_kxpB
 NwDDSmErTFUSrDjvFfB77Qcv3DWCdOEzUyqIDPntngDo8EWeYR8dGVweEqTOypceJCt8Ic06xBGY
 z5GqSOxIqVlm9fxNuS975PVsqfbBfAN8OtxjQqaEVu2GO4SbQQJm5.GVWdHf27Ei7t3NaPssIlQc
 ZT7QK.AXplPvt9cevmWJyH46VHEM-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: dd58fa10-8b58-492f-8a87-50fb20c791ee
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:38:57 +0000
Received: by hermes--production-gq1-6949d6d8f9-q7525 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 522caf1ff66b851381e701962a25c33e;
          Fri, 15 Dec 2023 22:38:55 +0000 (UTC)
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
Subject: [PATCH v39 29/42] LSM: secctx provider check on release
Date: Fri, 15 Dec 2023 14:16:23 -0800
Message-ID: <20231215221636.105680-30-casey@schaufler-ca.com>
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

Verify that the LSM releasing the secctx is the LSM that
allocated it. This was not necessary when only one LSM could
create a secctx, but once there can be more than one it is.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/apparmor/secid.c | 10 ++--------
 security/selinux/hooks.c  | 10 ++--------
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index c9b9a8d90afa..1df08372bf1b 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -146,14 +146,8 @@ int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 
 void apparmor_release_secctx(struct lsmcontext *cp)
 {
-	/*
-	 * stacking scaffolding:
-	 * When it is possible for more than one LSM to provide a
-	 * release hook, do this check:
-	 * if (cp->id == LSM_ID_APPARMOR || cp->id == LSM_ID_UNDEF)
-	 */
-
-	kfree(cp->context);
+	if (cp->id == LSM_ID_APPARMOR)
+		kfree(cp->context);
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 656f25337334..a6deccbbcc40 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6616,14 +6616,8 @@ static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 
 static void selinux_release_secctx(struct lsmcontext *cp)
 {
-	/*
-	 * stacking scaffolding:
-	 * When it is possible for more than one LSM to provide a
-	 * release hook, do this check:
-	 * if (cp->id == LSM_ID_SELINUX || cp->id == LSM_ID_UNDEF)
-	 */
-
-	kfree(cp->context);
+	if (cp->id == LSM_ID_SELINUX)
+		kfree(cp->context);
 }
 
 static void selinux_inode_invalidate_secctx(struct inode *inode)
-- 
2.41.0


