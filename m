Return-Path: <linux-kernel+bounces-27085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EFA82EA29
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850F41F23858
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A1011724;
	Tue, 16 Jan 2024 07:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DN3Wn/J6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F41F11185
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705390634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ifuB2nXxZ75f/0o9jfEcxBCR2xBlDBFXcm7tsMurvx8=;
	b=DN3Wn/J68CHLDpQoopH1N7WmI3RBFfxz1uwooicAPHa8gEnDaoNXu/aE9P/WnRGN4TYiV/
	vR3NF2PVVPAzdhSw1DEFFc2qA7e9PgJoD6wW/xUJL7hHnAuc2G25R93BSiMtu8yln2P64j
	t0JO7CsvRPVrv802MSAXhslXEBFuxJM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-AmET61Z6Nl-7TzgXhwI8jg-1; Tue, 16 Jan 2024 02:37:08 -0500
X-MC-Unique: AmET61Z6Nl-7TzgXhwI8jg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-428205848e9so142719241cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 23:37:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705390628; x=1705995428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ifuB2nXxZ75f/0o9jfEcxBCR2xBlDBFXcm7tsMurvx8=;
        b=XtGJOHlw9u0RGpIz/Zn2cUjm2XbJnIZrBQrjinKKo/pVeb1kAhCe4rCTUVv8IjFbSK
         ZO3v5eQgUjqqp7Qy8AjfIEIFX5jJBWJZwyH9++cXTI5p5tXGpK5twQZnLzaSiDhhLhwa
         pTJyBZGfXCMwEkKUkjzHta3kKnwHJgajBovUHTY+8rpmZam0PXRTZeth1yAt1WpNRumf
         nTY/tq6oQCWdyL/6aDRsNgY43U7u8m6jji6xAnjJHRbvzlnAjwV625HEfVk1Hu+SGvRA
         fVAswskccGuFHpTb1CZaYXZwAlvmvZCZxef7Eo4UcqCFBO2C0P2JfghPNccbYlIiOEWb
         BcZw==
X-Gm-Message-State: AOJu0Yy07fX+t12h/H7zjU+cMzhP8hZRtNDYIsVQNH20p9C3p2OKLMY9
	bTLY3jjjFX/aNFPAogwb9xBst6c0oN+2XMWMPAc7l4cxJYUiGKin878xvItkZjykJu0X5EovInO
	nAG3aFAKOyCw6KRLn4CUCx/aYhn8Z6H4a
X-Received: by 2002:a05:622a:211:b0:429:c790:ebdf with SMTP id b17-20020a05622a021100b00429c790ebdfmr9463956qtx.57.1705390627778;
        Mon, 15 Jan 2024 23:37:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoUNoDlbGf/fiBqS4v0YOD/PMs99/j/caanq3n4OchIyfV9K41nntX6SIsYQuhld+55fjHbA==
X-Received: by 2002:a05:622a:211:b0:429:c790:ebdf with SMTP id b17-20020a05622a021100b00429c790ebdfmr9463948qtx.57.1705390627556;
        Mon, 15 Jan 2024 23:37:07 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:64aa:6db9:6544:60c:9e16])
        by smtp.gmail.com with ESMTPSA id jc4-20020a05622a714400b00429acfe5bb4sm4650206qtb.40.2024.01.15.23.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 23:37:07 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [RESEND RFC PATCH v1 0/2] Fix serial console for PREEMPT_RT
Date: Tue, 16 Jan 2024 04:36:58 -0300
Message-ID: <20240116073701.2356171-1-leobras@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While dealing with a bug that breaks the serial console from qemu (8250)
after printing a lot of data, I found some issues on this driver on RT
as well as spurious IRQ behaviors that don't seem to be adeqate for RT.

Comments:
Patch #1:
I found out this driver get an IRQ request for every tx byte, but the
handler is able to deal with sending multiple bytes per "thread wake up". 

Since the irqs_unhandled keep growing, and theads_handled don't change
as often, after some intense load (tx ~300kBytes) the serial will 
disable the IRQ line for this driver, which ultimately breaks the console.

My fist solution kept track of how many requests given handler dealt with,
which got added to theads_handled. On note_interrupt I got the diff from
theads_handled_last and subtracted that diff from irqs_unhandled.

This solution required a change in the irqreturn_t typedef and a bunch of
helpers and defines, as well as adapting the 8250 driver. 
At the end seemed like a overcomplicated solution for the issue, but it
can be an alternative if the current solution is considered imprecise.

Mu cyrrent solution on patch #1 is much simpler, just keeping the
IRQ enabled as long as the irq_thread deal with any IRQ request before
irqs_unhandled hitting the limit value.

Patch #2:
In RT, the 8250 driver has an issue if it's interrupted while holding the
port->lock. If the interruption needs to printk() anything, it
will try to get the port->lock, which is busy, so spin_lock() will try
to reschedule the interruption, which is in atomic context, and will 
trigger a bug.

This bug reproduces quite often, like in 50% of tests I did. 

The only thing I could think of for fixing this is using in_atomic()
when PREEMPT_RT=y, so it makes use of the same mechanism as for
oops_in_progress to avoid getting the lock if it's busy. It's working
just fine.

Yeah, I got the warning in checkpath:
"ERROR: do not use in_atomic in drivers"

So I need some feedback on what to do to avoid this bug, if not 
by using in_atomic() at this driver.

Since this one is linked to the console, any printk will try to get
this drivers port->lock, and so it's kind of hard to avoid this accesses.

I though on doing an interface for spin_lock_only_if_can_sleep() but
it seemed overkill.

Please provide comments / feedback.

Thanks!
Leo


Leonardo Bras (2):
  irq/spurious: Reset irqs_unhandled if an irq_thread handles one IRQ
    request
  serial/8250: Avoid getting lock in RT atomic context

 drivers/tty/serial/8250/8250_port.c | 2 +-
 kernel/irq/spurious.c               | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)


base-commit: 052d534373b7ed33712a63d5e17b2b6cdbce84fd
-- 
2.43.0


