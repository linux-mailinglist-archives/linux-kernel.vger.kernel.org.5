Return-Path: <linux-kernel+bounces-9434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE0A81C56F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449CF2885BD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4110C8CB;
	Fri, 22 Dec 2023 07:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bNvxmtTw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E1CC2C0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 07:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso836670a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 23:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1703229230; x=1703834030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mF1Oc8NobreQOc2tpmqTbwXH8bLvhE0vHoTsTawb3hQ=;
        b=bNvxmtTwuU23DX3ww5DkwDP2p5EMYGXDnAbpmP3ScsSVYlqELJ9cr1FnLH+C8xC0TM
         eSReADPrdFcUScDHACMYN7dFuUUDUWfosEWw3rJR1doxl7M6Zc3snLFbyT6IDMHwnPJC
         nbJ6nR63BI0iQZIoeRLj3BD4iXKid735pxLQlRpWd4UL4b9NV2nR7Eu1PSTns5qdL3/P
         gzR2dUocUqzLY3KUDE8g7kwfQgza1PFPJY1YH8xEwIZwZr5HimVM9KqlVTVHiJYSeGFH
         UAX1jyR7PqIV+4RHOIBgZNE8giuGOzjVhHTjcLYkJ1wB6c0/8pSGwE0pf4zDudh2HYgY
         AeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703229230; x=1703834030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mF1Oc8NobreQOc2tpmqTbwXH8bLvhE0vHoTsTawb3hQ=;
        b=ZgnUvw8kLXVQ0uzwUX+xKVYXRhaAsYbye2X/Hc0c5ZMy/z43NF4PP8jlaK33ayBP4P
         UxkzsENzMv10ktU8nYEtX3zzZfntiFSJEnIb2hCOAfMO42hFQCWOcj3h28Jb2Lnw5uQ6
         AMO6sZ/tVhUb9JwT7P1kCTawzSfP+t6MBWaVw8dXktpSvNR0xv0VGP1NWV/fIWsgNLoP
         Jc4Weu7Ct+XKkMOZQhPm2EawTseQk1d0L9mw49zfmicRh27J/ra4rKS5aj4O+97oDR5g
         ZEerh90yOgZflPRo/3nMbv7Pt1vTWjtc3aTWlVDFxEErPS85cGoueKwnqx2+sBmU71mA
         d76A==
X-Gm-Message-State: AOJu0YwbI0pgH7+vOAMnxxvM+M6TMYbqkBV8FX0dZdjbA6RMX21GUkjM
	Ccr1koItDDUxMMAKLC6bY3NcuE1Czo/lqd+RUzRlqVivG+8FQw==
X-Google-Smtp-Source: AGHT+IG5pXXom2uSUkTXKBNPDJsLBCFfFFmuopQEOGUQhE6sQRUITZ5+gIENTBSHGtRuwE+GPiqgUQ==
X-Received: by 2002:a05:6a20:3244:b0:190:5c3d:95dd with SMTP id hm4-20020a056a20324400b001905c3d95ddmr526823pzc.44.1703229230079;
        Thu, 21 Dec 2023 23:13:50 -0800 (PST)
Received: from GQ6QX3JCW2.bytedance.net ([203.208.189.13])
        by smtp.gmail.com with ESMTPSA id jj4-20020a170903048400b001d3cb4e3302sm2169045plb.214.2023.12.21.23.13.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 21 Dec 2023 23:13:49 -0800 (PST)
From: lizhe.67@bytedance.com
To: dianders@chromium.org
Cc: akpm@linux-foundation.org,
	john.ogness@linutronix.de,
	kernelfans@gmail.com,
	lecopzer.chen@mediatek.com,
	linux-kernel@vger.kernel.org,
	lizhe.67@bytedance.com,
	pmladek@suse.com
Subject: Re: [PATCH 2/4] watchdog/softlockup: Use printk_cpu_sync_get_irqsave() to serialize reporting
Date: Fri, 22 Dec 2023 15:13:41 +0800
Message-ID: <20231222071341.37228-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220131534.2.Ia5906525d440d8e8383cde31b7c61c2aadc8f907@changeid>
References: <20231220131534.2.Ia5906525d440d8e8383cde31b7c61c2aadc8f907@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 20 Dec 2023 13:15:35 -0800, dianders@chromium.org wrote: 

>diff --git a/kernel/watchdog.c b/kernel/watchdog.c
>index b4fd2f12137f..526041a1100a 100644
>--- a/kernel/watchdog.c
>+++ b/kernel/watchdog.c
>@@ -454,7 +454,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
> 	struct pt_regs *regs = get_irq_regs();
> 	int duration;
> 	int softlockup_all_cpu_backtrace = sysctl_softlockup_all_cpu_backtrace;
>-	static DEFINE_SPINLOCK(watchdog_output_lock);
>+	unsigned long flags;
> 
> 	if (!watchdog_enabled)
> 		return HRTIMER_NORESTART;
>@@ -521,7 +521,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
> 		/* Start period for the next softlockup warning. */
> 		update_report_ts();
> 
>-		spin_lock(&watchdog_output_lock);
>+		printk_cpu_sync_get_irqsave(flags);
> 		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
> 			smp_processor_id(), duration,
> 			current->comm, task_pid_nr(current));
>@@ -531,7 +531,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
> 			show_regs(regs);
> 		else
> 			dump_stack();
>-		spin_unlock(&watchdog_output_lock);
>+		printk_cpu_sync_put_irqrestore(flags);
> 
> 		if (softlockup_all_cpu_backtrace) {
> 			trigger_allbutcpu_cpu_backtrace(smp_processor_id());
>-- 

Reviewed-by: Li Zhe <lizhe.67@bytedance.com>

