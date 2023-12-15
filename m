Return-Path: <linux-kernel+bounces-1788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E778153ED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5772A1C247CB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FEA18EC6;
	Fri, 15 Dec 2023 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pUqVE5zK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE3F18ECD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702680411; bh=uKhqCEuW3HN1RNrz6vcbzbPS+KDRSe9EK23D2ZT30dY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=pUqVE5zK5Q24QDjcj72JPdGLPGuFtb5aEJ+94Am5jk8mhrm2bPlXIlZNjxaMrk5OI2K7x8HT75PpKJzxNOo/16fNbuok+kn+mLFuipZk62K9A1anX7yLmy92osqHIxNa+Sm8J0KamIs36bNO9OV9+j1n2aCAULN3O6M+1dH1yS9xQLvz1e7QjJI0OkwX6ZjYj+z74Nh2bmYOqWN5ecR7eLyCZi49xujFzU2UlGxoqVVcymzGMLRTGFe7yNDvO6Rx3Vf5zdOt9SMW6f+PlDkXatTREhU1HvqX7+uTe8Wx/iDJPmsT+klNEba8oCM+PJ6QY5HLyw9VDdSfQ8CYBcpBsg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702680411; bh=hsPYL+9UYxSrSAV24yoGwudNIN6Iewr2VgfagLgtaUe=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=eLUWk0q0cz2fSXII1SeIEdwI7B04AmVusZ8ZQ7nP7AojHlDgl/Szzk5yW6pGfi+rIZDwKIK3iOF8yI3QHUz2ie25iZknmoCZ/yzrryf3VHIQDndZE1BXxasfbFPiX9B0xn7rq6Xmc0HIUjkCvFkKhJqBXronrwkAgoVfUv50m/Ig8IAGIJTZ93tccPRHKfdRPhiiA01+/rD3b/mtgrMJrqavcUXuwi8LjnfigWnCV6nXMSHZHWr9WtT/6lK4pOq4COdaLOU8iAbhTNVhT6mzvkM1psh05KcUO7hVRliwrhNFqu/1WlaeKfgaPVMpWnSsvY/BrmDAzuDu92L+rYFUNw==
X-YMail-OSG: uJUDWOcVM1m4zhcGaRvcpMdNTHEv4FUcZqYzHtvKQ.7DvWqiv7gZWn0CVgYH1tg
 mne3Tw5dHf02xeHUooR7BCg1xl7kZTWBevfm.9keJ1Uk9L6jyQc2PNSWWXY30fNkQThGV09Tr_Ah
 ZqDlJvsICJKJnLyIPQtP_hSvAAqlFOQwzpzAPDEm8H5bVvZTxlwczjkyjk2dAylrxKCLe6SWvRcL
 grnFMWjLHxLcPyYTmC8U0ilYhkP06TvRI5sc562MeEQA3EpOlLgxp0yDcKVeCg6mIf6gsqVPZPDW
 _c2NO3rP6wrkPrSLcOQ5ioX1cjnaKfIL.k8NBrMvx.fZzsM0zlTIooY6m0eW53Z44EjPHhDYJeou
 bJXT26E5FHLWUTyPnExMRBsLM.3Hzlk3S_lzAAAuaGoY0fEWmu.xvjWO8JZBY2qt4osPVSLs05bw
 poLGdtwxkorvzsjFaud0T8NBXtt0gz9SWuEXiGgVmuepog77nPhWZ7XQ4tYCXth7QlQJw7rSbr0t
 2Yu56NdciqHm75tTx.QjEgYRIv0pNHp0V7hatgXIkBhqtHySLGTGejQ.1e4mtsTjQn4Vr7..puff
 2VBCZTDF5kZUJ8.HNDv.3yKZARfTlwvTnPiIuhkekbWCADF5pPQNx1qEzfTLeof3W1pxoW69eddO
 BVcH2__MZrqk9ct3zDVJeaIRHVvztibJMjWuzGTvMybS5XP3v4g.BYmV4OHsJ8ctSr.pmQd7.Y3Z
 BjBnDl2uTajnIopSCM04SiXtHgSjf8jTP7p1qGBjkMvIkmjVOTZLF7NKewB.7AWwG9OpP24S2o9D
 .FkUKFOEZukBUzZttmr4lOV2YgCCWeAg_jDbdY.fbkW.0IvWqYPkiF5oCeWogZZZgzPwf_RlFNyp
 h_BbhdqKn_dCJ5SZCsBb3mJ08tf70eTHjEKSRndewuTWFYFk6IAH25uAzWOuZqp2W3xISjeByot6
 JDH4deURib0noaZT2o_avRQ23S0h8XjJiQHCxl.PIWKnLnfP1Ya6fhm_AEevU46lrPJc6DHCyUWf
 Nap7rsPga8OvxUVmJRU5rb1nHWSH4W1mBFSICx3DT1cHfsewb54l0MnBlBewEljS0MjtJKo2H9ob
 NtSf5f0s0EvqIbcH4PZH0v5bFyxrUzs4OtoNNxSuOrcDfSZe_Oe8GmYutgJgZk3vVBVNVlZO_iM1
 uVbkzUar2hFnWk88aodLmIlHGKLuXiQcm3jGykrRfFkakvK96TugpIr_1OBFuzQLK.7OqSLm2Dw0
 PjnIpfjSy8PD3dfxhxMJRBQHnZ0lonGs8ZVa7BrJa2wGRB6QnSaMwk6jPDwA_R_v1SG9yJkBsc3f
 b5KfmuU_apWMBbG9el8qvCv0MXJDkSXAt8Y9PNBAG_FgSuwz.Lsf3dQcjyZcUEI7K3wrPBR8_T4b
 .SEsMpyrc8X2yY3F5yx4Dn7TLPb9lnPd0EM.bY2SFIyrDXzFjsCt93iSK1tBznXj70k0tQUNsl3k
 V7L8o.T1H8P9lMGa2Foroqasd.UiOo14uU8Q1Fw6fR08x8w6vZi8XTbXwOsvPWnxVcG16dtxdCys
 DgAdoBQRi2gnIOGE0ubs2W3oc1Yp8kkVxAC8TPSbgND8TVLAP6v5zUUI1FpnRpteHK0zR9TcqoJf
 ctQrXts1hDvyVoOysvVXYtUkqUbE9rtuUWPAxKHOW.znElThQ4rvsDzxKa0ohTA8_F8I4Z7X2i55
 Eel0qHv6pIHagFXEdcnBwY6umuN1.MpHj8VB4rijwR4rFJDNztkbHHg8_7IStDv4h7RC43Wbjbv6
 BbfdkBr7Ttm_YJEH_jUZaPuKp.86l44dHV5jcF7AyH_EcSU9U6Xe.5rFLV1S_a45JyTgqIXbiHpp
 8T8E7nDEeQH3ktiv6cD5UJziafVQAmkvlubWJNHQP9WTX2YHVbgYuk.4Ez408OBDkws4Vm1KnhZx
 kfAcPCXR94o.gy.F15FdyeWLoblDW.0iaw122tG1rhwV4qP0W6GKji_3tDjiEjJJT6iy5m7Uj9_9
 T2YoVb6V06MLiIxIp6dXBws.Diu9DtGAJYhdW8nS2XvV8F5gfM5MaPIGdJreH.awLPb4YS9eSjGX
 D1K8xeNGYZf8RpROczlQ8JzKTk8cjhN_vMIl1lySz889xcvePZDJnk2pLfm.AKcTJxDh5UGIK54N
 0WlYMQA8T_wsphADsGB7z2CG7aW2SJehhqdEcJ8Lch3O02e7rg6Xu9D1ab9xW0Ii3kGumxqNUzxU
 PyUD035lM8kzNB34wMm30mUzHiQpJTQ5vohPvHiSl1nxljF1enOQGyr.Zt3wJaKXb4Hy7pt1NMc1
 vbtaJ0D5buiOV1536uWT_lF7epCdl
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: d6019e9a-3993-4a0c-87d8-d51d380b768a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:46:51 +0000
Received: by hermes--production-gq1-6949d6d8f9-pmzmd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c8320ae1bddb7a2f7fa2be3a3860d99b;
          Fri, 15 Dec 2023 22:46:49 +0000 (UTC)
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
Subject: [PATCH v39 38/42] LSM: Correct handling of ENOSYS in inode_setxattr
Date: Fri, 15 Dec 2023 14:16:32 -0800
Message-ID: <20231215221636.105680-39-casey@schaufler-ca.com>
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

The usual "bail on fail" behavior of LSM hooks doesn't
work for security_inode_setxattr(). Modules are allowed
to return -ENOSYS if the attribute specified isn't one
they manage. Fix the code to accommodate this unusal case.
This requires changes to the hooks in SELinux and Smack.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c        | 29 +++++++++++++++--------------
 security/selinux/hooks.c   |  7 ++-----
 security/smack/smack_lsm.c | 10 +++++-----
 3 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/security/security.c b/security/security.c
index 64cdf0e09832..b1a849e8589c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2346,24 +2346,25 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
 			    struct dentry *dentry, const char *name,
 			    const void *value, size_t size, int flags)
 {
-	int ret;
+	struct security_hook_list *hp;
+	int rc = -ENOSYS;
 
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	/*
-	 * SELinux and Smack integrate the cap call,
-	 * so assume that all LSMs supplying this call do so.
-	 */
-	ret = call_int_hook(inode_setxattr, 1, idmap, dentry, name, value,
-			    size, flags);
 
-	if (ret == 1)
-		ret = cap_inode_setxattr(dentry, name, value, size, flags);
-	if (ret)
-		return ret;
-	ret = ima_inode_setxattr(dentry, name, value, size);
-	if (ret)
-		return ret;
+	hlist_for_each_entry(hp, &security_hook_heads.inode_setxattr, list) {
+		rc = hp->hook.inode_setxattr(idmap, dentry, name, value, size,
+					     flags);
+		if (rc != -ENOSYS)
+			break;
+	}
+	if (rc == -ENOSYS)
+		rc = cap_inode_setxattr(dentry, name, value, size, flags);
+	if (rc)
+		return rc;
+	rc = ima_inode_setxattr(dentry, name, value, size);
+	if (rc)
+		return rc;
 	return evm_inode_setxattr(idmap, dentry, name, value, size);
 }
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 46dee63eec12..4ac4b536c568 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3207,13 +3207,10 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 	int rc = 0;
 
 	if (strcmp(name, XATTR_NAME_SELINUX)) {
-		rc = cap_inode_setxattr(dentry, name, value, size, flags);
-		if (rc)
-			return rc;
-
 		/* Not an attribute we recognize, so just check the
 		   ordinary setattr permission. */
-		return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
+		rc = dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
+		return rc ? rc : -ENOSYS;
 	}
 
 	if (!selinux_initialized())
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 61bd3f626e7d..02b9aa200ad4 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1340,7 +1340,7 @@ static int smack_inode_setxattr(struct mnt_idmap *idmap,
 		    strncmp(value, TRANS_TRUE, TRANS_TRUE_SIZE) != 0)
 			rc = -EINVAL;
 	} else
-		rc = cap_inode_setxattr(dentry, name, value, size, flags);
+		rc = -ENOSYS;
 
 	if (check_priv && !smack_privileged(CAP_MAC_ADMIN))
 		rc = -EPERM;
@@ -1354,11 +1354,11 @@ static int smack_inode_setxattr(struct mnt_idmap *idmap,
 			rc = -EINVAL;
 	}
 
-	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
-	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
-
 	if (rc == 0) {
-		rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_WRITE, &ad);
+		smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
+		smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
+		rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)),
+				MAY_WRITE, &ad);
 		rc = smk_bu_inode(d_backing_inode(dentry), MAY_WRITE, rc);
 	}
 
-- 
2.41.0


