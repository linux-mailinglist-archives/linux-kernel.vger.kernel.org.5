Return-Path: <linux-kernel+bounces-48461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6BE845C98
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65C43B317B0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B752715CD5E;
	Thu,  1 Feb 2024 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VbdGFprx"
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EA562159
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706803100; cv=none; b=dTsZZVGxEgkc3x8pqGnkBIBVIK8nb59ghyz+8dU6Y94+KkmW+EvMpAtr3zupMyQMvCoJ2qa6vEWnaQB1suR5MRgw1Ta1yG0CwfigsyAzZuyJTNG3e0FbP/4mNcFnNLrpty/M12rj/1Cgjq/zLgz2nAest3xdbbg4pAwoHSVCwng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706803100; c=relaxed/simple;
	bh=ozXxsLBjFZrfleXBGW9rOCSjqD+GK7DvzmkvFe3txRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAKD0PU7srMTJbIzAVtXpL66tSisDmTRlePQPcw/l6M3ivP5w5UeG8X6J/mzQcGBUZA3NAqjLxhmdp4sX0cKrjXnoUflwTTEPkLG/K3HrQCgKgDbJ0KCxTWvdX9LHu6Jy+XXyxowq6db5OR0vBywfOsFn01rXBUIGH1W0xwq338=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=VbdGFprx; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-40e80046264so9797305e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 07:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706803095; x=1707407895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zb2N1SjFXrCezi0DdrzWDAreAVNvluHnD5YFqaNLg/Y=;
        b=VbdGFprxgQA2cTKQj+yVOqrzSxPmSL5Ot5ynbQs//Wmylf5fJhnqWPPsR3KTvWibPs
         Zq/M5GfEM+zu6LGz80kGYp1rY5AoN3QSP4Ep0oOUDe4xSHXqi1+WOrMrs6MTURAwcJzm
         p/9d3I9Ymx8erp208FUw+0pE2lwTJVu+AZuu8krybUktGsUUnbcqkIYznPXoUPxEE6Yt
         vhnTCF+PC10J16Q6llp022ltBv545u6H2St0kZpNvk4qMrJEMvO1/4yk0+sMVlMOtWc6
         jAv2vOvCGkzj0xo8ciBdSV11AtAP1+eWXWaibrUhYhT8fvpO8GuulYJY+L3lm2q1Ycsm
         uPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706803095; x=1707407895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zb2N1SjFXrCezi0DdrzWDAreAVNvluHnD5YFqaNLg/Y=;
        b=vXqDgJhUoluRSPTa8ynJTNhg6rUYNxas7kF658sMG7sngmmJie8hJl7Zr2jfmFqPoz
         ymZXCgepb/0xvfPPcwu6Eo2pMflR+4bkHk1JrLTUDWKX3Bscx/HFziuCGoUPRA6A1baF
         OwGbc8gPlEhJt/ZtIfXiYhI/PhJJ0RF4QiCVIOZHgtmD+xLDPFl8aKczBgjsFDMf0xGt
         24xUk+7VMCtagNSN3XFe0k/Rf5RJO2e4mZJA8krhmXG6P/RxEIL1MIrJFkuVFB5DVYSw
         d82Tp8iAYhB/tuhASeW4Ymg3Ny8JKkjT5K9bXyEGp6KxOn1awTr4rSQGz+las7xyyual
         pFoA==
X-Gm-Message-State: AOJu0YyNkpiJbRiHJLI9DFdACSRCz9xRjmF8foRvJviM0UKK17caLuAE
	5i7v11zfdMBfWLquzCgjmXTl7h2G0YsZoOL0opzN6Rrg/k6UTdPg/ThCd63Cts8=
X-Google-Smtp-Source: AGHT+IFHyevawAIt4/49GDyezXA9WB+8DVF5/C/y1gWx5XY8NHEi0DDUf5DUfrgDT3T8+Vb2xqs2VQ==
X-Received: by 2002:a05:600c:a384:b0:40f:bc67:49ec with SMTP id hn4-20020a05600ca38400b0040fbc6749ecmr1417680wmb.40.1706803095384;
        Thu, 01 Feb 2024 07:58:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVZE3CmS3I509/B+4D1+SyEV9MQ8wzMOeJgw+9jwr4NcwqTvYe4NELBai7km6wiv2eS9ZL/xzCUotLn5uj1Hn5tzLmKGGXIKKYSSmLHcO2QJZ2taHj3WNBJOIll3SbqGezG4sr9D6zSW//jDPmeJTky8Y6iQsH9RTPJ2TL09YoCT4/vMVP7iVEyOVSGqJXpf4f2Ebguu9raToFCQsIkYIZYUGXYUptCrFH7eNf30pfI81N5he23yKQNPKBEznMloI2e29/h4XazUkOVFtCbfAR/zy5whRzrBuEAOzdbvhRG66Zi1sq9ZISL01yn69N0gZ99l3iocsRDKH5op7SFUyHiTe7vNF9IsfA=
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id w13-20020a05600c474d00b0040ec66021a7sm15206wmo.1.2024.02.01.07.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:58:14 -0800 (PST)
Date: Thu, 1 Feb 2024 16:58:12 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: wangkeqi <wangkeqi_chris@163.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, fw@strlen.de,
	wangkeqi <wangkeqiwang@didiglobal.com>,
	kernel test robot <oliver.sang@intel.com>, fengwei.yin@intel.com
Subject: Re: [PATCH net v4] connector: cn_netlink_has_listeners replaces
 proc_event_num_listeners
Message-ID: <Zbu_lBFkeb8NUIek@nanopsycho>
References: <20240131014459.411158-1-wangkeqi_chris@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131014459.411158-1-wangkeqi_chris@163.com>

Wed, Jan 31, 2024 at 02:44:59AM CET, wangkeqi_chris@163.com wrote:
>From: wangkeqi <wangkeqiwang@didiglobal.com>

Care to fix your name please?


>
>It is inaccurate to judge whether proc_event_num_listeners is
>cleared by cn_netlink_send_mult returning -ESRCH.
>In the case of stress-ng netlink-proc, -ESRCH will always be returned,
>because netlink_broadcast_filtered will return -ESRCH,
>which may cause stress-ng netlink-proc performance degradation.
>If the judgment condition is modified to whether there is a listener.

This sentence does not sound complete.


>proc_event_num_listeners will still be wrong due to concurrency.
>So replace the counter with cn_netlink_has_listeners

I'm reading the whole patch description for 5th time, I still don't
understand it :(


>
>Reported-by: kernel test robot <oliver.sang@intel.com>
>Closes: https://lore.kernel.org/oe-lkp/202401112259.b23a1567-oliver.sang@intel.com
>Fixes: c46bfba1337d ("connector: Fix proc_event_num_listeners count not cleared")
>Signed-off-by: wangkeqi <wangkeqiwang@didiglobal.com>

Same here.


>Cc: fengwei.yin@intel.com
>Cc: fw@strlen.de
>---
> drivers/connector/cn_proc.c   | 33 +++++++++++++++++++++------------
> drivers/connector/connector.c |  9 +++++++++
> include/linux/connector.h     |  1 +
> 3 files changed, 31 insertions(+), 12 deletions(-)
>
>diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
>index 3d5e6d705..4898e974c 100644
>--- a/drivers/connector/cn_proc.c
>+++ b/drivers/connector/cn_proc.c
>@@ -85,6 +85,16 @@ static int cn_filter(struct sock *dsk, struct sk_buff *skb, void *data)
> 	return 1;
> }
> 
>+static int cn_netlink_has_listeners(void)
>+{
>+	struct sock *sk = get_cdev_nls();
>+
>+	if (sk)
>+		return netlink_has_listeners(sk, CN_IDX_PROC);
>+	else
>+		return 0;
>+}
>+
> static inline void send_msg(struct cn_msg *msg)
> {
> 	__u32 filter_data[2];
>@@ -108,9 +118,8 @@ static inline void send_msg(struct cn_msg *msg)
> 		filter_data[1] = 0;
> 	}
> 
>-	if (cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
>-			     cn_filter, (void *)filter_data) == -ESRCH)
>-		atomic_set(&proc_event_num_listeners, 0);
>+	cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
>+			     cn_filter, (void *)filter_data);
> 
> 	local_unlock(&local_event.lock);
> }
>@@ -122,7 +131,7 @@ void proc_fork_connector(struct task_struct *task)
> 	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
> 	struct task_struct *parent;
> 
>-	if (atomic_read(&proc_event_num_listeners) < 1)
>+	if (!cn_netlink_has_listeners())
> 		return;
> 
> 	msg = buffer_to_cn_msg(buffer);
>@@ -151,7 +160,7 @@ void proc_exec_connector(struct task_struct *task)
> 	struct proc_event *ev;
> 	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
> 
>-	if (atomic_read(&proc_event_num_listeners) < 1)
>+	if (!cn_netlink_has_listeners())
> 		return;
> 
> 	msg = buffer_to_cn_msg(buffer);
>@@ -176,7 +185,7 @@ void proc_id_connector(struct task_struct *task, int which_id)
> 	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
> 	const struct cred *cred;
> 
>-	if (atomic_read(&proc_event_num_listeners) < 1)
>+	if (!cn_netlink_has_listeners())
> 		return;
> 
> 	msg = buffer_to_cn_msg(buffer);
>@@ -213,7 +222,7 @@ void proc_sid_connector(struct task_struct *task)
> 	struct proc_event *ev;
> 	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
> 
>-	if (atomic_read(&proc_event_num_listeners) < 1)
>+	if (!cn_netlink_has_listeners())
> 		return;
> 
> 	msg = buffer_to_cn_msg(buffer);
>@@ -237,7 +246,7 @@ void proc_ptrace_connector(struct task_struct *task, int ptrace_id)
> 	struct proc_event *ev;
> 	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
> 
>-	if (atomic_read(&proc_event_num_listeners) < 1)
>+	if (!cn_netlink_has_listeners())
> 		return;
> 
> 	msg = buffer_to_cn_msg(buffer);
>@@ -269,7 +278,7 @@ void proc_comm_connector(struct task_struct *task)
> 	struct proc_event *ev;
> 	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
> 
>-	if (atomic_read(&proc_event_num_listeners) < 1)
>+	if (!cn_netlink_has_listeners())
> 		return;
> 
> 	msg = buffer_to_cn_msg(buffer);
>@@ -295,7 +304,7 @@ void proc_coredump_connector(struct task_struct *task)
> 	struct task_struct *parent;
> 	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
> 
>-	if (atomic_read(&proc_event_num_listeners) < 1)
>+	if (!cn_netlink_has_listeners())
> 		return;
> 
> 	msg = buffer_to_cn_msg(buffer);
>@@ -328,7 +337,7 @@ void proc_exit_connector(struct task_struct *task)
> 	struct task_struct *parent;
> 	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
> 
>-	if (atomic_read(&proc_event_num_listeners) < 1)
>+	if (!cn_netlink_has_listeners())
> 		return;
> 
> 	msg = buffer_to_cn_msg(buffer);
>@@ -370,7 +379,7 @@ static void cn_proc_ack(int err, int rcvd_seq, int rcvd_ack)
> 	struct proc_event *ev;
> 	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
> 
>-	if (atomic_read(&proc_event_num_listeners) < 1)
>+	if (!cn_netlink_has_listeners())
> 		return;


Are you still using &proc_event_num_listeners for anything? If not, why
don't you remove it entirely?


> 
> 	msg = buffer_to_cn_msg(buffer);
>diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
>index 7f7b94f61..42bcb39ba 100644
>--- a/drivers/connector/connector.c
>+++ b/drivers/connector/connector.c
>@@ -129,6 +129,15 @@ int cn_netlink_send(struct cn_msg *msg, u32 portid, u32 __group,
> }
> EXPORT_SYMBOL_GPL(cn_netlink_send);
> 
>+struct sock *get_cdev_nls(void)

Perhaps name it cn_cdev_nls_get() to be aligned with the rest?



>+{
>+	if (cn_already_initialized == 1)
>+		return cdev.nls;
>+	else
>+		return NULL;
>+}
>+EXPORT_SYMBOL_GPL(get_cdev_nls);
>+
> /*
>  * Callback helper - queues work and setup destructor for given data.
>  */
>diff --git a/include/linux/connector.h b/include/linux/connector.h
>index cec2d99ae..255466aea 100644
>--- a/include/linux/connector.h
>+++ b/include/linux/connector.h
>@@ -127,6 +127,7 @@ int cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid,
>  */
> int cn_netlink_send(struct cn_msg *msg, u32 portid, u32 group, gfp_t gfp_mask);
> 
>+struct sock *get_cdev_nls(void);

Add empty line.


> int cn_queue_add_callback(struct cn_queue_dev *dev, const char *name,
> 			  const struct cb_id *id,
> 			  void (*callback)(struct cn_msg *, struct netlink_skb_parms *));
>-- 
>2.27.0
>
>

