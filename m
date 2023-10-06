Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216857BC12D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbjJFVcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbjJFVcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:32:47 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB98BF;
        Fri,  6 Oct 2023 14:32:45 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-352a3a95271so10865655ab.0;
        Fri, 06 Oct 2023 14:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696627964; x=1697232764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7RyRhGZkI7PifyegPZ7pvVCGRJ2K3nUP7lM1odr43Q8=;
        b=fplQtdut0XDwmXW/fRzeHms+V3LNeD74/AiureG+eca8T9rva1PletAtf34cm/Z9G9
         Qwm9lr8CO/ur24ZsCh3AH2BEYTfi0OM5bDvkAT9k2EUgtbDxLLTN9uOxMvl6aDwzQxcj
         3whW6E02sODTER8uf8BJEP9xzj109kIf0xL9LJLyUUDo3bi6287Lm46zLLH0dMx1jR9V
         yna0vxQE/a+HnFH/EZLP/8EG90xgH9RXbLspjk5yE+bkXWAcYA062jKYChYdgrNmk7S1
         0+aAFnKi0aBkMuV/m/Dm+Ypq10iIFRB3pHYV4WXxdHte3FmGbtlwMMoXXhJ9wEQ5GpDH
         Ohtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696627964; x=1697232764;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RyRhGZkI7PifyegPZ7pvVCGRJ2K3nUP7lM1odr43Q8=;
        b=BKZRdGNkkfSMfDxn98NHpygYD598784mVnu/5izJ2rpwFZ7UcRUnv+R1IoOxrsByq3
         foHpM7vTX2Py1RoKaCxpdfnjuPs0qGyCKFAOmkxOB4Sji4Gg6r462fY+c+SemO0gSaQv
         h31rgkV40XU1zQ5L7OTU6Jaeh670yV9HrfOJoWq4Ix7V0nawwU7609NiHDCMR+MLF0Pg
         aRoqvSPWs+Yfqd59P2DLJiMwirkIksraar8TKh64gJxaUxYdVCg7vW1+G2grhHZ5AgRS
         KWwFKcfHr/3n4blTX+SDcWtbtzUoLI1A4GS3Wm6VpZW0hCT2cQS7pfp0DSqqcOGybsSu
         OjzA==
X-Gm-Message-State: AOJu0Yxi0BcsqD/nsYKPtGNanE/mrQYqW8Cdn4VbGkFSjMW1af1FBsYz
        83IIeup5ltFbg8WCbEC6BAPJU/g5FzvW
X-Google-Smtp-Source: AGHT+IFCrbSljojFM4gvefdUaqnt1HH52gs9KS9qqU3zTwn5fRIrCn4Az1FEuCKYtyk+q9UeDDM4EA==
X-Received: by 2002:a05:6e02:216c:b0:352:a73a:16f1 with SMTP id s12-20020a056e02216c00b00352a73a16f1mr9981367ilv.14.1696627964274;
        Fri, 06 Oct 2023 14:32:44 -0700 (PDT)
Received: from [192.168.1.3] ([161.97.241.227])
        by smtp.googlemail.com with ESMTPSA id o14-20020a92c68e000000b0035265088c52sm1316963ilg.34.2023.10.06.14.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 14:32:43 -0700 (PDT)
Message-ID: <80b84be0-a0ad-d1a9-607a-a87c6cf509e0@gmail.com>
Date:   Fri, 6 Oct 2023 15:32:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: [PATCH v4] arch/x86: port I/O tracing on x86
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-serial <linux-serial@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        andriy.shevchenko@linux.intel.com, quic_saipraka@quicinc.com,
        Steven Rostedt <rostedt@goodmis.org>
References: <b8eae358-a3b3-fd68-82f1-b2c53534b922@gmail.com>
 <2023100344-dart-jailbreak-c371@gregkh>
 <94e2b77c-9cc4-534f-e650-06d7e0697f9f@gmail.com>
 <20231004195001.76a57417@gandalf.local.home>
From:   Dan Raymond <raymod2@gmail.com>
In-Reply-To: <20231004195001.76a57417@gandalf.local.home>
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

V3 -> V4:
  - make GPL licenses consistent
  - change pointer arguments from (long) to (void *)
  - eliminate include guard checks and use -DDISABLE_TRACEPOINTS instead to
    disable tracepoints in arch/x86/boot/*
  - fix compiler warnings due to signed/unsigned mismatch in arch_cmpxchg64()

 arch/x86/boot/Makefile            |  1 +
 arch/x86/boot/compressed/Makefile |  1 +
 arch/x86/include/asm/cmpxchg_32.h | 13 ++++----
 arch/x86/include/asm/shared/io.h  |  9 ++++++
 arch/x86/lib/Makefile             |  1 +
 arch/x86/lib/trace_portio.c       | 21 +++++++++++++
 include/linux/trace_portio.h      |  6 ++++
 include/linux/tracepoint-defs.h   |  2 +-
 include/trace/events/portio.h     | 49 +++++++++++++++++++++++++++++++
 9 files changed, 97 insertions(+), 6 deletions(-)
 create mode 100644 arch/x86/lib/trace_portio.c
 create mode 100644 include/linux/trace_portio.h
 create mode 100644 include/trace/events/portio.h

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index ffec8bb01ba8..6cec531be03b 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -70,6 +70,7 @@ KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP
 KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
 KBUILD_CFLAGS	+= $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
+KBUILD_CFLAGS	+= -DDISABLE_TRACEPOINTS
 GCOV_PROFILE := n
 UBSAN_SANITIZE := n
 
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 35ce1a64068b..c368bcc008eb 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -51,6 +51,7 @@ KBUILD_CFLAGS += -D__DISABLE_EXPORTS
 # Disable relocation relaxation in case the link is not PIE.
 KBUILD_CFLAGS += $(call as-option,-Wa$(comma)-mrelax-relocations=no)
 KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
+KBUILD_CFLAGS += -DDISABLE_TRACEPOINTS
 
 # sev.c indirectly inludes inat-table.h which is generated during
 # compilation and stored in $(objtree). Add the directory to the includes so
diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index 215f5a65790f..054a2906eefd 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -37,13 +37,16 @@ static inline void set_64bit(volatile u64 *ptr, u64 value)
 
 #ifdef CONFIG_X86_CMPXCHG64
 #define arch_cmpxchg64(ptr, o, n)					\
-	((__typeof__(*(ptr)))__cmpxchg64((ptr), (unsigned long long)(o), \
+	((__typeof__(*(ptr)))__cmpxchg64((unsigned long long *)(ptr),	\
+					 (unsigned long long)(o),	\
 					 (unsigned long long)(n)))
-#define arch_cmpxchg64_local(ptr, o, n)					\
-	((__typeof__(*(ptr)))__cmpxchg64_local((ptr), (unsigned long long)(o), \
+#define arch_cmpxchg64_local(ptr, o, n)						\
+	((__typeof__(*(ptr)))__cmpxchg64_local((unsigned long long *)(ptr),	\
+					       (unsigned long long)(o),		\
 					       (unsigned long long)(n)))
-#define arch_try_cmpxchg64(ptr, po, n)					\
-	__try_cmpxchg64((ptr), (unsigned long long *)(po), \
+#define arch_try_cmpxchg64(ptr, po, n)			\
+	__try_cmpxchg64((unsigned long long *)(ptr),	\
+			(unsigned long long *)(po),	\
 			(unsigned long long)(n))
 #endif
 
diff --git a/arch/x86/include/asm/shared/io.h b/arch/x86/include/asm/shared/io.h
index c0ef921c0586..82664956ce41 100644
--- a/arch/x86/include/asm/shared/io.h
+++ b/arch/x86/include/asm/shared/io.h
@@ -2,13 +2,20 @@
 #ifndef _ASM_X86_SHARED_IO_H
 #define _ASM_X86_SHARED_IO_H
 
+#include <linux/tracepoint-defs.h>
+#include <linux/trace_portio.h>
 #include <linux/types.h>
 
+DECLARE_TRACEPOINT(portio_write);
+DECLARE_TRACEPOINT(portio_read);
+
 #define BUILDIO(bwl, bw, type)						\
 static inline void __out##bwl(type value, u16 port)			\
 {									\
 	asm volatile("out" #bwl " %" #bw "0, %w1"			\
 		     : : "a"(value), "Nd"(port));			\
+	if (tracepoint_enabled(portio_write))				\
+		do_trace_portio_write(value, port, #bwl[0]);		\
 }									\
 									\
 static inline type __in##bwl(u16 port)					\
@@ -16,6 +23,8 @@ static inline type __in##bwl(u16 port)					\
 	type value;							\
 	asm volatile("in" #bwl " %w1, %" #bw "0"			\
 		     : "=a"(value) : "Nd"(port));			\
+	if (tracepoint_enabled(portio_read))				\
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
index 000000000000..b5f62dfd85a0
--- /dev/null
+++ b/arch/x86/lib/trace_portio.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/instruction_pointer.h>
+#include <linux/trace_portio.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/portio.h>
+
+void do_trace_portio_read(u32 value, u16 port, char width)
+{
+	trace_portio_read(value, port, width, (void *)_RET_IP_);
+}
+EXPORT_SYMBOL_GPL(do_trace_portio_read);
+EXPORT_TRACEPOINT_SYMBOL_GPL(portio_read);
+
+void do_trace_portio_write(u32 value, u16 port, char width)
+{
+	trace_portio_write(value, port, width, (void *)_RET_IP_);
+}
+EXPORT_SYMBOL_GPL(do_trace_portio_write);
+EXPORT_TRACEPOINT_SYMBOL_GPL(portio_write);
diff --git a/include/linux/trace_portio.h b/include/linux/trace_portio.h
new file mode 100644
index 000000000000..2324d62e6c9e
--- /dev/null
+++ b/include/linux/trace_portio.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/types.h>
+
+extern void do_trace_portio_read(u32 value, u16 port, char width);
+extern void do_trace_portio_write(u32 value, u16 port, char width);
diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
index e7c2276be33e..bfe70e17b2aa 100644
--- a/include/linux/tracepoint-defs.h
+++ b/include/linux/tracepoint-defs.h
@@ -80,7 +80,7 @@ struct bpf_raw_event_map {
 #define DECLARE_TRACEPOINT(tp) \
 	extern struct tracepoint __tracepoint_##tp
 
-#ifdef CONFIG_TRACEPOINTS
+#if defined(CONFIG_TRACEPOINTS) && !defined(DISABLE_TRACEPOINTS)
 # define tracepoint_enabled(tp) \
 	static_key_false(&(__tracepoint_##tp).key)
 #else
diff --git a/include/trace/events/portio.h b/include/trace/events/portio.h
new file mode 100644
index 000000000000..7bac3ed197a8
--- /dev/null
+++ b/include/trace/events/portio.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM portio
+
+#if !defined(_TRACE_PORTIO_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_PORTIO_H
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(portio_class,
+	TP_PROTO(u32 value, u16 port, char width, void *ip_addr),
+
+	TP_ARGS(value, port, width, ip_addr),
+
+	TP_STRUCT__entry(
+		__field(u32, value)
+		__field(u16, port)
+		__field(char, width)
+		__field(void *, ip_addr)
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
+		__entry->value, __entry->ip_addr)
+);
+
+DEFINE_EVENT(portio_class, portio_read,
+	TP_PROTO(u32 value, u16 port, char width, void *ip_addr),
+	TP_ARGS(value, port, width, ip_addr)
+);
+
+DEFINE_EVENT(portio_class, portio_write,
+	TP_PROTO(u32 value, u16 port, char width, void *ip_addr),
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
