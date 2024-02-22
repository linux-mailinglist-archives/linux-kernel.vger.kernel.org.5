Return-Path: <linux-kernel+bounces-76388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4535785F690
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF06FB23E55
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06B5405E5;
	Thu, 22 Feb 2024 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="yYHw8ZqI"
Received: from out203-205-251-27.mail.qq.com (out203-205-251-27.mail.qq.com [203.205.251.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9313A3FE2A;
	Thu, 22 Feb 2024 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708600235; cv=none; b=hcl/b5pH5d59aa8XKjKoy26diYMzvzlUbPLi2BZmm1kjHpc/7qvkqtqwXt+gAOMvTPlNVrdazQOd9Q447n7WCjJ9L6EvpNItbdx4XCeJih8gWPxVF3ws/fqUMNYBQKwah/X2vVGp4v+3bOf8STEbUwbUN7mjhxfwbErKP6L5opY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708600235; c=relaxed/simple;
	bh=Sq1yThAZFD2dQsxqsmmIQlea3wqBVbMgG575+CjcE7k=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=fUAe4m+y6G3Wtx8rtbVFGCxckSxFghi3uOyc81BVwTVOYkv9E5v4w+7Sn9fR1wEj7KuLJbS9vt2urnlZbsyCNEiGb93UoUyBe82c21R83ontYs92n9FRZj0iy6ta1zC3PLvZX8bkYZhnGJdsxYJDLtuvaiYgrRPb2pS2bgKwQds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=yYHw8ZqI; arc=none smtp.client-ip=203.205.251.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1708599922; bh=iDuAExiCH0kR1uj9WmadgxuNzx1aARB3KyPerLUjcgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yYHw8ZqIMhF1cru/aDVn6WftcAYF9NMwvdOos1zQ6QmDM+gGdPF4o6J/vFm5Qm3Mg
	 4ZNndF8tljXe3uLKSur9iLYhn0mEBrMjCCEEjqxAy1MTBv/jPaJuuv25UiPo3/P+Q8
	 zyiYNs3a3EQ13a9awaWL4Fzo2uO488b0SgYzm5Yo=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id EB8AB210; Thu, 22 Feb 2024 18:58:56 +0800
X-QQ-mid: xmsmtpt1708599536tnnguvun4
Message-ID: <tencent_211B474BC21B1D25ABBA31BB5133AC9E0608@qq.com>
X-QQ-XMAILINFO: M5WvXNp9ZPrQSsCcmJmlHfhfpBGdw9jJo2pzb3aSSDulHPmDZh80TX3KB/oUWV
	 nOp2wkhLQFMEgm7wSyX/d1jyDUAI3uAFANuLdrtLkO8GQv4zfq0CQD90nLpfXLYxFvlUjUSFz0aI
	 qybTbcg7gQOaCX+g7PL9luyo//t3AdeWvEtE9FcuCngBcX/MKib9g23UmqXoXJ//hGdAZAF3gQZ+
	 h/06VbaclTYJD8LJwgUpT2n9KlQ8eGBO4mEOboAMAPlYSHOnYkeJmneN1sFq0PDqx4am1KLWni+H
	 XImxnx0O1UKeb8bNUKuXlBTA5dhUuayWBxm99veBhhuXXnbSMsu79Hc2BxcuubXnmDKeA/A3lQGY
	 gz8EnoIGnEE8odGhVgi1k+h2z4PBsKa4gZagzbKkZRQrjNjlIBxHYhFSUp/TfVQvsWm2QI1Ox4bZ
	 dbeaKR2wT0ydF3jX60m1PaXP8/3GBaPH4ObvD1d/qPrOx1tnHtzWOBL/xI8OCkycN2TP7+d+UHme
	 DmEy83fgYd0KfkEBrjel+9BZvj2IygZQHF+RJ7Wg6+KT0belhkCw0QXUAtq3sAx9/DQqeMnB4/3G
	 +LGLkgEkCp6ZdUEiXWuR1YcLXxeZBxaBthIHc4NkMXa2tT7U8rC0OcgCiKUQ2qOD6EKGK72s6I+F
	 rjSfXFYLc6a+Wn/XyaLwf5zGxI7mM45p5hyyW1nz58j+ywWGahnHQGRr3aRv3luaPBL/gFYAIKNZ
	 lItiXZ4FfEJzdscsaDN8GQep57TEggNTTjTfHW6g6Sd4u8i70Pp2vhIkrHFHu7w/ANNacEXc1as+
	 DJBd9YYy3kVsO6ia7aDxnNJnhpV9Tn3+sjggvghuACRMYOw1nC+rQFZVpPvRZ6+J0eMpY9fE8hBk
	 0WLPovLylxw4kJRTGyHAfSheI3SwPZM2B8gfWuw2/JRmSXOr5JdYHPYiYMEtKEmv8xA3hvPCbvfo
	 sweYhiq5c=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: hverkuil-cisco@xs4all.nl
Cc: eadavis@qq.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	mchehab@kernel.org,
	syzbot+116b65a23bc791ae49a6@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] media/cec/core: fix task hung in cec_claim_log_addrs
Date: Thu, 22 Feb 2024 18:58:54 +0800
X-OQ-MSGID: <20240222105853.1157805-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4fa62e4f-9768-4434-8f7b-24aa3b2a3490@xs4all.nl>
References: <4fa62e4f-9768-4434-8f7b-24aa3b2a3490@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 21 Feb 2024 15:38:47 +0100, Hans Verkuil wrote:
> > After unlocking adap->lock in cec_claim_log_addrs(), cec_claim_log_addrs() may
> > re-enter, causing this issue to occur.
> 
> But if it is called again, then it should hit this at the start of the function:
> 
>         if (WARN_ON(adap->is_configuring || adap->is_configured))
>                 return;
> 
> I'm still not sure what causes the KASAN hung task since I cannot seem to reproduce
> it, and because it is hard for me to find enough time to dig into this.

Please pay attention to the following section of code in cec_config_thread_func():
   3 unconfigure:
   2         for (i = 0; i < las->num_log_addrs; i++)
   1                 las->log_addr[i] = CEC_LOG_ADDR_INVALID;
1573         cec_adap_unconfigure(adap);           // [1], is_configured = false;
   1         adap->is_configuring = false;	   // [2], is_configuring = false;
   2         adap->must_reconfigure = false;
   3         adap->kthread_config = NULL;
   4         complete(&adap->config_completion);
   5         mutex_unlock(&adap->lock);		   // [3], Afterwards

And the following code is included in cec_claim_log-addrs():
   3         } else if (block) {
   2                 mutex_unlock(&adap->lock);
   1                 wait_for_completion(&adap->config_completion);
1607                 mutex_lock(&adap->lock);      // [4], During the period before re obtaining the adap->lock, how did cec_claim_log-addrs() re-enter?

BR,
edward


