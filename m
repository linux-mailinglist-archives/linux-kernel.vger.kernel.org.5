Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130CA76D5E3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbjHBRrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbjHBRrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:47:06 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89334358C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690998386; bh=Y1fV31WoZBdOWHfVRCFl5XIEKdH7s/vbHNDfKMxPA8Q=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Jr3Aj1VUXkzyMebTtF4qRYV1cEaqSxhUTDLVqZq9xTq+55jhT2n22SUv2OOCb9dkfJiZZL+Q2X6hKnhC64yrVov7ABkIYEl1qMKr/y/1Diflbs+hnsH+N/rjNbjNJskr5Djr0DPkcLtp1E9JSs2AtX/2jKvGMH56BOhID8YDj9LL4nJb+Mcvf1hUS+LBXokFEruSlMqc8pcZFILL9wc7Oq9gYCjKKk30C32eU4BCdKJmEOjd5c+3v09NpYrXUvSpB/r/JdU8sg6uqpiSOkdCnsyC2UQM3PzA3asId7y8+YJn050wTmrfDDznSiXX00cfCs5k51vKSBQmk8sq8/kUgw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690998386; bh=PQ3R8ejLbUqn7UDREfls3q6QZa+4XyICXqpqmVmbt5v=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=QLoPAH/zfNq3IwBGddxNZQNSYg8B1cVUhHPz4btDjbTtJVASwY2yFweAL/N06FJRCcRxZTYC6w2LPjJshipmONGESA3tPzRh3/ETU4ra/pDfgQmreuj0Dmt2hYvlGQCzkvj/sR9K3uHkwHv4F+j7jByiDGX80TaHNZXnRfVWtFiwUuvan9MI6bRJK7kUS07rucQGXy+irUHBrpwjrsmaaJpO79iTOs4j1HxLVbdyUCLF7azqRcY0V/FIjaDmsBFesSK3eYHXLU3Z5Pg9sT09E20XeSo8nP2218mGmNmq/Quat/8i88MQVGI4FOs6BEFRffcWwdbiYn3zzqz5qRUnFQ==
X-YMail-OSG: T6z1KTwVM1nb9rkn0bLYY5ra5YFGH8lfa85Zu0MXPQzFioctG.ifeJ6VC_ngVoc
 EEoHe6O.tfufRtKy9DUJOLG9BwG4TaP2BiK4TLEfMloEdBp5hWSvQhahsSQY6uR1TTXJQzFsGSKG
 KIietpIPiYJ8bLw9iep0Jn.Xor94jpJqmiHf3EGI3buh0Ym0JU9xepxJJle0N7WRgYA1StwJFYQD
 16kqqIBLrP.O7ER_IN1reGKozEey4arw9YGZ.0JpHgolbQiFtPec7kST3iLdD.jJZ7BepdUtNpfQ
 B0ijyy1Kdrj.7gDpx_r9bxYoNTTs7BfzdTiIuWrb98Pe_4xeRoSOZWBbw81lDxRTfWbVzKRDxttk
 2ItndpQW5KwI7VwFB7YC69t6fuD2wYr4lRoJCAlt.PR.XTzxJblJn91Slz7I0lc5NozeLOHnl4_6
 eVYkM90PAaIK_Lt48_AAixPUmjor6kvNyQ5qUknzCVmwKJirlW0ARcpp5GSut4EOjI9Wrj_kPKeW
 QSq.GYXHh7Fp4SuGsjfinIs7ugonoP2V_7nbr3f5Vv3Kgt7Xc4jv93DR7o3jV1LUCb9XOHfAm9Ib
 vEH7p.iZAFFoaPReTZYF44HKZalYilNxYCwzTqCrDdNmmNqIRGKFi1kuqvk6JCmO0OjbDRcoe2O9
 RqVAGWgmR.omH9gRWYFZY8Kw_Lc3ayzx0TAs9tyJci8vi_RRjmv7m_wlYxx2pVux5dMj8YwSaXu6
 1fBdFO9wqHmvnZd2mL5FYhOXyo7jONMsy8z_KD7pcglHkijCTGvHyMqKII4ill4b44fIbyo4koZi
 Rqt1qICgNIxTnwR6ArMxQJtIYoYGnNB5i_Umitx.aMl8Psb6hhBqypdhpkd5p9VOPW2pUzrU2.jZ
 ewS3hILiwkr0oPoBEacwV2YfTprzn9Af_xF1mUUY7_c_tSczNzNlyg1k8t3xAd1qGiNHw5.4mry4
 HtANIeXud04h.m.JrleBkm8hZKeQMBkYKpyt5qVFupDe.fQvphCppgi..JpXNrSQzC27Kdq7ADvn
 cWwUIvEeBzfbLTHGCrSL.J0dY9J1W6Qy30J2AZMNU3YCIvEyCDdSTV5e.aX5EG_2eoS.mBEXJi3t
 4UGDo5eFJMSaLXyaSlc_lnKIYMbk7ljubmF0sTd.1.EDSYoNew8TWn5olitfDEM2GJKFveyOdto8
 5DMgREQKl3NJnvIgp3SYrrjwIkFqvyWXFe2bR8Wu8bnEalKcJS2jL8CnWT.Ko5dYck8gUbSl7mpS
 IiEwgd2mlKhe668.9LtpVsQZZ1tk0WKNmZLzvtmwtsqM21FrzqMzictBsj4W4sxskkXjVVNsA7Ze
 BsDsJXGkf.6swZ32LR3MHVNDB46VHmgL33cD3.iOs6TdpteWumzh8rZ_6UkrPZRoiKUFqimMOPDX
 Cerrk0ejxCBDpoZS115jXGiYiloGQYoJI4r5x8GocM0CQ8zp5JiVeLYU_YzEpUKNoP5xZmcqZRPq
 appVJqAI1CrXLM6vwvdQkyTZqJfQO_GU2T9HkznCXX5VplY_7Uy9.D8AIjHXrzLIKipSabgSieRg
 ostsYpkUpGuuJLsVp92gIMkqoXtRLuDf0EX2al6xHaOkvmNZrfWIoSZG31.pp71w_8.8qWRev7MW
 2WNPUIKeayHl63oweppoa9b8vSGW2ifpEwYiqE4a44k_1uqJMTrWGAdLrrSLAzTkf.TEt6Oju8ab
 42gWVZ4iPH375DeYpixXGx6G4cjjds01n6hycen3LSKsKX4tIMoqJZ5NrrdBFagzb8rCdB9XQOdp
 4SAl_QT9lSMrlfnaRr.s8Hhm2ir6.pl8Kx8g.Dm5OqbhXRH_akLA25FT43.Hmhws9NpAKrzTHTLw
 eiV8a0RLicmsk9gEKGA9NpjzOYfZynCOA7lH5Fkpu1RgCp9pImmwvF3TKPDOUNqlxDqDLHjRlEzp
 OfS45B3lYkXG2Qc.0.oc2jGa9Z5.IlKH8IDbhYroyxVkGbp_YrWeed6AyQhog9RnwSOjfZUfXZjN
 Ts343wfuYaOgZMLfVwCDx9JMYQGR.83dlXa7lL0YHZJiWgd45ahZ8Altn2n_LrKRDC4uiAnlKUff
 ltkvUkqy8lipAxj7WzoG8OnOkWBxsFLnAMck0z.OooH6EBqEeWXy4fU35j2qvwMe0UyqRjGh6JRy
 ximEDYohq5vCpevV9l.A8mLc6f87zLu9Sq5z7AQ4jODYeNmBGpULyMsXyvJVDDrVVUtPg6cglGnM
 F1.rJsWS6rAKjWP9_wOMx8Ij81tTpxZNppbBU
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e6279b4d-1066-4855-acaa-946166353edd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 2 Aug 2023 17:46:26 +0000
Received: by hermes--production-bf1-7c4db57b6-4hrkz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 49a3a41e5715f67667cdb3b18eebd6de;
          Wed, 02 Aug 2023 17:46:23 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v13 05/11] LSM: Create lsm_list_modules system call
Date:   Wed,  2 Aug 2023 10:44:28 -0700
Message-ID: <20230802174435.11928-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802174435.11928-1-casey@schaufler-ca.com>
References: <20230802174435.11928-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a system call to report the list of Linux Security Modules
that are active on the system. The list is provided as an array
of LSM ID numbers.

The calling application can use this list determine what LSM
specific actions it might take. That might include choosing an
output format, determining required privilege or bypassing
security module specific behavior.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
 Documentation/userspace-api/lsm.rst |  3 +++
 include/linux/syscalls.h            |  1 +
 kernel/sys_ni.c                     |  1 +
 security/lsm_syscalls.c             | 39 +++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+)

diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
index f8499f3e2826..a76da373841b 100644
--- a/Documentation/userspace-api/lsm.rst
+++ b/Documentation/userspace-api/lsm.rst
@@ -63,6 +63,9 @@ Get the specified security attributes of the current process
 .. kernel-doc:: security/lsm_syscalls.c
     :identifiers: sys_lsm_get_self_attr
 
+.. kernel-doc:: security/lsm_syscalls.c
+    :identifiers: sys_lsm_list_modules
+
 Additional documentation
 ========================
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a3938850752a..4e1596b5c300 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -958,6 +958,7 @@ asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
 		size_t *size, __u32 flags);
 asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
 		size_t size, __u32 flags);
+asmlinkage long sys_lsm_list_modules(u64 *ids, size_t *size, u32 flags);
 
 /*
  * Architecture-specific system calls
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 8b96cd01b485..7663ef16c07e 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -172,6 +172,7 @@ COND_SYSCALL(fadvise64_64);
 COND_SYSCALL_COMPAT(fadvise64_64);
 COND_SYSCALL(lsm_get_self_attr);
 COND_SYSCALL(lsm_set_self_attr);
+COND_SYSCALL(lsm_list_modules);
 
 /* CONFIG_MMU only */
 COND_SYSCALL(swapon);
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index ee3881159241..f03f2d17ab49 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -53,3 +53,42 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
 {
 	return security_getselfattr(attr, ctx, size, flags);
 }
+
+/**
+ * sys_lsm_list_modules - Return a list of the active security modules
+ * @ids: the LSM module ids
+ * @size: pointer to size of @ids, updated on return
+ * @flags: reserved for future use, must be zero
+ *
+ * Returns a list of the active LSM ids. On success this function
+ * returns the number of @ids array elements. This value may be zero
+ * if there are no LSMs active. If @size is insufficient to contain
+ * the return data -E2BIG is returned and @size is set to the minimum
+ * required size. In all other cases a negative value indicating the
+ * error is returned.
+ */
+SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __user *, size,
+		u32, flags)
+{
+	size_t total_size = lsm_active_cnt * sizeof(*ids);
+	size_t usize;
+	int i;
+
+	if (flags)
+		return -EINVAL;
+
+	if (get_user(usize, size))
+		return -EFAULT;
+
+	if (put_user(total_size, size) != 0)
+		return -EFAULT;
+
+	if (usize < total_size)
+		return -E2BIG;
+
+	for (i = 0; i < lsm_active_cnt; i++)
+		if (put_user(lsm_idlist[i]->id, ids++))
+			return -EFAULT;
+
+	return lsm_active_cnt;
+}
-- 
2.41.0

