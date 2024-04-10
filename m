Return-Path: <linux-kernel+bounces-137871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7351989E8A2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7D45285C2B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5415CC133;
	Wed, 10 Apr 2024 04:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzMuyXVP"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2C5C2C6;
	Wed, 10 Apr 2024 04:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712721610; cv=none; b=CZpMKZNiB4nBBqyMJdZQ2yBwEmIgK08wyIU3iDS9i6jhrQ3VjXEJRpHh8RAVr3+8NWiuIyVWhkL9qf0OqiXGXaBhsACzSrtmYzPSN1sciXNC7VE69o69clBN07glPPhQjEJjZmAcXYm+4T3wOw4RmnzDGojxmpQ5XgydK1FD4GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712721610; c=relaxed/simple;
	bh=NtI0xN3dWIHgnuVFP5emBfSv80l93K/NAVupuO8w05w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXpBqgl2T0W2Xf3pH/ye4Zntbv6eOa0uNIZTm9q4NMqYyfRYc+5vAjye5zsJRSRGwuB+XA91dKPFd0CAf+XAc+rWEOVkbYa+cfbayYugoDx7p6SNEClWYWydS8UhXyExGi86WKN63OXKzF0avqsrFr5JyyGY+RGz056HoHEZcVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzMuyXVP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-343e70dd405so4250947f8f.3;
        Tue, 09 Apr 2024 21:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712721607; x=1713326407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtI0xN3dWIHgnuVFP5emBfSv80l93K/NAVupuO8w05w=;
        b=TzMuyXVPReh6DoIvrctOKcWk0w7xJVEd8NRoNH3SKPTbgqV+gX0iNBKJg6YdiA+6fD
         6Iia9fI9u/vuGzlGdTPE20inRNUcKU6ghCEqGOoJaS5P/w/zxaf6d7E0hn97v9IqUnA7
         KlLcHGIhs+xUUgTt+D+V2UcNMcZjJuy1+JDC9gCVxSYcyv/bc/qZ5z9AJeqheQLa5mcQ
         HPRHc/rw/wN2ggYyq3o/BiSrimUpJ2AkFN97ZMnvljIZ1t9iZfHYWCh2dP22j2TeB/ms
         afWddYQbXxcAfyD+spO7qp+0GlVK803tewmR9roToyCcR/7RY0eDLlGi7hVLces58OHZ
         L4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712721607; x=1713326407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NtI0xN3dWIHgnuVFP5emBfSv80l93K/NAVupuO8w05w=;
        b=qBnup8g61CoZglgBdpSmfGfL8S18dmeq0UPWLp0zB7qbRdPAlWASU1qSFT25dfpTNX
         Jcfh6CmGN97yWpLjC/ldNL+Fv0wg6zVhuHC/JrU6qXMNCmL1eJgOd3XZiKHZlzBNAQ6P
         3uG6YbglvnUQeUpjpo3LPiLdYVap7VneF9xq3V98cjScJO+u5A31pD9lHo5UFEZp3Gn+
         OY53+Nd0gmY0Pv0kP8UcPLwqvq7nQGQ9kygD49kqshhpfgngce3xjdRMkcPjxSj0ZnIE
         EbaMr6WeAmEmzG7o5SxTrOhdN7LgyzX3+LwdjxmSyT+nXDsRmE1Z4OJbOt2kWe5qHu4h
         3lwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ3mBiyPa0TwCsfvtwKY9pOWXdIVlZbsZcHiszQ/qhCrtEQ7S+883kjIGWJuqMh+rG/PQxQQRiiiGsOxGiJhDHZHBXoY6kBLpCSuMR4Af8/tJ8hS4e5KtopCpURtbspn8TPC4VABRNpu6h
X-Gm-Message-State: AOJu0YzNHTuerAd/qRiSNmbRuEOBvhQikRpWFwThvt2QltY8KUoviU5g
	jUZcM6bQjHXblyCGckIri71XZdR+hvA87ee2WM+LROW2mgPjCEy0/60xRWlz3GiUIoC+H5Ch4dc
	I8UuysnyiGnqRVIpAXIPCQ4C/c0Y=
X-Google-Smtp-Source: AGHT+IFtNSB7v0/NPoH41VWxU2JkNU3nhYJOFnq1c9q7jleCq4KGdhGAc0vtuTzPduNdY1xd55Y8nZFBCpviYCTBvPU=
X-Received: by 2002:a05:6000:2a3:b0:343:8551:8d90 with SMTP id
 l3-20020a05600002a300b0034385518d90mr1602342wry.34.1712721607135; Tue, 09 Apr
 2024 21:00:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409020326.2125332-1-liu.yec@h3c.com> <20240410020615.2885000-1-liu.yec@h3c.com>
In-Reply-To: <20240410020615.2885000-1-liu.yec@h3c.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 10 Apr 2024 06:59:30 +0300
Message-ID: <CAHp75VdZF-Qi-9ahhXTLxdQqVb7wBJu7KqjD8xj6byVC5W+-yw@mail.gmail.com>
Subject: Re: [PATCH V10] kdb: Fix the deadlock issue in KDB debugging.
To: liu.yec@h3c.com
Cc: daniel.thompson@linaro.org, gregkh@linuxfoundation.org, 
	dianders@chromium.org, jason.wessel@windriver.com, jirislaby@kernel.org, 
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 5:07=E2=80=AFAM <liu.yec@h3c.com> wrote:
>
> From: LiuYe <liu.yeC@h3c.com>
>
> Currently, if CONFIG_KDB_KEYBOARD is enabled, then kgdboc will
> attempt to use schedule_work() to provoke a keyboard reset when
> transitioning out of the debugger and back to normal operation.
> This can cause deadlock because schedule_work() is not NMI-safe.
>
> The stack trace below shows an example of the problem. In this
> case the master cpu is not running from NMI but it has parked
> the slave CPUs using an NMI and the parked CPUs is holding
> spinlocks needed by schedule_work().
>
> Example:
> BUG: spinlock lockup suspected on CPU#0. owner_cpu: 1
> CPU1: Call Trace:
> __schedule
> schedule
> schedule_hrtimeout_range_clock
> mutex_unlock
> ep_scan_ready_list
> schedule_hrtimeout_range
> ep_poll
> wake_up_q
> SyS_epoll_wait
> entry_SYSCALL_64_fastpath
>
> CPU0: Call Trace:
> dump_stack
> spin_dump
> do_raw_spin_lock
> _raw_spin_lock
> try_to_wake_up
> wake_up_process
> insert_work
> __queue_work
> queue_work_on
> kgdboc_post_exp_handler
> kgdb_cpu_enter
> kgdb_handle_exception
> __kgdb_notify
> kgdb_notify
> notifier_call_chain
> notify_die
> do_int3
> int3
>
> We fix the problem by using irq_work to call schedule_work()
> instead of calling it directly. This is because we cannot
> resynchronize the keyboard state from the hardirq context
> provided by irq_work. This must be done from the task context
> in order to call the input subsystem.
>
> Therefore, we have to defer the work twice. First, safely
> switch from the debug trap context (similar to NMI) to the
> hardirq, and then switch from the hardirq to the system work queue.

..

> Signed-off-by: Greg KH <gregkh@linuxfoundation.org>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> V9 -> V10 : Add Signed-off-by of Greg KH and Andy Shevchenko, Acked-by of=
 Daniel Thompson

Huh?!

--=20
With Best Regards,
Andy Shevchenko

