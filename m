Return-Path: <linux-kernel+bounces-27082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A5A82EA1C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 387F4B21F2E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBC41118B;
	Tue, 16 Jan 2024 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pem2HKej"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B12811181
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705390510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t9a7YoYgTaMNvrbxSQpm4NYpVm30/3iqFRoXOjmXJSA=;
	b=Pem2HKejS/xbLFfBm2go5HPcXRJ/WjEy0kl9hhLZcHixswfs56COmoSjGJT3swkkxHYHw+
	9ejOCHJd3jP7N40d7EYlA89ydP1H9ScxPv3hjFevGv6dQ2PXWQizjKUa9s0zBVOEH29DJf
	lMszm5iEt4XiE/NmO64LTWJYyd073zQ=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-nZWQT_bTOTeiRLG9QAmArg-1; Tue, 16 Jan 2024 02:35:08 -0500
X-MC-Unique: nZWQT_bTOTeiRLG9QAmArg-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5e9074bb7c5so138091587b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 23:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705390508; x=1705995308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t9a7YoYgTaMNvrbxSQpm4NYpVm30/3iqFRoXOjmXJSA=;
        b=fT3qPlPWhAiKOheipBe426S/JzxXc9CeXVvU7mJoFLzt5q1NGq9ZUw39CR/vzjfw+k
         FSVATxLka+VcftlVzGvj6NMnr1EG0IB7lFMOGfwsZl/GP/0GU6KzH42NeMelTjQxWLid
         aDkFMyjO60iOAUg1LCXd5GI5fBuC1v02Dy2fcXkj0xK45b4CxU6MWmiu26GKdtJytMSK
         hvg96GxgSnrjWpqIq8G/B1KiR4WkF2TGUtCCSvbcVjp7QSPyT3Jlh+vcv117kChrIygf
         n7TbwdYIWfRZhH192Y9SH32SJCMNvDnVdqoPMqLs+mRM5AiTAGc0ewgCQGESRkDppUSF
         WYhg==
X-Gm-Message-State: AOJu0YzMRElgT0G6RX4U3zPDPVvt1IGxaQZtCfI52NEH0d2C8pooVFAp
	2TVZSJQQnulZ6J4YtgOgaoJHvOt11bd2DBswF2gk+4NXSPS34N4sWbMm3dAwWsn8F2IHI/9sNq4
	xZQvbwTzLyHEzxWw4/mWqjV7kr4WNxfcm
X-Received: by 2002:a0d:e601:0:b0:5ff:50ad:11a2 with SMTP id p1-20020a0de601000000b005ff50ad11a2mr399978ywe.21.1705390508315;
        Mon, 15 Jan 2024 23:35:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWZSu9/bTKy6f7poFspHtkX5aG+TnbxTIauQYab4L8lwEFl7nqYxAEZEXiHv3v1c6IaylsNQ==
X-Received: by 2002:a0d:e601:0:b0:5ff:50ad:11a2 with SMTP id p1-20020a0de601000000b005ff50ad11a2mr399976ywe.21.1705390508110;
        Mon, 15 Jan 2024 23:35:08 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:64aa:6db9:6544:60c:9e16])
        by smtp.gmail.com with ESMTPSA id x22-20020a05620a0ed600b007831c7989a4sm3541913qkm.22.2024.01.15.23.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 23:35:07 -0800 (PST)
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
Subject: [RFC PATCH v1 1/2] irq/spurious: Reset irqs_unhandled if an irq_thread handles one IRQ request
Date: Tue, 16 Jan 2024 04:34:57 -0300
Message-ID: <20240116073502.2356090-1-leobras@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the IRQs are threaded, the part of the handler that runs in
interruption context can be pretty fast, as per design, while letting the
slow part to run into the thread handler.

In some cases, given IRQs can be triggered too fast, making it impossible
for the irq_thread to be able to keep up handling every request.

If two requests happen before any irq_thread handler is able to finish,
no increment to threads_handled happen, causing threads_handled and
threads_handled_last to be equal, which will ends up
causing irqs_unhandled to be incremented in note_interrupt().

Once irqs_unhandled gets to ~100k, the IRQ line gets disabled, disrupting
the device work.

As of today, the only way to reset irqs_unhandled before disabling the IRQ
line is to stay 100ms without having any increment to irqs_unhandled, which
can be pretty hard to happen if the IRQ is very busy.

On top of that, some irq_thread handlers can handle requests in batches,
effectively incrementing threads_handled only once despite dealing with a
lot of requests, which make the irqs_unhandled to reach 100k pretty fast
if the IRQ is getting a lot of requests.

This IRQ line disable bug can be easily reproduced with a serial8250
console on a PREEMPT_RT kernel: it only takes the user to print a lot
of text to the console (or to ttyS0): around 300k chars should be enough.

To fix this bug, reset irqs_unhandled whenever irq_thread handles at least
one IRQ request.

This fix makes possible to avoid disabling IRQs which irq_thread handlers
can take long (while on heavy usage of the IRQ line), without losing the
ability of disabling IRQs that actually get unhandled for too long.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 kernel/irq/spurious.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index 02b2daf074414..b60748f89738a 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -339,6 +339,14 @@ void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret)
 			handled |= SPURIOUS_DEFERRED;
 			if (handled != desc->threads_handled_last) {
 				action_ret = IRQ_HANDLED;
+
+				/*
+				 * If the thread handlers handle
+				 * one IRQ reset the unhandled
+				 * IRQ counter.
+				 */
+				desc->irqs_unhandled = 0;
+
 				/*
 				 * Note: We keep the SPURIOUS_DEFERRED
 				 * bit set. We are handling the
-- 
2.43.0


