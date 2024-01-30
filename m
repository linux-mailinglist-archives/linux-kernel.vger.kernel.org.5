Return-Path: <linux-kernel+bounces-44712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D608784265F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 356BAB2FDC5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D47D6D1CB;
	Tue, 30 Jan 2024 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="x78imm00"
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B8D6D1B8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706622231; cv=none; b=Ifv5j6hZuruG3eMNRApU+JQvlWkEV8wEr8gJlLmsloSv5PhnGAznKnQkiFRkiiPfybOafUITjZ2hgJ6KiCxRKG9Kpc4t2PSHWgQU5XAsx0ImCbhe4InGzU+743lsBV81KZbdlbjEGfRBls3gItfazMfWzKPpLonX7TxkCqmmRDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706622231; c=relaxed/simple;
	bh=cML7n0Acv9i1mQUGfL55SfRBzqVfYzjR7WkF1hYtOvI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=qwuK9L7kmiooUNFaoYvJqw88nwOtD4WERfSnFcpwNvDfkMldppcWRBkVf4qjNca0Mghw/IbAVHRHt4YNGNeknU66LTPQk5GROdl1o+hmXknjM+GE+A6P2UQIUjYaPNTBlzrtNa3b3LAcFTSSZ7y5q8pKghMVN9QbRf57bpH70gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=x78imm00; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706621926; bh=JsgY4MxkN5m+T5v4xcV9gMeJIdFm8kpH80Dby4G1UQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=x78imm00T940Y2Zy0sQRXojhP40MeYzEDjWoKie94a9uOkLCMEeESnwhhZ3k9ZH8f
	 BivipT024JfrGM4deY3bUHMc1x27K02WipPLUrq1zhWqO8WbJwfuWBYJ35eWlehueb
	 jTi1jNdbEIGTh1dSfl4tia6ZH0W9utj/NIP6F9jk=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 9ACA3826; Tue, 30 Jan 2024 21:38:44 +0800
X-QQ-mid: xmsmtpt1706621924tilf4hzbw
Message-ID: <tencent_74C670C985EED9EEF68C8927DA06EDD2DD06@qq.com>
X-QQ-XMAILINFO: Mdc3TkmnJyI/VlmtfTzmjpixqnIsK75wDTAzOtw5ohOytE4LLjB2GwPejbTlYn
	 +8LLjX0I4wVV68KunRshsLedNhfG8pNm3pFNKllHfcqYKwGuKuCjm+YbeTyOI2vkroHCycHtfMbY
	 nbIkG+5XsO0MfwdxKeNa+DIrOXtgQBUgAH7CPxvAWqOt3v40A6B1qH+cmK/ECN2B/MF0kehwTaX6
	 s4oq4dKOxGehLlWPxS5aaCDd7I91rgVeAH4opnRCPnr6EaOKZthlUuXOQla20hWZ4IJA+OlFM6zS
	 CChXLDhXV05pucurXrmiOeFT3qdzzGkSNs6cz20geMQwooUQqTXNVt1iK77jWaGhNaz8SdaXx2Pk
	 dlb4nXqD22o2jzxZsoqvX5eyZAH3o1RMH38XAgO320/1sSxenaFyhYJIhLOw1kgM6UBpQPi0sdSU
	 MDuImTXVZzWujOqNzb/8c50jCukIzSBY5yXj8VJfARojhenOWpki1U4KLdEhhX2XN5MZ0vCK86Ik
	 fC3/xybWoits14Kmx6+/Et8k7z+dtBHQKDyKlqxXQUYUAmne4m4I5J/zHqmdIMmoVxXza5DcVlhh
	 nVcnOxl8DfSI02pdVIqBsYGR3GX3Gt1KJocJ9MxndGbdzP3MHh1YgSomth97CkVTkP2tdN/cMR8F
	 BOeRwAhWv2hC5b0ZE6fyoYilbcSDU1VHHvxrRXewuUYkGzaFiapOo9/s/f0It3IXA0YKV/PIY96V
	 hB4z2qPE4bEaeI/IEbfulVv5tc1t72uskVnYKqeKEhKul1vFqACi0Oq0gTQHpUyOlsyG9IWFviLL
	 UnW4U5eqog8mxSK8UVDllAoojMrcD7I7NzJco9w16PTUlh8P6vMzFqrNpRW09qTntgMr6P3/iVQ/
	 hUjZtndrCJv/vlZGNNyzJqC8xnbPwSs+w+r9eXYdm9ht6163rCpYE7N4xOGdsYEjhpR5fVwzGI7l
	 xXYGTrSYc=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
Date: Tue, 30 Jan 2024 21:38:45 +0800
X-OQ-MSGID: <20240130133844.4105103-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000002b1fc7060fca3adf@google.com>
References: <0000000000002b1fc7060fca3adf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test task hung in blk_trace_remove

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d5d94510afd3..81e48f841764 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -327,7 +327,7 @@ static void blk_trace_free(struct request_queue *q, struct blk_trace *bt)
 	}
 	free_percpu(bt->sequence);
 	free_percpu(bt->msg_data);
-	kfree(bt);
+	kfree_rcu(bt, rcu);
 }
 
 static void get_probe_ref(void)
@@ -380,7 +380,6 @@ static int blk_trace_stop(struct blk_trace *bt)
 static void blk_trace_cleanup(struct request_queue *q, struct blk_trace *bt)
 {
 	blk_trace_stop(bt);
-	synchronize_rcu();
 	blk_trace_free(q, bt);
 	put_probe_ref();
 }
diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 122c62e561fc..5f927328b7e6 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -26,6 +26,7 @@ struct blk_trace {
 	struct dentry *dir;
 	struct list_head running_list;
 	atomic_t dropped;
+	struct rcu_head rcu;
 };
 
 extern int blk_trace_ioctl(struct block_device *, unsigned, char __user *);


