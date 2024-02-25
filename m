Return-Path: <linux-kernel+bounces-79970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BAA86290E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 05:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0211F281D95
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 04:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A70748D;
	Sun, 25 Feb 2024 04:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="YMYngnUC"
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD2B46A0
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 04:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708834046; cv=none; b=a+3hE4UmV8+laR3FJoI1DEzXYjSL3cSX9Plgxr/lUDV0nsXGuOuXZd/cBZ74e9dhvckN8A+Bo6KieXz1QIDKXwEgZHNGzSQk3tPs4A6PKaUWOxHTd8/nntkpgN25HEmPHWmZcdJZx5Ex6Tgu6fql8+6yvxJjdStUe3i/LvXgGMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708834046; c=relaxed/simple;
	bh=HLF+O/C3VXa6M8BYuuzaqawu+wmmS18aerFyo1QYTbY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=ggBt3Blwo94gjMUoJY92MBUitBatREO/JUTLD9TrOPus/75Ds+z9nwcHi2UI6tt5TpqUQSwMzXMpBRLpdBXxLSxfNDAhoFZregQD9JxkLeq77SwHm8S1Rep3eQHZ3JnmileErLaglY1nP4T7wWvk26MKzLwGRmLmoiQxxMkzGZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=YMYngnUC; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1708834041;
	bh=59IuGjIu0z5/HQW09u+ZVejbVCT8iRknbhvMeWWNcGk=;
	h=From:To:Cc:Subject:Date;
	b=YMYngnUCs8zNc1B+VtJ4DonA0E1ovU6QWcILGwHCo91Molr4FcIipxO/+mDCiyGaZ
	 eSDxRB4He4lH8Rq8oD58oUoGXsvJ7SX4UChb+rw8WkPbZfCtjQBuSWuLqZP0W4WUWb
	 56YoKt97h962DIhAP5eVSDxewtyU1YmEPKE2lBog=
Received: from localhost.localdomain ([2409:8a60:2a61:ef40:480f:5c56:cca3:1b20])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 18993038; Sun, 25 Feb 2024 12:06:09 +0800
X-QQ-mid: xmsmtpt1708833969tfxhuw8jo
Message-ID: <tencent_275FF7F351D515B570D0F82447BA30F3AA06@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur95qgJaW4jYhCw4+afUk5zIXLMnvgSORBekwDI69L4NNvN9DlZKL
	 RvT+AtAYo+eEa42vzUaptpzPuB2eDvGX0bFVLQwyjj3vldnOH0YMXpDhaCQIuaHw9a8fCGzT/Gp+
	 QwILmQjPD4Nk/V2lUI5Rv5dofkFf1f7ttuIUj+PZdAuSbEMxrnlbcFyi6YIqOh4qF6V4hR8xsjPt
	 WR6jIJdjXPeeT7EQsEA/PR+b9UPfGI4mi6mMKDfWyTLhNd3l2GCB/74n8Tz+2VzUhccm5O3q+djC
	 iXWBhnN15Q6+rqEynmJseiinsi9TU6msoF1sHRyH5KA1IyUcNmkTEsj3paJ6V1Z3Uz14Nnte7E4V
	 sF6xi8xQsC2aQuufCy+aH27XjeYbcMFzFlD3ytb9ruEIf8jO0JKcnEd0MVBnNCtTi3GtFvEfHfL4
	 x1RPdS4a0SKNXd+UCZ5CygdvmZB1f/6C8kz3/AyDJjPsX+mJan1aFROMnpHNLUqIt4PLE/swKu1W
	 /Y9YfghDJ9solljQlVYcGR5ZRNaBZnnKV/EMoDn/q3l/rlmy+5pKBAD2I/RBKX+Tts9IzQAg+mHR
	 oJS367V+KFTAs9f7Pzpf7pP88uCVi0VWuGD7vFplL+Fb6LEgHJTMpLNVPC6hpfLucoGA4mHKjomL
	 /cI/+kl9JSJdRP96D+PK+2+4W0wsAxHtnT8ZrDD0+wfqmQ9d3CkyU7R3ubfDwxQ6A73XGAW+MRQ+
	 ZfiumXMBgnr8BkrU0tJr7kSOYJVzHgHsLq6nQG0DTab6O+oLeZn5T/mMO39KlUPj/XJrByuecxvl
	 2oYpTTGTPJh3IMp6ixUDwUEL0tgSWrsZsg2+/b2ljqe1Zh8qGqXzB/wYiFQI/xUqAeZvUWjwfaQ4
	 53t6NtS2KG6NKQjfGJjm6UXxy8NZRxYhxa6/hDxBMYJFb1jbLcqaCswer2fNy6O5No2SbbLwQNRM
	 P55V5R3wEFF1Mk5/zxBFIdDGHjMASnYpaSV/u2fkWyQTJBoJX98eNMPLBTDdhX86reYMrfzDhHci
	 JCxy9bnUSo3A4OznzGc8OOPDKqVh0=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: wenyang.linux@foxmail.com
To: Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>,
	davem@davemloft.net,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Wen Yang <wenyang.linux@foxmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] introduce sysctl SYSCTL_U8_MAX and SYSCTL_LONG_S32_MAX
Date: Sun, 25 Feb 2024 12:05:30 +0800
X-OQ-MSGID: <20240225040538.845899-1-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wenyang.linux@foxmail.com>

The boundary check of multiple modules uses these static variables (such as
two_five_five, n_65535, ue_int_max, etc), and they are also not changed.
Therefore, add them to the shared sysctl_vals and sysctl_long_vals to avoid
duplication. This also reduce the size a bit 

Wen Yang (8):
  sysctl: introduce sysctl SYSCTL_U8_MAX and SYSCTL_LONG_S32_MAX
  rxrpc: delete these duplicate static variables n_65535 and four
  net: ipv6: delete these duplicate static variables two_five_five and
    minus_one
  svcrdma: delete the duplicate static variables zero
  sysctl: delete these duplicate static variables i_zero and
    i_one_hundred
  epoll: delete these duplicate static variables long_zero and long_max
  fs: inotify: delete these duplicate static variables it_zero and
    it_int_max
  ucounts: delete these duplicate static variables ue_zero and
    ue_int_max

 fs/eventpoll.c                   |  7 ++-----
 fs/notify/inotify/inotify_user.c | 11 ++++-------
 include/linux/sysctl.h           | 15 +++++++++------
 kernel/sysctl.c                  |  4 ++--
 kernel/ucount.c                  |  7 ++-----
 lib/test_sysctl.c                |  6 ++----
 net/ipv6/addrconf.c              | 12 +++++-------
 net/rxrpc/sysctl.c               | 16 +++++++---------
 net/sunrpc/xprtrdma/svc_rdma.c   | 21 ++++++++++-----------
 9 files changed, 43 insertions(+), 56 deletions(-)

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

-- 
2.25.1


