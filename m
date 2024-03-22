Return-Path: <linux-kernel+bounces-111578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7B0886E07
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615AD1F2248A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D90147793;
	Fri, 22 Mar 2024 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmkZApxX"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BC647A73;
	Fri, 22 Mar 2024 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116525; cv=none; b=qP8Ph2WOeyeH+XdCLlvOntReKStWwagb9S+kELZYvaQJCNkjjNOcEEx1xH5tBYBU0cft/7rQKP2TJbBg/hW3QmE+Shj0S4ug0jm/jFa1qrFYz0PNUWifsDMijla7W8jkXyP1Plqpw3iyejeLJr4Wy37TRLF41rElmtArY/gjFEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116525; c=relaxed/simple;
	bh=UIw0hbWtNaDlGWJzbYyJLOmx5j+S2LrI6K9g4R/oh2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYrhBdL094/O9bvKczeMHaD6K0t+5JwvUp6Xy9y/xWlUY1yxdH7CbkABXM8JxQpKo8jr/NloPiBU8ROiEc8EyvYtaQSoGPL30GNQThP6ZApmdTd543yMIuEgvb/DIJuetwXTmaFu5CkfKcknZOiTCVDt3qPjanNLMqDSZG1wplw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmkZApxX; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-690c43c5b5aso13419826d6.1;
        Fri, 22 Mar 2024 07:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711116523; x=1711721323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GBU+KmNHRv/u1R4uPURpDW3nbDs5YT//LSngK9akqw=;
        b=nmkZApxX5ISs7v4FI/2/hijyw+lD9fQzSU/Ku6Nau0uftC5PCV92DitF1AwuWDXYdC
         /bs1eU6xP/zjQHPcpNEia2Af408Cwi1tv8Knr0VIuwUnD8UwIq8z0KDs1vQiVEkqOWOE
         grqGByejq+wqbrER01ZGSLxTlaiI3ABJduMl1nbIzs+kd0cywFYDCGXUP1DK0eTW04Cg
         +n4Npsgg2X2nojJjAYIS804olcooyL2Z4zaBxc5l6RG5LJF9D/gJN8r7JJPCjelvVE8U
         XwGXdPW9cVE8bgrFEtJWeZK2EfUmh2fXf8Mv16fzXpRUE4boZYCLKwj+h2jRPTkQSdlD
         BsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711116523; x=1711721323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GBU+KmNHRv/u1R4uPURpDW3nbDs5YT//LSngK9akqw=;
        b=qmgDonMuQZJdrhRMvUs4KrunT5uXRTP04FZxeGNJiVK63XFAhOfsyjcpgcKLeKuNFS
         ZGxwfRjf4mmLPQi+FCp7nxwoQcOVmrYh90GGv726hdgaZ6rWZGZD3nAuUqwr6Ifr+fD6
         09cBPnFolDWhfWB9rDrpHfQvDfQOGPOz1PF8wuGTO88SES+1jPMlX5zEpI4ANYcVT3ik
         A2AFraacEPMT9ZpQ9N3UoXYYyUGeyBQk4uJ9CJPG0jHbd7QkezD4hLgohfm3YuM6SEz7
         Qagw+VCgDoYH5wmr1RId3WT6wqR0nwoSrlYrjRjc6X4qPYsYGOocB4tZkmeFC4S2QF4W
         4zdg==
X-Forwarded-Encrypted: i=1; AJvYcCXkrhA7pf9liwuiEw9rAqYUB3DAg4NeXVp5RfdnCvR+w4tFaXcgsWSR58LvDUeze5Fa30GhNl5IOzeLB6Q36+RT6d1msYNuZqRyFx5JkEHskWQ4g5GPpNgC5KsHzbrOcztdgP1KmalO4Z3Gl2l+YWeWfjGYN8bBCKzeEdO6uw==
X-Gm-Message-State: AOJu0YydYMpU/881X/4Iib3aKbSVbYeybxogb3p+BlRgHAGIhGNOv4Ez
	4rUNsE0VOyHmsXLgytjmVqbx95V1MpKNjek1zrJbFn/OJsoMP+S0
X-Google-Smtp-Source: AGHT+IHG8JFIG7cv/R8tzugTW/o95ZEQlG6AsudPtfcpwlxxlHRgCrDVnH3tSxalyUIFHcZ1z13Ajw==
X-Received: by 2002:a05:6214:5183:b0:691:ad5:646b with SMTP id kl3-20020a056214518300b006910ad5646bmr2597975qvb.11.1711116523044;
        Fri, 22 Mar 2024 07:08:43 -0700 (PDT)
Received: from l1441l.thefacebook.com ([2620:10d:c091:600::1:b4ee])
        by smtp.gmail.com with ESMTPSA id kc22-20020a056214411600b0069124fff14esm1099508qvb.138.2024.03.22.07.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:08:42 -0700 (PDT)
From: Daniel Hodges <hodges.daniel.scott@gmail.com>
To: ast@kernel.org,
	pavel@ucw.cz,
	lee@kernel.org,
	linux-leds@vger.kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Hodges <hodges.daniel.scott@gmail.com>
Subject: [PATCH 1/3] leds: trigger: legtrig-bpf: Add ledtrig-bpf module
Date: Fri, 22 Mar 2024 10:08:14 -0400
Message-ID: <ac8e77881212e18d117059a698affd6afc2607af.1711113657.git.hodges.daniel.scott@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711113657.git.hodges.daniel.scott@gmail.com>
References: <cover.1711113657.git.hodges.daniel.scott@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a led trigger that interfaces with the bpf subsystem. It
allows for BPF programs to control LED activity through calling bpf
kfuncs. This functionality is useful in giving users a physical
indication that a BPF program has performed an operation such as
handling a packet or probe point.

Signed-off-by: Daniel Hodges <hodges.daniel.scott@gmail.com>
---
 drivers/leds/trigger/Kconfig       | 10 +++++
 drivers/leds/trigger/Makefile      |  1 +
 drivers/leds/trigger/ledtrig-bpf.c | 72 ++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)
 create mode 100644 drivers/leds/trigger/ledtrig-bpf.c

diff --git a/drivers/leds/trigger/Kconfig b/drivers/leds/trigger/Kconfig
index d11d80176fc0..30b0fd3847be 100644
--- a/drivers/leds/trigger/Kconfig
+++ b/drivers/leds/trigger/Kconfig
@@ -152,4 +152,14 @@ config LEDS_TRIGGER_TTY
 
 	  When build as a module this driver will be called ledtrig-tty.
 
+config LEDS_TRIGGER_BPF
+	tristate "LED BPF Trigger"
+	depends on BPF
+	depends on BPF_SYSCALL
+	help
+	  This allows LEDs to be controlled by the BPF subsystem. This trigger
+	  must be used with a loaded BPF program in order to control LED state.
+	  BPF programs can control LED state with kfuncs.
+	  If unsure, say N.
+
 endif # LEDS_TRIGGERS
diff --git a/drivers/leds/trigger/Makefile b/drivers/leds/trigger/Makefile
index 25c4db97cdd4..ac47128d406c 100644
--- a/drivers/leds/trigger/Makefile
+++ b/drivers/leds/trigger/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_LEDS_TRIGGER_NETDEV)	+= ledtrig-netdev.o
 obj-$(CONFIG_LEDS_TRIGGER_PATTERN)	+= ledtrig-pattern.o
 obj-$(CONFIG_LEDS_TRIGGER_AUDIO)	+= ledtrig-audio.o
 obj-$(CONFIG_LEDS_TRIGGER_TTY)		+= ledtrig-tty.o
+obj-$(CONFIG_LEDS_TRIGGER_BPF)		+= ledtrig-bpf.o
diff --git a/drivers/leds/trigger/ledtrig-bpf.c b/drivers/leds/trigger/ledtrig-bpf.c
new file mode 100644
index 000000000000..e3b0b8281b70
--- /dev/null
+++ b/drivers/leds/trigger/ledtrig-bpf.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * LED BPF Trigger
+ *
+ * Author: Daniel Hodges <hodges.daniel.scott@gmail.com>
+ */
+
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/leds.h>
+
+
+DEFINE_LED_TRIGGER(ledtrig_bpf);
+
+__bpf_hook_start()
+
+__bpf_kfunc void bpf_ledtrig_blink(unsigned long delay_on, unsigned long delay_off, int invert)
+{
+	led_trigger_blink_oneshot(ledtrig_bpf, delay_on, delay_off, invert);
+}
+__bpf_hook_end();
+
+BTF_SET8_START(ledtrig_bpf_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_ledtrig_blink)
+BTF_SET8_END(ledtrig_bpf_kfunc_ids)
+
+static const struct btf_kfunc_id_set ledtrig_bpf_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &ledtrig_bpf_kfunc_ids,
+};
+
+static int init_bpf(void)
+{
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
+			&ledtrig_bpf_kfunc_set);
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
+			&ledtrig_bpf_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
+			&ledtrig_bpf_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SK_SKB,
+			&ledtrig_bpf_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS,
+			&ledtrig_bpf_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT,
+			&ledtrig_bpf_kfunc_set);
+	return ret;
+}
+
+static int ledtrig_bpf_init(void)
+{
+	led_trigger_register_simple("bpf", &ledtrig_bpf);
+
+	return init_bpf();
+}
+
+static void __exit ledtrig_bpf_exit(void)
+{
+	led_trigger_unregister_simple(ledtrig_bpf);
+}
+
+module_init(ledtrig_bpf_init);
+module_exit(ledtrig_bpf_exit);
+
+MODULE_AUTHOR("Daniel Hodges <hodges.daniel.scott@gmail.com>");
+MODULE_DESCRIPTION("BPF LED trigger");
+MODULE_LICENSE("GPL v2");
-- 
2.43.0


