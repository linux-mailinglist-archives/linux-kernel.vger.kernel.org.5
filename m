Return-Path: <linux-kernel+bounces-89693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EFA86F440
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 11:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD47A1C209F5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 10:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B6DB65D;
	Sun,  3 Mar 2024 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="VxNYqvyQ"
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5E6B64C
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709460011; cv=none; b=OMlax2bU3BzGu4b0F5vQzEJQnFBbKb73rylOGqhWCEbRNpBFaRWatP5rQDC1RjfQA2ziRYg9nuTvM77qXfHevH6tj6tKlSLeDaUGa/8ug0ay1UhzPaLOhKYtKsOO4Y75HlHmXFB0z0XuTI9XleTcabrrarauoCBr5l3d4NdGAvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709460011; c=relaxed/simple;
	bh=oTNm2sz94HQbmc54Z1Yh40klQw3t4+DI6D97vMSEdlU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=kNsZ7cjBh48VFfZJgTuRDv0kAkdgPk3WhoviEUogQxObhW1WcsC36E2Z9Ah6h5ua9VCtfa9VhV7404a43xReYQqZ23+Hkc53ky0sjbQASAu5YcxyTlD/9HZwsnAzoCoTGeZAfGt37gfYo1JpDeWITJRujzjziQYVcO7oIdRnUfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=VxNYqvyQ; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709459999; bh=Pyd0R/H1GCUYWEEmLv/msqnms2K/V2Adl4vdvLJRepM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VxNYqvyQo/mnDb34yq+AXBrf5FdWvdgALdUxsqmWUktX6MnHFVXOT3hOsJnQ8dbXU
	 bOiEvyoZkS6/p22cuYlSo92MQKuILUseeRWqx7Ju3S2ce6kluGpXbv5DCChgJANSty
	 HQUgcauGCZFAQ+aPM/dqa43T62iz+1Mp4ycCUKwE=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id D75012AF; Sun, 03 Mar 2024 17:53:53 +0800
X-QQ-mid: xmsmtpt1709459633th45589k2
Message-ID: <tencent_BF366E402C056C3C97D8E9DEEE0ECDEC7A0A@qq.com>
X-QQ-XMAILINFO: MvTK+AXQ7a4FK5B8iB3iGPYOCYHqr+HIjfbMFReRzJAQMTRQZoyWAdoMHcZo8y
	 CW5ISZy5zOb1qMMwGU0hifmVQx55lgdnBJZTnhQ0YqASfAQHtG8q0HAwNkLUCt+/eaxgdB7FdU81
	 8UZl8Uj3OZW/Hw78NISTa+g/pcsFvRn0HVYnJcYADTlCWVVGC+LC4wYT/a4AmuvHVS1ojB1JJCsq
	 aJxJi2wdrhqsGQHPXjjelR69GYybJpYPdb2pTG3pHCRplVW5zhdzskvYXKUY0henM/bqGCciMXe1
	 588sQwZa1RLhxd/dWAjgRrRBx+aMHXWhYXtuqkdpAT6KKL/HX6/ev4VIz+0MBhN5UKw26+MkUpus
	 USGYSB+qVs5RDCeKSj8yzmGbouTEsD7S/CEz7i6oN9ipNxkVN0AlENYaB5ND5bcZ8rULkt/3fZ0U
	 NakCd0TIIluKkcsqJpDETdPFW9MoDFfUr2CGp+B8qCE/Zef24m1ZB52cOe4Cp4Oq8xkq3+QIuvsX
	 cwBVSgYFLwOKpb8FFpvTCl2Ql7T5QIsO5tsZfrv1L1C0ABIdrLy/UmPNhcEmdwhieoueLNPOo+yO
	 NGwuZT16Sq6De2Ppq21IRwbraQG/RXTY3ILlyQgT6vyHcCFAXe9VdteDBBcArujvAGfdsRKwbvFl
	 vJynr5fE0Ag8z8VFlpfgWOC8LCI8zle4uFbInomIeU0VnOtN++qTLleCmz7bghia5HxYXXSgB5ri
	 YcRy7QQf7fCl22EzbbfCnxjMCMngUGFm+HkK7XVHLE83u0WbEXM6Gl8QX8qMUocVMhPKfofIntMp
	 a7hTkERNjWW7g3n9Ryqcg34LD7gMc649tKxwCIVNzrNhTwKIKtsAfx6FHmkjg4rk7jnDQ/lgLXKf
	 ge88JRBoVBsEnRWB7H6Cd09irp6asqdAMp66KVQVo5+U4RhlhJzPYcA0ZLPv6+2dawUAf5tHZD
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in sys_io_cancel
Date: Sun,  3 Mar 2024 17:53:53 +0800
X-OQ-MSGID: <20240303095352.445841-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000006945730612bc9173@google.com>
References: <0000000000006945730612bc9173@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uaf in sys_io_cancel

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/fs/aio.c b/fs/aio.c
index 28223f511931..0fed22ed9eb8 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1762,9 +1762,8 @@ static void aio_poll_complete_work(struct work_struct *work)
 	} /* else, POLLFREE has freed the waitqueue, so we must complete */
 	list_del_init(&iocb->ki_list);
 	iocb->ki_res.res = mangle_poll(mask);
-	spin_unlock_irq(&ctx->ctx_lock);
-
 	iocb_put(iocb);
+	spin_unlock_irq(&ctx->ctx_lock);
 }
 
 /* assumes we are called with irqs disabled */
@@ -2198,7 +2197,6 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 			break;
 		}
 	}
-	spin_unlock_irq(&ctx->ctx_lock);
 
 	/*
 	 * The result argument is no longer used - the io_event is always
@@ -2206,6 +2204,7 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 	 */
 	if (ret == 0 && kiocb->rw.ki_flags & IOCB_AIO_RW)
 		aio_complete_rw(&kiocb->rw, -EINTR);
+	spin_unlock_irq(&ctx->ctx_lock);
 
 	percpu_ref_put(&ctx->users);
 


