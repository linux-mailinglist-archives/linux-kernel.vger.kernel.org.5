Return-Path: <linux-kernel+bounces-154418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA09E8ADBD6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A9D1F21A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97081947D;
	Tue, 23 Apr 2024 02:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbaOGWXc"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC5218AEA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 02:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713838863; cv=none; b=NgTg0QzNTbfrO/Yof0772Ii0aL8P3lspB1WMbKpVpZUol6tTQ2HZg9IMxFWmaKE3972Q/p5IABgYWbsV6Ivi+BSYJiTnrAVQc9iCmyS9aF2QGD5XqLspWUM7QKkfS1l0n8e7uS0VLbBVrPQwwmNEj6w5npL8BWrycJ5+v58dWdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713838863; c=relaxed/simple;
	bh=8Ibj4thCAh6i50cqtS856hkkUxnvWGF8MvlKu5e36XE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjIaT2RVggvKOt0kJW/Qxha0f64pDUM22sAmip7AQdTVg6BP+pofqioVaSu3p/O4OlKT7M9hYUaglXvudfGJOhb/kVn4tkxsYOlYwgAd/sM+rkpZtqjpp1TsOszMigkD28eSRafv4jxPySOvERjeluqU7ws7m6d1JTUBIUN67WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbaOGWXc; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5d8b519e438so4004860a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713838861; x=1714443661; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B7CVLFkG4LVPo9khN3K18ng6Nrhw4sSOvkWg8BF2MNI=;
        b=ZbaOGWXcaIpPlxj0wwW0R96jtUEUin6GO/nGtCllxZVMvnrkqQfHFETuaH1uEZryKj
         sU3VpbfcV4W9KSry3iW80ZlQ0VQaGea8S1GSDisl9gNBO8QMOATjN2r01NPHiH1ZAvjw
         JKxiVyy6OB67FBOQe0lod+vfChtv7AtoDf3c41dgatA8AGcdEC/s4UgFywAp7Nv0DW5R
         cp7y9/Ms2jlhsbPEugacyMeW8dpbJ5jjCI+l+4mN8zoLDrJ4Cn5mi2AP1ns9lgpy0B3Q
         tmQpqk4ed1pJxy9svUMQgMw6E1eNQyxavjr2DmCk4FI7dnpwKh7QvRoxCZMHSYm3TgSZ
         9j/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713838861; x=1714443661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7CVLFkG4LVPo9khN3K18ng6Nrhw4sSOvkWg8BF2MNI=;
        b=uLKn6U5VqvAbFv7X3CJP1cfnS1W1nrbbT+bL0miXd47i3289qg0VPUcUb1J14ZQrcU
         94jXGZs6x40mClH/j/JHNzjVNl5YN0ZsIqnER12RUw7UQYSdYuB7zQCYvz92AfpZF7n/
         hnnh8SRiKy9i3hwTbf+XIn3d1ZNg//6zU7fFkTZHUmvhL/OaN9QFUBZmhniZ2SR5w7jX
         6xCXZbQe2agzM+02gymgM7GdjhjPTzP5IYPiCyax9CZir9gNKDHwngGwifQzo4aPVXRs
         Zf3OczAN+g8QFgdkoRgbxYvdRJxDFSkBpbHLHszsAFj3ZdOVyM5csEr3fyIDp8eNuj0O
         XZmw==
X-Forwarded-Encrypted: i=1; AJvYcCVn3ZtY68HrmOfyytYVCQRQZQ6jAOuTeBVIehuBN9OmwfKXcJVbzAoMzUGpg1F7q4l87O+5E+JIBW+aue8Ba1hJ6Wej+IBymxQIiD3W
X-Gm-Message-State: AOJu0YxT857rSyswvornhDEZFO+2VGhoc4ETpNEdsD87jAUBW0DdG0iD
	bXRJ5+BnBCq7xQj3+5uXyeq3Dga52ehJsxEnvKK1CbqNfOpZ7yOMmmDMV/RTExozuCOxla8Z2Gr
	1aDGY0gjbBtxaM8wXhRhfIpavin4=
X-Google-Smtp-Source: AGHT+IF1KU7bM1eO/yByr6ZXa5w/F1/EnCu8+uWSl4H6fmRlW1IYqaJQtKXE5WaaOvypmoTQGarVp1LzazbUFWZ7j50=
X-Received: by 2002:a17:90a:f408:b0:2a2:775:9830 with SMTP id
 ch8-20020a17090af40800b002a207759830mr10656584pjb.11.1713838860940; Mon, 22
 Apr 2024 19:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000b24903061520f3e9@google.com> <CALm+0cWx1kYtftE4nj7Jjgx2_bmNmSrBAgd36ksSvxJtNVhxHg@mail.gmail.com>
 <CALm+0cWRC1kqLJvmEqda4O97PZ-n0R0UQ35=fi6oA3rLsPoUSQ@mail.gmail.com>
 <8f281a10-b85a-4586-9586-5bbc12dc784f@paulmck-laptop> <CALm+0cWN0+cCsYddBUefya3aUw9c9Xn89GVV=Ys1_UPjS19WrQ@mail.gmail.com>
 <4c09abb6-4f6e-42d7-9944-c5da995649cb@paulmck-laptop> <CALm+0cVaLfE2ieK9aqh9yHkPDyO7zWbMe9K6WjTUgm4t9SnSFQ@mail.gmail.com>
 <ac7bf2c3-c752-46db-a5c8-0c55a1af8561@paulmck-laptop> <CALm+0cXGBPWxiNOkAoQG4hdnKCeVVR-APbfBPk9OGeU2RW+bKA@mail.gmail.com>
 <87o7a1umj3.ffs@tglx>
In-Reply-To: <87o7a1umj3.ffs@tglx>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Tue, 23 Apr 2024 10:20:49 +0800
Message-ID: <CALm+0cUesD9KaWyfsRUyGdErbrU11sAfRgRR=Qjyz7Boq9Vt=g@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] WARNING: suspicious RCU usage in __do_softirq
To: Thomas Gleixner <tglx@linutronix.de>
Cc: paulmck@kernel.org, 
	syzbot <syzbot+dce04ed6d1438ad69656@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

>
> On Fri, Apr 19 2024 at 13:50, Z qiang wrote:
> >> On Thu, Apr 18, 2024 at 05:49:38PM +0800, Z qiang wrote:
> >  static __init int spawn_ksoftirqd(void)
> >  {
> > +       int cpu;
> > +
> > +       for_each_possible_cpu(cpu)
> > +               per_cpu(ksoftirqd_work, cpu) = false;
>
> First of all that initialization is pointless, but why making all of
> this complex as hell?
>
> Thanks,
>
>         tglx
> ---
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index b315b21fb28c..e991d735be0d 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -508,7 +508,7 @@ static inline bool lockdep_softirq_start(void) { return false; }
>  static inline void lockdep_softirq_end(bool in_hardirq) { }
>  #endif
>
> -asmlinkage __visible void __softirq_entry __do_softirq(void)
> +static void handle_softirqs(bool kirqd)
>  {
>         unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
>         unsigned long old_flags = current->flags;
> @@ -563,8 +563,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>                 pending >>= softirq_bit;
>         }
>
> -       if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
> -           __this_cpu_read(ksoftirqd) == current)
> +       if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kirqd)
>                 rcu_softirq_qs();
>
>         local_irq_disable();
> @@ -584,6 +583,11 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>         current_restore_flags(old_flags, PF_MEMALLOC);
>  }
>
> +asmlinkage __visible void __softirq_entry __do_softirq(void)
> +{
> +       handle_softirqs(false);
> +}
> +
>  /**
>   * irq_enter_rcu - Enter an interrupt context with RCU watching
>   */
> @@ -921,7 +925,7 @@ static void run_ksoftirqd(unsigned int cpu)
>                  * We can safely run softirq on inline stack, as we are not deep
>                  * in the task stack here.
>                  */
> -               __do_softirq();
> +               handle_softirqs(true);

Thanks, this is good for me :),
Paul, what do you think?

Thanks
Zqiang

>                 ksoftirqd_run_end();
>                 cond_resched();
>                 return;

