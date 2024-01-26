Return-Path: <linux-kernel+bounces-39680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BECA83D4F4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43FDF1C24ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B6B18EAF;
	Fri, 26 Jan 2024 06:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="lYICGLdK"
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E7D125DB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 06:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706252330; cv=none; b=TzxVrga4RXa2hKH7j/D6myTuA8d7ZCbWSNmUNWXGMAxi0KTK+EwPpjPbMU6iWm/++pF6Uf1G0NBPf8Y+6eUhh8JFQtg/OamJiYDvMib8z9qeuh8oPoMx1OYwXaM0udeetdQvYOTI7G9HHkjB7nDIRogNnJvGTodYeEvXS2eFW7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706252330; c=relaxed/simple;
	bh=vEh+gFEmMdUX9UP227WSXtBed/m/QQhh+3wwORgi3E4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=fTV16pO8Q53bHAc1FvDwIZ5e9p2MQdJkC6QKOY5ejVgG0GuymlK2XbAFqDetCgvCgMROF0Co+18u1CfycQ6Hy2B3fvz3XWiYkl3WvKT4/qXfGGoOEor/C3ULRiDOau5iPC8IhHjqyU8ajxhK7alC0rwvHMQghG4YlTJmjrVoRSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=lYICGLdK; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706252326; bh=dsSSj5gkDCcVs1xlBOaqKLlk0NdIYeNu5G6pUUGGwVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lYICGLdKCs9b66G8iGOemDEvdUxdktK/gQvIDJMdo9qq1d6Rp/X5TT/XxHRDAbYTm
	 kL0RM0C151EgeBKCAgptceYlraotFHrtT+8g7KCMD1oQhX5FNOzgmBHNml1RHan9x6
	 78v/+XQNO1+orYYWZRKjudL75vkez8R7t3CzINWI=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id E4190423; Fri, 26 Jan 2024 14:57:01 +0800
X-QQ-mid: xmsmtpt1706252221tukiio7xg
Message-ID: <tencent_996F3767C6DAF364036D296183B744451705@qq.com>
X-QQ-XMAILINFO: N0opbxSOYLeW3R5+ZbRXyG1qcSjYEzLJegoCfPpFNTH/YM3fvTMR9PYluFQlKg
	 Ol9Bq/PtCDbZRwX9XMDAibeZX3T40ayXiqvvW1Dn8NV765j3Cfg2flxzitIsuh/GynKmP2SjVVIG
	 1KO97k/+Cjft9WSa2x6/4vu+klm7CPnUaQctsTm3kKqQ74e26eVjtCiPZWLblUC5WiMm4bDsXg4t
	 xWiawLxZ7knLs9evvXuKFkVxHzLpRMOPkk4Zes0KqWeC0AgxTlJdfqmzDpD2BFuu+HHGp/plgOze
	 I8FsQmBdyfJxQ/am1+Iut/bPKWblrpMlZnwNwK85Za85KYgl+7mfwM+b4s4Y+cyKdwfIKLP0m9aw
	 jTWFaElXMuy9Xu9sZt9FKU/fEAclDBrLBepm1e4HzYB0ISKe/uyq4Gk56zpUJuzX2KQsWglrSl2I
	 U34pDUqBn0vTgHqQvmRdF7ze07bHrDIywThYDmg9FYfllEyCG9F1mLacwp2keMm7LdPp1e7i7RwY
	 omYPmqnAN7hNlK2ddjCUCIefjeVEvkOV44YSWr5fOZkk++rG3kaMHBpLDftRECN5Ne4SNp6RclH/
	 TfMpFoolWrxASOnRkcsdUVZ054qF7bp8pISjX5+PH/mmxQUx005I2fiYSiS8/HjMk3fQSeDMvsBy
	 bF3EUrUvV4ZrC5BD6CWAyiIRMNTeJMB6wi1IOSVg8EYLESqvylZ/eJ214Y8NNXAw4dflRQGHi3Mh
	 mGydXDgcaLjf79jPRaa+Ogc5mRs3uG3NU8zU57cjRc6rSRYMf0ZeOaNM4C47e2B9F+jyUc+psJ5L
	 6wRP/Wa7GPk2sBfeHzBdPUi4xl514Sbr08ST5AuRqs6VHpj2QZAKq04gCGfZRhpTySpFUgrtUJ1r
	 m9XPF87u8Nn6PEQTWXc/oGm2z2z2evzZHIX16TNrrS4ZCM3ng0JXeU0xj4cmiRz8zbZqVEXaz4Se
	 VhvZDdoDB1wZbjugWuichGl1KaX3kl
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [virtualization?] KMSAN: uninit-value in virtqueue_add (4)
Date: Fri, 26 Jan 2024 14:57:02 +0800
X-OQ-MSGID: <20240126065701.3238387-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000fd588e060de27ef4@google.com>
References: <000000000000fd588e060de27ef4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uninit-value in virtqueue_add (4)

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 9d1bdcdc1331..4ca6627a7459 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -427,7 +427,7 @@ static int __virtscsi_add_cmd(struct virtqueue *vq,
 			    size_t req_size, size_t resp_size)
 {
 	struct scsi_cmnd *sc = cmd->sc;
-	struct scatterlist *sgs[6], req, resp;
+	struct scatterlist *sgs[6], req = {}, resp = {};
 	struct sg_table *out, *in;
 	unsigned out_num = 0, in_num = 0;
 


