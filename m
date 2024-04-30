Return-Path: <linux-kernel+bounces-163887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666478B754B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9811F1C21E12
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B5713D62E;
	Tue, 30 Apr 2024 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Rj2m82Nx"
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C8013D630
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 12:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478564; cv=none; b=QTxLJC8qKzZnHvrHTM/ff4y3+qGeQsv1w92Zvio522PEB4pXSc4Q7Z1ebNzB/ENWSPoQx0+rOyZ1xhrqMCDWTGI0Nu7o4xydUh8Bl+v1OrwY8tIsp/StZJ5Zp3iOh6RcFm8Myu74GftkI0Z7qFc3p79erqEwlUf/tyvtw02oTnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478564; c=relaxed/simple;
	bh=Jp72MLJqnTI/BgAAQ1QQxc6sKckihmca/Uza3JsPHG8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=moZpr6eyyJ64fHpQ043xJvN4T2GVGjyFBlyyybmkWA+7ezOR8yN0nTuIGrccxvX84XhVvM72dM5HXfl54kzOrjLkYgvQNPDjHxgz2CbHWbFXMZAkdCCa95zDHSTqww9EkrVavbRxtaaFYwva7QSFJCETGyPO9LbyfUKD5hATVXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Rj2m82Nx; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1714478254; bh=apBtntyNajTBtp+tQish1HZy3ehq4/BVCIxhQSMBm2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rj2m82NxStCbb6pYFAphgcQNTvEKD2TzPoVV4+Hsj35IZp/Hl8gVww8dRR74mOE8E
	 g1sPPH0jIB0BTZIxv7IZJrhcCSmaTj7+sjHF+nAbd0SAek8kVFXPZorxvJ1ys3Nysv
	 21Hm+SgC+U7u7chF3UzZ1c0ibErUvQQxyXlEjd84=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id E609FE61; Tue, 30 Apr 2024 19:57:32 +0800
X-QQ-mid: xmsmtpt1714478252t629564bj
Message-ID: <tencent_DF766FC02FA16CC095BCE976EF5ECFE8790A@qq.com>
X-QQ-XMAILINFO: Mdc3TkmnJyI/OQ2aS0u1J2QlfA2iTu5L8msRZhBV/G3so5r6SbgI/nebbT77Un
	 tnIIfqo3CewX7423prb3jqsWnsHePibjgH9Agx+2fXiYgwg3l9IbWYod4Jd/iXc3jtlhVabANWTm
	 K36q8mK68IhTn6oodgVPfl3B8fxaABG1LlIDohTUkMk2s6qRdztN/xa5qQd9ZV/4WzntHAJgbZmy
	 ysFk6I8tpsyl2Q+2kQgw95mo6CbrPsfcLherCI9I0zgrb7QeKQ4xn7DW4NFYbIRu8W9rvzMKGN1C
	 HocuUTJErnOWB8jZrqgfRV8uRkdvvdDFFM2SaZweW15utpW6E5awrWjFni2mM8W1X5EtLko8jw26
	 rqjuFPkPzY0tnkgf6w3RvQJ7xku+lADWbBcW8gIXN2uZUhexolDGiKgxzpB0CD34IAZEt0ZkOu5h
	 VXWNoA5pRMD2cmUnV7I/7lq15jwd83u4tkeNwWIrf4to9dZ73vWxFRP9S+p+N+bLEb+gFKtwx9LC
	 5xuQudXjbOkKkfiBJxkX/V6w0EiBcZg5S+OsH4GGZKvkYQnvmEJqjk//Sb4qN+zB4obrk5zk6ZAm
	 S+dyKaqTqQ5kiciU49OlM0/fPDJ0C1VcUlnomkLeZjEwidndk8put3kdLseyVAzEks87rn2gCJhv
	 dNP8XH2tRWRe9dUXtktGvtmS/h5b8m8P+7/2LXMC5agnNtFIYA+GsbteX/x5yoK3Ven0jzYDvD+s
	 fidzN3DPEKL997g/iV25GBQmRqB+Dv/17RmsJGeFDLCZ3RzrUaGihOEsXDT8VbqaYIv2hWzqfzyY
	 WOxDXlSdBXI9KFvNWGdL0qdUoPqxhRJb5nzzPgX5aGkSh7u2fIUqGLLLEp0ldOdHpqwxzH3OnTWL
	 Ra2r14NL9RYK0id2TeUTakAtJFDImDy8I6k/GwM/1iMPm5Tkl/Icj1geLEbFhl3vc+Wy1RykQMND
	 M05XBzJvnHFoyXEMfo+g==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] [virt?] [kvm?] KASAN: slab-use-after-free Read in vhost_task_fn
Date: Tue, 30 Apr 2024 19:57:33 +0800
X-OQ-MSGID: <20240430115732.957611-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000a9613006174c1c4c@google.com>
References: <000000000000a9613006174c1c4c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uaf in vhost_task_fn

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git bb7a2467e6be

diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index 48c289947b99..e87d60dde323 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -21,9 +21,10 @@ struct vhost_task {
 	unsigned long flags;
 	struct task_struct *task;
 	/* serialize SIGKILL and vhost_task_stop calls */
-	struct mutex exit_mutex;
 };
 
+static DEFINE_MUTEX(exit_mutex);
+
 static int vhost_task_fn(void *data)
 {
 	struct vhost_task *vtsk = data;
@@ -51,7 +52,7 @@ static int vhost_task_fn(void *data)
 			schedule();
 	}
 
-	mutex_lock(&vtsk->exit_mutex);
+	mutex_lock(&exit_mutex);
 	/*
 	 * If a vhost_task_stop and SIGKILL race, we can ignore the SIGKILL.
 	 * When the vhost layer has called vhost_task_stop it's already stopped
@@ -62,7 +63,7 @@ static int vhost_task_fn(void *data)
 		vtsk->handle_sigkill(vtsk->data);
 	}
 	complete(&vtsk->exited);
-	mutex_unlock(&vtsk->exit_mutex);
+	mutex_unlock(&exit_mutex);
 
 	do_exit(0);
 }
@@ -88,12 +89,12 @@ EXPORT_SYMBOL_GPL(vhost_task_wake);
  */
 void vhost_task_stop(struct vhost_task *vtsk)
 {
-	mutex_lock(&vtsk->exit_mutex);
+	mutex_lock(&exit_mutex);
 	if (!test_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags)) {
 		set_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags);
 		vhost_task_wake(vtsk);
 	}
-	mutex_unlock(&vtsk->exit_mutex);
+	mutex_unlock(&exit_mutex);
 
 	/*
 	 * Make sure vhost_task_fn is no longer accessing the vhost_task before
@@ -135,7 +136,6 @@ struct vhost_task *vhost_task_create(bool (*fn)(void *),
 	if (!vtsk)
 		return NULL;
 	init_completion(&vtsk->exited);
-	mutex_init(&vtsk->exit_mutex);
 	vtsk->data = arg;
 	vtsk->fn = fn;
 	vtsk->handle_sigkill = handle_sigkill;


