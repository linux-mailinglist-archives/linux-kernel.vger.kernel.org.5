Return-Path: <linux-kernel+bounces-27084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 558BA82EA27
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9961C2135A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008C311188;
	Tue, 16 Jan 2024 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ith7n4y8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96C710A3F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705390632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9a7YoYgTaMNvrbxSQpm4NYpVm30/3iqFRoXOjmXJSA=;
	b=ith7n4y8h+utdcah9HGlnWhpmYe1JN8aGMyya2/blHAO1d9bnwD6SuqK8w4IhqaBNwwy36
	CaVKsMpRZ9A1F1bDoDWhzRgLKdzxN1Lnf3s4+Ni3ObWrpYxGcd8Y3RuQUAn4B4viDiIVee
	CI7o9HkctglROxKG1bXGEcGqNH6gphA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-BJkHoMYCPFyEGygFVg_ZWQ-1; Tue, 16 Jan 2024 02:37:11 -0500
X-MC-Unique: BJkHoMYCPFyEGygFVg_ZWQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-429f3c43c66so16579301cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 23:37:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705390630; x=1705995430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9a7YoYgTaMNvrbxSQpm4NYpVm30/3iqFRoXOjmXJSA=;
        b=RcRK0rl4RTOBGFZLKzDBlsmUqc7U6BEyWPKv5lK7qdPN9QHIwlmQd2h9qFPoH+Im5C
         MEkgBB7eI3HeXqFpnmt0otGnwooDZ2DV3HLfG8Ns1OcxS0o9GNSR6YtQXvU1KUMcOcyB
         /eRxaLMwEfXRvv/jB46QUAsAbkUwwJjuZ4WPsL9okuuNE6+InyrYbm+4NkAMkoBJUv4+
         v0ns8LuPMrYeQZaTaftbLgB9eCaYVQBjV+tnidc0JNB3MzadG7i+4xmoz+ijT9HZsK32
         rh8mlS2VrN5+bPAUSR4AWGEZYFPedShhDS8Mq9fDO4WuzZWF7o+cpltQ1IkjonQI0r80
         Sxkw==
X-Gm-Message-State: AOJu0YxdlCda82aFfCrWx59raEQKuyPpkmNIAwsGPKoXYFZqad82z2Vt
	I2Bog6jRUCq1Qii6+iAipF9DvoAKYQFdjJ5a9TKt071T4dKAIQIdSQNnpYdRtag7m3So+AMq3vH
	s1ySM7RX8UrSSvFyl/KLGwGqH29Qbmf5tGdKwEqWz
X-Received: by 2002:ac8:7d82:0:b0:42a:165:a216 with SMTP id c2-20020ac87d82000000b0042a0165a216mr853357qtd.136.1705390630232;
        Mon, 15 Jan 2024 23:37:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoBXmiC8fe9ZYUdR4WPMlWlaDwt97enJcNUHmw2NJlRzZEKeUUWUQutGVSJwOkOdiSj1cATw==
X-Received: by 2002:ac8:7d82:0:b0:42a:165:a216 with SMTP id c2-20020ac87d82000000b0042a0165a216mr853351qtd.136.1705390630010;
        Mon, 15 Jan 2024 23:37:10 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:64aa:6db9:6544:60c:9e16])
        by smtp.gmail.com with ESMTPSA id jc4-20020a05622a714400b00429acfe5bb4sm4650206qtb.40.2024.01.15.23.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 23:37:09 -0800 (PST)
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
Subject: [RESEND RFC PATCH v1 1/2] irq/spurious: Reset irqs_unhandled if an irq_thread handles one IRQ request
Date: Tue, 16 Jan 2024 04:36:59 -0300
Message-ID: <20240116073701.2356171-2-leobras@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116073701.2356171-1-leobras@redhat.com>
References: <20240116073701.2356171-1-leobras@redhat.com>
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


