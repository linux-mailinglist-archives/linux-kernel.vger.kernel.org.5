Return-Path: <linux-kernel+bounces-163833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E5D8B72FD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013441F22478
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CFA12D76E;
	Tue, 30 Apr 2024 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nT+8gAA2"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E84612CDA5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475644; cv=none; b=tKaW8Rmic1dEbIytLEfsv6toIk/DVmpWydHWhhM1gVwetoo4/ay19vGZ+7MiBUZc5bTDpbhYrMLte9H+9FwzkZTy62GT/pvKkEswTZcPfmJehw1NgCHe6Z9uHcrhRFXBJEDg+bL7bNILP4knUwjs/qz8NfMroJn7L7he4jEo82w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475644; c=relaxed/simple;
	bh=l6oDZivJcyQTCOy+gknzagGu6pD9fjWdRZ/T8AH6uxk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Asch1JNKLfNv+SN3gIpXdaJ09warx3YokagTpCV+XZmoIbXnMcAV/0/SNghzYxbkaVJZEbD451RWPEPNhHmbr9ijdrSlllsztadmGVXLo9MzNRVJFEXUxuJkeiwQNY4DAAXQMBu2kq/PRL+oCCQ7jY7el7NY5LwSVh8MhppXvrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nT+8gAA2; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-349cafdc8f0so3335795f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 04:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714475641; x=1715080441; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RPOnWL9RPpAUuW6zSj0DHbUYz85VJ46LckD0gpweWUA=;
        b=nT+8gAA2qUrfL9l5//e+m1h2J/o7rGv6/m6hWNFVR2kVxqceQ6tUKoHdh5StxJO94A
         ZWwrCSMZZmS4yej8JCLUU2z/aW4RSma08IQkXRUXc5Wuanfdh+B685Qr9TMS/SCEus0e
         ZcQOcDyzSkfBYtuHhVu+dCjmN4VD/GbfbLhmBD2kWeD0+qY4wssFRwb6EiTPBErDdS6F
         GywbabcTHreEsPvy5a+UV8FVnuwYz3Ha9WQ4vrvAEH7kG4+aXFozF4yie9bgEuxZhbWo
         wxR9q/0krZaAECxYv/BHAPTIDq5yS9Mr+9mVUjinXt13YnbZHsGieeF0MU81g6PC+Yz7
         RFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714475641; x=1715080441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPOnWL9RPpAUuW6zSj0DHbUYz85VJ46LckD0gpweWUA=;
        b=pT0EBMIkQG2uIeYOVm8YfplzcGBgU+lro6vrm0mt8ErqA3GTo6OHBodN8piPOFEdvk
         2UurcO1e+aNyoJ7dAk0thdkP7J9dF/hXkaBcBJuAbSXQwX3vpas3rhIg3gOvtfX7tpwL
         7XeWfkya9xPRxFWVC8Ph4GbAZIi/m3V0Hl02VKy7pSE519oDIYvrERMP71vjnduKOBWw
         en1NvBKp+Nwz97W1bVOmf/cwE4iZ55MhyLXld5C+xKM3I94cQ6zsg3USK+EMB1Y8Z0a5
         5z0OMmKO+h7i+B16xFELx2+JH0zv+HMpRevA21bJVPYleB1IU0E4/KnistVdDXS7D+ZC
         CoIg==
X-Forwarded-Encrypted: i=1; AJvYcCWME+hBdsgrt2jNzkjr4xyn9kmAqg88/3h7iFPa1eV+oOdzFWAKl8PM3UlBeuk3kDiSMrtWCA83KO8PwaAvSIwfIYAT2CuOHKqqt5j7
X-Gm-Message-State: AOJu0YwBYdf0wPEhxDBo1kSIetz0KW2RUrFh+W6syvvtH/XCtk4C+Zup
	Prnu3XW8qujwkUyBoNJ7qw/lXBC15EvUKcM8m0jit1v3dDIBeveaXQLj7/XhQo4BGKmzRGnLtO5
	+iDuUpBpegZB3V+NQMw==
X-Google-Smtp-Source: AGHT+IGg0qhb/Jba6e9SYF1X563jKL0wCkSy4jPLen+t6O0bQF5/hWi5hJTj+ZQVSBTh2zkExIaXqd4WY26ybQ/A
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6000:d46:b0:34d:a111:5021 with SMTP
 id du6-20020a0560000d4600b0034da1115021mr1931wrb.1.1714475640882; Tue, 30 Apr
 2024 04:14:00 -0700 (PDT)
Date: Tue, 30 Apr 2024 12:13:50 +0100
In-Reply-To: <20240430111354.637356-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240430111354.637356-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240430111354.637356-2-vdonnefort@google.com>
Subject: [PATCH v22 1/5] ring-buffer: Allocate sub-buffers with __GFP_COMP
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	rdunlap@infradead.org, rppt@kernel.org, david@redhat.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for the ring-buffer memory mapping, allocate compound
pages for the ring-buffer sub-buffers to enable us to map them to
user-space with vm_insert_pages().

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 25476ead681b..cc9ebe593571 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1524,7 +1524,7 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 		list_add(&bpage->list, pages);
 
 		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu),
-					mflags | __GFP_ZERO,
+					mflags | __GFP_COMP | __GFP_ZERO,
 					cpu_buffer->buffer->subbuf_order);
 		if (!page)
 			goto free_pages;
@@ -1609,7 +1609,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 
 	cpu_buffer->reader_page = bpage;
 
-	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_ZERO,
+	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_COMP | __GFP_ZERO,
 				cpu_buffer->buffer->subbuf_order);
 	if (!page)
 		goto fail_free_reader;
@@ -5579,7 +5579,7 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 		goto out;
 
 	page = alloc_pages_node(cpu_to_node(cpu),
-				GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO,
+				GFP_KERNEL | __GFP_NORETRY | __GFP_COMP | __GFP_ZERO,
 				cpu_buffer->buffer->subbuf_order);
 	if (!page) {
 		kfree(bpage);
-- 
2.44.0.769.g3c40516874-goog


