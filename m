Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429717B3A75
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbjI2TPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbjI2TPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:15:47 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1608B1A4;
        Fri, 29 Sep 2023 12:15:46 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3515694c6d0so21918105ab.3;
        Fri, 29 Sep 2023 12:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696014945; x=1696619745; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OpH82fkJb1r8H6PlyZZgPkFgJZH8W/NgIZwFg6SwnA=;
        b=ks+0weUA3KKzcwhXoAZAcjWbwd48zDbW11ZpW9yhH52mPSaM7Q/tCWL8/HzhvFw3A4
         suoH3U7wR/SKQwkb+UDmjBQdny9SW203CWoOxRlK4NFizZPCCsIviAi3O3Jj1iM/XW7X
         lntDEzXR50LI23XvIvNH0UldTpxeMQf2LSx0zxDuDnJ7mLVnFCqryTtKE9P1dGjR/wPp
         jiwaqYGz7I8Mh+HOfPvdqIgTv6DCv9ktu4aIceNpZtnY5Fe7fg181FVj3pik+8vobLoN
         58bprFoOhgQUJmHSiMqDnfJ9dMkvjdD82PS4+pHQpzS9qNEANnZSSrSI71FSdbzfzY2d
         nKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696014945; x=1696619745;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7OpH82fkJb1r8H6PlyZZgPkFgJZH8W/NgIZwFg6SwnA=;
        b=nBfqeXrMMvEOYGSFSUdcDa4A9G0IUsSWPj2HSwO6gnFpSVSwW8rzUckURD6pZX1g6N
         yOPx0bQMwqb62E2z3LLG16xCseWKitewJjmVu8DkMf3gpcbK4eFZtV8M1WOMHa2PtSpq
         HNd4p9f9K4B9gmm0qstvjmXAbNrEqTjzbnXV+tqKW6SEGoH/uodwljwPZ7mbIc0j5hvg
         gfLRdx7+9ZLz5aHCxvmDhuRAcn9FbmfcIvrWxVCoXK4FA/7wppSmYhbAM9rJIKd9KBaP
         sDREBLI5+AurT77USfs5im5v8LbN85O63yfRvYBtuxZLvg1jeVO/1eMkS3GqbP8ZYSLm
         BLWg==
X-Gm-Message-State: AOJu0YyehOd7neAGWxnXK65DPS+lBzFjai2+ekg0QReqcTFZPnoxRG9E
        YFo19e5JN0lkv2xKg9Soemd2Vnbd6nJy
X-Google-Smtp-Source: AGHT+IFm3t6NoH0pp/F+gSs5SeeH0HDBHBe1tPQhBq65tEyy3rnTwTGDVTsX90Snj482upIAIt+JuA==
X-Received: by 2002:a05:6e02:168a:b0:351:5137:e885 with SMTP id f10-20020a056e02168a00b003515137e885mr6043740ila.24.1696014944814;
        Fri, 29 Sep 2023 12:15:44 -0700 (PDT)
Received: from [192.168.1.3] ([161.97.241.227])
        by smtp.googlemail.com with ESMTPSA id g6-20020a02c546000000b004290f6c15bfsm5357202jaj.145.2023.09.29.12.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 12:15:44 -0700 (PDT)
Message-ID: <b8eae358-a3b3-fd68-82f1-b2c53534b922@gmail.com>
Date:   Fri, 29 Sep 2023 13:15:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-serial <linux-serial@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com
From:   Dan Raymond <raymod2@gmail.com>
Subject: [PATCH v3] arch/x86: port I/O tracing on x86
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for port I/O tracing on x86.  Memory mapped I/O tracing is
available on x86 via CONFIG_MMIOTRACE but that relies on page faults
so it doesn't work with port I/O.  This feature uses tracepoints in a
similar manner as CONFIG_TRACE_MMIO_ACCESS.

Signed-off-by: Dan Raymond <raymod2@gmail.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
V1 -> V2:
  - create header file for prototypes to silence new compiler warning
  - reduce CPU overhead to 2 instructions (no branching) when tracing disabled
  - fix imprecise IP logging by retrieving the IP off the stack instead of using
    compile time labels

V2 -> V3:
  - restore missing semicolon

 arch/x86/include/asm/shared/io.h | 25 ++++++++++++++++
 arch/x86/lib/Makefile            |  1 +
 arch/x86/lib/trace_portio.c      | 21 ++++++++++++++
 include/linux/trace_portio.h     |  6 ++++
 include/trace/events/portio.h    | 49 ++++++++++++++++++++++++++++++++
 5 files changed, 102 insertions(+)
 create mode 100644 arch/x86/lib/trace_portio.c
 create mode 100644 include/linux/trace_portio.h
 create mode 100644 include/trace/events/portio.h

diff --git a/arch/x86/include/asm/shared/io.h b/arch/x86/include/asm/shared/io.h
index c0ef921c0586..9e5dce1cb62d 100644
--- a/arch/x86/include/asm/shared/io.h
+++ b/arch/x86/include/asm/shared/io.h
@@ -2,13 +2,36 @@
 #ifndef _ASM_X86_SHARED_IO_H
 #define _ASM_X86_SHARED_IO_H
 
+#include <linux/trace_portio.h>
 #include <linux/types.h>
 
+/*
+ * We don't want the tracing logic included in the early boot modules (under
+ * arch/x86/boot) so we check for their include guards here.  If we don't do
+ * this we will get compiler errors.  These checks are not present in
+ * arch/x86/include/asm/msr.h which contains similar tracing logic.  That is
+ * possible only because none of the msr inline functions are instantiated in
+ * the early boot modules.  If that changes this issue will need to be addressed
+ * there as well.  Therefore it might be better to handle this centrally in
+ * tracepoint-defs.h.
+ */
+
+#if defined(CONFIG_TRACEPOINTS) && !defined(BOOT_COMPRESSED_MISC_H) && !defined(BOOT_BOOT_H)
+#include <linux/tracepoint-defs.h>
+DECLARE_TRACEPOINT(portio_write);
+DECLARE_TRACEPOINT(portio_read);
+#define _tracepoint_enabled(tracepoint) tracepoint_enabled(tracepoint)
+#else
+#define _tracepoint_enabled(tracepoint) false
+#endif
+
 #define BUILDIO(bwl, bw, type)						\
 static inline void __out##bwl(type value, u16 port)			\
 {									\
 	asm volatile("out" #bwl " %" #bw "0, %w1"			\
 		     : : "a"(value), "Nd"(port));			\
+	if (_tracepoint_enabled(portio_write))				\
+		do_trace_portio_write(value, port, #bwl[0]);		\
 }									\
 									\
 static inline type __in##bwl(u16 port)					\
@@ -16,6 +39,8 @@ static inline type __in##bwl(u16 port)					\
 	type value;							\
 	asm volatile("in" #bwl " %w1, %" #bw "0"			\
 		     : "=a"(value) : "Nd"(port));			\
+	if (_tracepoint_enabled(portio_read))				\
+		do_trace_portio_read(value, port, #bwl[0]);		\
 	return value;							\
 }
 
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index f76747862bd2..254f223c025d 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -40,6 +40,7 @@ $(obj)/inat.o: $(obj)/inat-tables.c
 clean-files := inat-tables.c
 
 obj-$(CONFIG_SMP) += msr-smp.o cache-smp.o
+obj-$(CONFIG_TRACEPOINTS) += trace_portio.o
 
 lib-y := delay.o misc.o cmdline.o cpu.o
 lib-y += usercopy_$(BITS).o usercopy.o getuser.o putuser.o
diff --git a/arch/x86/lib/trace_portio.c b/arch/x86/lib/trace_portio.c
new file mode 100644
index 000000000000..c048dffcfe05
--- /dev/null
+++ b/arch/x86/lib/trace_portio.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/instruction_pointer.h>
+#include <linux/trace_portio.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/portio.h>
+
+void do_trace_portio_read(u32 value, u16 port, char width)
+{
+	trace_portio_read(value, port, width, _RET_IP_);
+}
+EXPORT_SYMBOL_GPL(do_trace_portio_read);
+EXPORT_TRACEPOINT_SYMBOL_GPL(portio_read);
+
+void do_trace_portio_write(u32 value, u16 port, char width)
+{
+	trace_portio_write(value, port, width, _RET_IP_);
+}
+EXPORT_SYMBOL_GPL(do_trace_portio_write);
+EXPORT_TRACEPOINT_SYMBOL_GPL(portio_write);
diff --git a/include/linux/trace_portio.h b/include/linux/trace_portio.h
new file mode 100644
index 000000000000..013418d3d2ae
--- /dev/null
+++ b/include/linux/trace_portio.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#include <linux/types.h>
+
+extern void do_trace_portio_read(u32 value, u16 port, char width);
+extern void do_trace_portio_write(u32 value, u16 port, char width);
diff --git a/include/trace/events/portio.h b/include/trace/events/portio.h
new file mode 100644
index 000000000000..3591a75a475e
--- /dev/null
+++ b/include/trace/events/portio.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM portio
+
+#if !defined(_TRACE_PORTIO_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_PORTIO_H
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(portio_class,
+	TP_PROTO(u32 value, u16 port, char width, long ip_addr),
+
+	TP_ARGS(value, port, width, ip_addr),
+
+	TP_STRUCT__entry(
+		__field(u32, value)
+		__field(u16, port)
+		__field(char, width)
+		__field(long, ip_addr)
+	),
+
+	TP_fast_assign(
+		__entry->value = value;
+		__entry->port = port;
+		__entry->width = width;
+		__entry->ip_addr = ip_addr;
+	),
+
+	TP_printk("port=0x%04x value=0x%0*x %pS",
+		__entry->port,
+		__entry->width == 'b' ? 2 :
+		__entry->width == 'w' ? 4 : 8,
+		__entry->value, (void *)__entry->ip_addr)
+);
+
+DEFINE_EVENT(portio_class, portio_read,
+	TP_PROTO(u32 value, u16 port, char width, long ip_addr),
+	TP_ARGS(value, port, width, ip_addr)
+);
+
+DEFINE_EVENT(portio_class, portio_write,
+	TP_PROTO(u32 value, u16 port, char width, long ip_addr),
+	TP_ARGS(value, port, width, ip_addr)
+);
+
+#endif /* _TRACE_PORTIO_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>

base-commit: be8b93b5cc7d533eb8c9b0590cdac055ecafe13a
-- 
2.25.1
