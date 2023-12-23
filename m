Return-Path: <linux-kernel+bounces-10165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 411EE81D101
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4BF1F22F84
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B548BF8;
	Sat, 23 Dec 2023 01:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="FQp0vGLX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B6C53A6
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5543aec7440so2124996a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1703296317; x=1703901117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OrCC8hRkFVVFckIY/fWc4cxoRlnVDDBYGNc0w+EmnM=;
        b=FQp0vGLX21rjkCaUhT2tv/FXpn1PGPF7fhD4FyLhsgDipeL7YoiBfBN4z9UARhtTDp
         mwo0l90Ez2KFQVfN1Lhx7XI45Ohv8v6nGFExGFllRK+QKH/ok7HGaC9QDRgoDaLqbm0D
         7l6Ae1mFdweqxjWMNOc8UQ0dJNURuLuvqcKmSWjIlrCENIb5dPoeEFvKoxVhqgh1k+lJ
         lq7X0MvPZAI1CBnugcDttntUQsgIY6xeGgmn8k+4HoLpsSsBdUg29/cLztqjXroOCpOk
         hvawkV24fqHYyF/QeKsPEIju9H669G6dmT2FLl72vFxJdhHnmf3ABLx/tTpkIK4Usb7Y
         RqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296317; x=1703901117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OrCC8hRkFVVFckIY/fWc4cxoRlnVDDBYGNc0w+EmnM=;
        b=xG7joS06wRcDD2Y8R02rn4bQgBZtxl0/Z5IMuYa0ppQAuuPARWeYGvlmo/k1EdBNWF
         ifBWYw7sBmNBwgchGtxRDUQPh3eOFW35jwA0bwrt50WuF6DQMtkwFNnKvzlm5pPRMJu+
         QDXPXGWq/OU0OSulpken8MKAGgD93DiMwZAIeHjai/gk8OVDqd0asyoR8Dhrkce8wnoY
         Ip0V/OchfznCbBrG6l8bltag4enuUIkXr6N6oyk1bqpHhgskENrpa+5p8TyvAXlwss1d
         lil2WAIs+n1KgxdlcCysTpsM4kPY5qHKjES64i/3gv0PyXuoLOToktHzxdZuOLLTHeKY
         +QxA==
X-Gm-Message-State: AOJu0YxOv05AH1xA4mur3ntmtkwf0PxT1w6bMo5ZADq4KQjDtOmBOqj/
	58M03azBBs8rV0FncCWGayQpxZYiCZty
X-Google-Smtp-Source: AGHT+IF2QJx0hpD1S0saCRTRXdekqadmMshBs22eLDhmipLzzf8AFH5U5Evqak6edD0ufaUBb1rCXQ==
X-Received: by 2002:a50:f695:0:b0:554:730b:8809 with SMTP id d21-20020a50f695000000b00554730b8809mr632294edn.9.1703296317511;
        Fri, 22 Dec 2023 17:51:57 -0800 (PST)
Received: from ukaszb-l.semihalf.net (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e8200b005532a337d51sm3288494eda.44.2023.12.22.17.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:51:57 -0800 (PST)
From: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <lb@semihalf.com>
To: Jason Baron <jbaron@akamai.com>,
	Jim Cromie <jim.cromie@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: Guenter Roeck <groeck@google.com>,
	Yaniv Tzoreff <yanivt@google.com>,
	Benson Leung <bleung@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	Sean Paul <seanpaul@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Simon Ser <contact@emersion.fr>,
	John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	linux-kernel@vger.kernel.org,
	upstream@semihalf.com
Subject: [PATCH v3 05/22] tracefs: add __get_str_strip_nl - RFC
Date: Sat, 23 Dec 2023 02:51:14 +0100
Message-ID: <20231223015131.2836090-6-lb@semihalf.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231223015131.2836090-1-lb@semihalf.com>
References: <20231223015131.2836090-1-lb@semihalf.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jim Cromie <jim.cromie@gmail.com>

This variant of __get_str() removes the trailing newline. It is for
use by printk/debug-ish events which already have a trailing newline.
It is here to support [1] which taught dyndbg to send pr_debug() msgs
to tracefs, via -x/T flag. It "reused" the include/trace/events/printk.h
console event, which does the following:

       TP_fast_assign(
               /*
                * Each trace entry is printed in a new line.
                * If the msg finishes with '\n', cut it off
                * to avoid blank lines in the trace.
                */
               if (len > 0 && (msg[len-1] == '\n'))
                       len -= 1;

               memcpy(__get_str(s), msg, len);
               __get_str(s)[len] = 0;
	),

That trim work could be avoided, *if* all pr_debug() callers are
known to have no '\n' to strip.  While that's not true for *all*
callsites, it is 99+% true for DRM.debug callsites, and can be made
true for some subsets of prdbg/dyndbg callsites.

WANTED: macros to validate that a literal format-str has or doesn't
have a trailing newline, or to provide or trim trailing newline(s?).
Should be usable in TP_printk* defns, for use in new event defns.

[1] https://lore.kernel.org/lkml/20200825153338.17061-1-vincent.whitchurch@axis.com

Cc: <rostedt@goodmis.org>
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: <daniel@ffwll.ch>
Cc: <pmladek@suse.com>
Cc: <sergey.senozhatsky@gmail.com>
Cc: <john.ogness@linutronix.de>
Cc: Simon Ser <contact@emersion.fr>
Cc: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 include/trace/stages/stage3_trace_output.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
index c1fb1355d309..283533a17e62 100644
--- a/include/trace/stages/stage3_trace_output.h
+++ b/include/trace/stages/stage3_trace_output.h
@@ -19,6 +19,19 @@
 #undef __get_str
 #define __get_str(field) ((char *)__get_dynamic_array(field))
 
+#undef __get_str_strip_nl
+#define __get_str_strip_nl(field)                                       \
+	({                                                              \
+		char *s = trace_seq_buffer_ptr(p);                      \
+		size_t len;                                             \
+		trace_seq_printf(p, "%s", __get_str(field));            \
+		trace_seq_putc(p, '\0');                                \
+		len = strlen(s);                                        \
+		if (len && s[len-1] == '\n')                            \
+			s[len-1] = '\0';                                \
+		s;                                                      \
+	})
+
 #undef __get_rel_dynamic_array
 #define __get_rel_dynamic_array(field)					\
 		((void *)__entry + 					\
-- 
2.43.0.472.g3155946c3a-goog


