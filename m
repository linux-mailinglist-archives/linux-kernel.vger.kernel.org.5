Return-Path: <linux-kernel+bounces-1751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CD1815386
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ABDB286641
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7585218EC6;
	Fri, 15 Dec 2023 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PE31wjlz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8603318EB9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702678990; bh=3gRmOpEVfGBTXm6cSKhWruAudxiwq20dQIpn1DBXMZo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=PE31wjlzEmZd4FphqG4EbQ0GtaI1Tui4SjzO4NYGegKopGP3vBleFgrxOHCTgjCCdDROw7qR7QNkWMnPs0hwCvh/cJLd8niIlMUqtu6z+cI1kbMhJnIu95cAptRmQpP2NDaiRayWr8H5A0s7yUkod9Zb7tRPjaPu00f8L/s4TfvHWEUO6ZyTYMTgUbb5oSztXFZ6mTX87NESL7386BomdlLeUpXN7ODLo3gP4+n0KaLc1mIvXvE28qCmgrICmD+m/WXOMzGrgsXZHZno33VXGnml/A0lv9HsxfsXtA7UNj96OQ6fmdqT54Z5TmL1SHB5RTjLwdjuMUNYeacnRWMuVg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702678990; bh=H5piEox20lILUqaYg1+cSexnAfnzjYEDZOBrX8aTAyh=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=IF0bQZ1+AKuNEajnLXSmOXwOBIGFlvyS3Uo8IGwU6zGcgR/Y05bLbCgvoq7GjsGMLXbczHvvtrMm9vAT7EVpDlq98Cm9A8+TRInfVHENmRb/85knl4cNpCCdO+/R/BPTzVnjXnw7oztHmSlMsFJ5lDM0pA7XQTuDmMEZjjEnOc584EO1mG3P4jmKB28Y+o4W74j3a1C2SLUac2N6m2nEiUZsm07s9d+U26uY2AjDsWmTkiBYILRfosX5a9C9b7rDPm/PJ8ClHTNwyT+ZC1wvbN6rsNNOi//36DRCLkWuOQE3b5AzAPFqOAEbiwZcCyzpxc6iWZ4jYw3NoNzrHqVtxA==
X-YMail-OSG: in9VcAkVM1nNitpu5NpH_n4mm0U_l6svqqhF85jMdH_7ilyAmu1rkFoi05OhLyL
 vA2DPRBnsj3UQo6ScA9nT5kmtLtVzAmv_FoAcE2AtmnDcZ0A1s79tGtkdnOJnWZ2j9t_Tj7zBYJx
 GZqe5S9QjMnYMvexGmDsv_Xh72Cr0okdU40E9Qs0kgE6XfZflsLALcmFV1Q5L2Un0WO.goDHtzKU
 AlauAwQIQi9hDcFgLUH5dXTKdq8gxZnDQAp1l7KIgRCT5HQA1nPCA.90PZ4yqUV0GGs6KFKHm5.k
 g8dsB0H2nfAmQ8LWNhg00Gp9IQIBintUE0Eag3IqcFHLYvvipMITTq2aPRgzwydwZ1yS4kprRV4z
 MIRFMZRva9KrkIWhD_fVEa1ngOsZ18KRfmBjdGmZeXC5k4.BaA0ZPcHCixUCw8Gdvhw7n0VnRctJ
 J0tnRpHywrv17xmMiRw5gj0yqCxnWCaXRdusnMGWc72Xmy7MafCrW79ZR64CpUMp7q2OXEx5RaqH
 sh7j8_eAhtG_uH.so6v6sX.hi8Hew7OWe38etzW5xCvIM1nReFftAohDCPg0mKr.fhhKJJlkED9e
 2V7aG9DMEkuHLvSIk1Sh8TxxtFx_Uq9LPip1HUgaNX5IleUaui6RhrPt28X6QvNLSahdMHI6mefj
 _rXI57fa7P4qz5ygt1TNm4TiXexNZqV5ppZ5mzzKJxWj.AJX5S.WVjfFbmU72PcdQ1yhznWfQVb9
 HjBNvl0KFKughXKccEpNFuHLWYd4iKjMekdtycWDMzOA4lfMbX8aNKX2lefBTnrKU8NV1lwmjMRb
 V2xyLyTjI8.GKaZVwpqkRwsvvTlcOqlH0Tam1VpS02un1KhbzTSDIRBPuG9YGtnc.jSYMAgtn088
 GbrLWG2cmdnL7P.tQxgxzIaxDDbDhzr08thiJYWrQSr30Rv8H6.5m3JGKE6coXRSGhzAeUeS1iNg
 6p_UuE6gk1wGHzykYWXZQhsHSysL65UhPl_uXXO4_HQCvhgJJ.TmYJBkYSg4RWC.HJyCsWhX_Qe.
 8TCb0YN6dp2A9vFOpyeGLIsETGufPtvzmr8YOWAIUa2sgg1W414bedYe7CpUOqkY_JnCXzM.Sm2G
 yGBqoMYzG.4W68ivwhfkcZJ.qCrmqXZBQzIOcWRx1gBRL._wcBss8qwdG8tG1YuMzylyxSUdnktF
 bIhIQAzZLxUCn9QscEEopakodEX.ZW7MFCsYrHwxY5LEpr_1DERnWJtCAac2zC5NfzmSZjV3fK8R
 0nc0CxZR44m45vS2DE3Aa6a4WsokBjspVu2PZo1WzqzdzhJvZP62RrdEaorL.37lxgu6Bz23cCQy
 ArC9h35vyGlaZ9PY2usMllVU_joS96ZlnwOGVvu4zXjvDYYL_bxCISNbVXQpqgIsJJr4WFvP2fdS
 mwkTLCrRx_u0uV1tkTyt1651daEe6KggD9y7L_FNFa5bEL5QEDavHuJ1U8KA2FBhOS7c1Jh1wUcV
 CP4NJ0ZGRweBttfuzT.7585aZgi321RIAJq9YwCcCDDh7AVmD36fMXxU9cnhHhpUIRFzoes8PSRv
 CWvAo44luerGKlPQg22biAS_1R8nr_BhXE4kp5JJktr48M1ZqoMbg..tNSzrHXD9jpB0b.8ofvF2
 Yw.Erq4KSUALk0WJXuvVMz24Kd.PgLuTGWNHKKUcWAF5UGElFi8a26wmccC8OkStdFBfXIO3SrsA
 TxU7XJoPizWfgYbdl8vuU_xUNj4UlpCyHDTIAqaFdIBl_edrUlOdlV49oyitxO5ubUD6ZfPfqh1f
 b.E5bPNKtJgP5clIVTrHKBggnVTNCIgS5932gv19kMBme1WomTSBvYlVv4Ln159mhy1Qh1ao3DN7
 QM1RH5VKQbVhvU_veiE62FkTxYroaDs8FEkyo14HMq0T6x_r88yS7oLLz2sedmcQxKhCExyBZFkw
 T0A6C3P0NRxTilpVf1gFB1nrNYSChfUIMk93kstuOhEnsUhinjmx3Umh5l1duuHZWL2zbN4scfDi
 pWXnyD3ochJz52.neAsl_S21n3onqNAbPTqbZ_H6nM1nvii2qUsmqP1E1stkjhXbst6FOsqoPkRn
 cOpdojxFVLHFeGFekAverOZ.qL_U2HsYtAU764OPHW4IfjVZ7al9OyiKVPL4RdUPkeSiP_kUgnNU
 bSSLgXu7uU28UBAn8DKbbuzXiD3sq7h_al1shIA0ZmP4NuCp5_jfSVzhC9dmmrCSk5rQxko5Jsmo
 U5OZUPnRpWBN9WIJbcAz5yM5TdCvLrlfu9ra8rLWr63Fh
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: d4803ee4-5cf8-4a92-b582-81ac2b7ba410
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:23:10 +0000
Received: by hermes--production-gq1-6949d6d8f9-q7525 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7388d6c7a490bc7dfaae35982f4a3b58;
          Fri, 15 Dec 2023 22:23:05 +0000 (UTC)
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
Subject: [PATCH v39 09/42] Audit: Update shutdown LSM data
Date: Fri, 15 Dec 2023 14:16:03 -0800
Message-ID: <20231215221636.105680-10-casey@schaufler-ca.com>
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

The audit process LSM information is changed from a secid audit_sig_sid
to an lsmblob in audit_sig_lsm. Update the users of this data
appropriately. Calls to security_secid_to_secctx() are changed to use
security_lsmblob_to_secctx() instead. security_current_getsecid_subj()
is scaffolded. It will be updated in a subsequent patch.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/audit.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 16205dd29843..875df831fb61 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -123,7 +123,7 @@ static u32	audit_backlog_wait_time = AUDIT_BACKLOG_WAIT_TIME;
 /* The identity of the user shutting down the audit system. */
 static kuid_t		audit_sig_uid = INVALID_UID;
 static pid_t		audit_sig_pid = -1;
-static u32		audit_sig_sid;
+static struct lsmblob	audit_sig_lsm;
 
 /* Records can be lost in several ways:
    0) [suppressed in audit_alloc]
@@ -1460,20 +1460,21 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 	}
 	case AUDIT_SIGNAL_INFO:
 		len = 0;
-		if (audit_sig_sid) {
-			err = security_secid_to_secctx(audit_sig_sid, &ctx, &len);
+		if (lsmblob_is_set(&audit_sig_lsm)) {
+			err = security_lsmblob_to_secctx(&audit_sig_lsm, &ctx,
+							 &len);
 			if (err)
 				return err;
 		}
 		sig_data = kmalloc(struct_size(sig_data, ctx, len), GFP_KERNEL);
 		if (!sig_data) {
-			if (audit_sig_sid)
+			if (lsmblob_is_set(&audit_sig_lsm))
 				security_release_secctx(ctx, len);
 			return -ENOMEM;
 		}
 		sig_data->uid = from_kuid(&init_user_ns, audit_sig_uid);
 		sig_data->pid = audit_sig_pid;
-		if (audit_sig_sid) {
+		if (lsmblob_is_set(&audit_sig_lsm)) {
 			memcpy(sig_data->ctx, ctx, len);
 			security_release_secctx(ctx, len);
 		}
@@ -2389,7 +2390,8 @@ int audit_signal_info(int sig, struct task_struct *t)
 			audit_sig_uid = auid;
 		else
 			audit_sig_uid = uid;
-		security_current_getsecid_subj(&audit_sig_sid);
+		/* stacking scaffolding */
+		security_current_getsecid_subj(&audit_sig_lsm.scaffold.secid);
 	}
 
 	return audit_signal_info_syscall(t);
-- 
2.41.0


