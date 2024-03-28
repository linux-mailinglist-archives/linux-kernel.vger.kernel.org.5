Return-Path: <linux-kernel+bounces-123807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6353F890E55
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782C81C26CFF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C8A657B5;
	Thu, 28 Mar 2024 23:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiC8zYFq"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844683717F;
	Thu, 28 Mar 2024 23:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711667537; cv=none; b=Ks3NOwSMhHW9/yxtJaABhey+CxBrjrTZ1LZtHpovgHoclbudkMBfKde8a3M5MjSv9Q+PJ32ppht/cgyqsrEoQIePma7d8U/KYa9ea38Uk+Fak22fv6ztpK8Rg3wYMwnfTgx+XQ4wAQpUOHmhvr3DAVTzzbxbP8kLIQotFQM7SfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711667537; c=relaxed/simple;
	bh=Y2yGhw5DoVYcmyKvtY93T2ZHh8GSDwyarOd0jGWdti4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=umQ4saR6LNB/Hp+iJwdDt0XObEfpw6oBsdgCACqAWNYmsYVpDM6Zhxz8l0GiPs35PVxbPvbbXUbmes1P18/8cGjZZxXK2UV9Ij6ekspKT29wELPjMNsUQZE50caESRo+GH+eyoN0TVCoPHOGJORwURgnoL8/adI1jcm/9ASTJIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiC8zYFq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e0878b76f3so11655085ad.0;
        Thu, 28 Mar 2024 16:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711667536; x=1712272336; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Gh8/LNAzMBxlxkm/tP0Vt2dtSY7TQP4IXEdBVsXfZM=;
        b=hiC8zYFq4ZA84UT4AUC7A94JTbPKPdfrBxxEHgrY5NhoJOHklkS7G3QXfxnwActq4X
         iTjTXUb6ODfQsIx3eu41ffepvN29HgPnvgdeVhxYxSaqH38LBj0FaHvJFRVCbBqqiToC
         4UhTdBmSbhyBTvFetBUYoRckpIBFXkhxtT2GG88mEJICUsTGpDa38/QXnx0XA2alNrOF
         OShfD6tPcLXDl3iR3gKVehC39XBksMZx39zXSm2MxbteX9oFaVkgKpI+5cymIe9mtx1p
         1zJeJqZbDm4+4I0eCQcliI0Kdx0C+2UQ8o0SeOhixiIDAdQaVmy3GOlTyPBSDYhb1n5c
         x2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711667536; x=1712272336;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Gh8/LNAzMBxlxkm/tP0Vt2dtSY7TQP4IXEdBVsXfZM=;
        b=bZ4d617hNKC4mhtKWZhRD7RA0sr1iUSI8OiuY6UfSuzf/GI3dPOGPhIRn47M6mCUxW
         rfnm2jzJ0QnVH2XfLewiErFqPi3ujyd9InF+N1YNy7ZBDkRle2FN1ZDw5bgGDYxSf7qT
         +L+EN62hqnn2OHjWd/0mEU49V1LIpXAtrGmv93B0oHyJjf2orblgrQkLc5LwTjn4M8qx
         Utanxr8rDNNvfWh/r4/LA28mWa7tR37V9f1mZxs85tpROSi8dO6tN7JI2r35RxueF8CL
         XoRDVZV6oU0Q+eWknBdpFw1VYSdCkkg56DEQcLVL5nBWsGzhOHnErnHAYJS9FsRRyVjs
         CMog==
X-Forwarded-Encrypted: i=1; AJvYcCU5sL723rkhr2YJizGxYEwOvdgu0w9NWCF7pUQwWVOADGJ52GS8pa3mjJnkVHixVv1FUtlw2IMftZWGHBYVrB/PjKgrXUrpoL7g4j/3m3flYMl4WBsOKfo9Sydp3GaOT6PngP0WKNnv22/+PO/p1KeJF3VR
X-Gm-Message-State: AOJu0YzIJ0YSfwOQE28zWSCKacrKpW0PDSaxSV9C59BdM9BvdY0IM1ga
	vHaHa0TEguM5NdDMLOs4zZ4N9cpG4aaLY2l1CwGaKbzRO0+KZl3J
X-Google-Smtp-Source: AGHT+IGiX4p20Gwid9PPKaKJVns4F9PJz84+sUjqx9+J/dOlHH2stjgClgj+FeJ3WcKQHrD7SdnqLw==
X-Received: by 2002:a17:903:1c7:b0:1e0:115c:e05a with SMTP id e7-20020a17090301c700b001e0115ce05amr5996164plh.12.1711667535655;
        Thu, 28 Mar 2024 16:12:15 -0700 (PDT)
Received: from tahera-OptiPlex-5000 ([136.159.49.124])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902e5c100b001e0b5eee802sm2174664plf.123.2024.03.28.16.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 16:12:15 -0700 (PDT)
Date: Thu, 28 Mar 2024 17:12:13 -0600
From: TaheraFahimi <fahimitahera@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: [PATCH v2] landlock: Add abstract unix socket connect restrictions
Message-ID: <ZgX5TRTrSDPrJFfF@tahera-OptiPlex-5000>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Abstract unix sockets are used for local interprocess communication without
relying on filesystem. Since landlock has no restriction for connecting to
a UNIX socket in the abstract namespace, a sandboxed process can connect to
a socket outside the sandboxed environment. Access to such sockets should
be scoped the same way ptrace access is limited.

For a landlocked process to be allowed to connect to a target process, it
must have a subset of the target process’s rules (the connecting socket
must be in a sub-domain of the listening socket). This patch adds a new
LSM hook for connect function in unix socket with the related access rights.

Link to first draft:
	https://lore.kernel.org/outreachy/20240328.ShoR4Iecei8o@digikod.net/

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>

----
Changes in v2:
- Remove wrapper functions, noted by Casey Schaufler <casey@schaufler-ca.com>
---
 security/landlock/task.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/security/landlock/task.c b/security/landlock/task.c
index 849f5123610b..67528f87b7de 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -13,6 +13,7 @@
 #include <linux/lsm_hooks.h>
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
+#include <net/sock.h>
 
 #include "common.h"
 #include "cred.h"
@@ -108,9 +109,48 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
 	return task_ptrace(parent, current);
 }
 
+static bool unix_sock_is_scoped(struct sock *const sock,
+				struct sock *const other)
+{
+	bool is_scoped = true;
+
+	/* get the ruleset of connecting sock*/
+	const struct landlock_ruleset *const dom_sock =
+		landlock_get_current_domain();
+
+	if (!dom_sock)
+		return true;
+
+	/* get credential of listening sock*/
+	const struct cred *cred_other = get_cred(other->sk_peer_cred);
+
+	if (!cred_other)
+		return true;
+
+	/* retrieve the landlock_rulesets */
+	const struct landlock_ruleset *dom_parent;
+
+	rcu_read_lock();
+	dom_parent = landlock_cred(cred_other)->domain;
+	is_scoped = domain_scope_le(dom_parent, dom_sock);
+	rcu_read_unlock();
+
+	return is_scoped;
+}
+
+static int hook_unix_stream_connect(struct sock *const sock,
+				    struct sock *const other,
+				    struct sock *const newsk)
+{
+	if (unix_sock_is_scoped(sock, other))
+		return 0;
+	return -EPERM;
+}
+
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, hook_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, hook_ptrace_traceme),
+	LSM_HOOK_INIT(unix_stream_connect, hook_unix_stream_connect),
 };
 
 __init void landlock_add_task_hooks(void)
-- 
2.34.1


