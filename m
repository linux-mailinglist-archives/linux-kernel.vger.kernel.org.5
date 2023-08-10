Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35367781DC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbjHJTyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjHJTyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:54:24 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127C52722
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:54:24 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bbf0f36ce4so10096215ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691697263; x=1692302063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48XwJVsA5wyW9PXqV/vWWiEsWR0pxxYch//gaCXqyTg=;
        b=B600p5GdQ+dGJFK2CjlcbIfGxqznnTlkVKhTWG0lPs+GsB/Knzz/xcKEKi8/odxuZ0
         Z1s80apT3MGBisC29BUKnZrCbQFOxaC5trZf0RmpRDr1Ggq004KPCg/JZYmPL7AAth0Y
         L+NYoOHQ9W99krwLn2fkTiCj8SYvT6Q+YfJrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691697263; x=1692302063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48XwJVsA5wyW9PXqV/vWWiEsWR0pxxYch//gaCXqyTg=;
        b=VK9+gWs066TLKWCKdPjKu4mYud8Qq7tXN0nx6EiT/ePd4GX8ukUioYnU7UpzcgNfKg
         2JmPOW4u1j1ch92iDnjH0geQhMQr+s7gvCWLUsAXiI6TPcD+IlUrtLfUx1Vt9R3cdOyQ
         BmYlpcu5LZsOrOuLCg1AESdvyOaBgq6onkMF8LJR3N66IhXIILlq+sg7T7K0ED/wLMAy
         szCZPLLz2EMxasJVa99kE2Eqz4CvFdDgYrzKUb2INr9DPGwKcP4hawb/UqFyglyzJUa9
         ey6xldBJz1b1bL/E/34CCvJjgp4rOD9d/9oPCyCNA2DXjhhaxVSH7Rc70D/TOi8kDd3F
         khjg==
X-Gm-Message-State: AOJu0YwX6Rj9cpppVBNR106Ex/JmHYsn6YsexInEvkRLHrASFMjmD2lE
        J2ujLEKCC1lTPxbwAPazMRlR2Q==
X-Google-Smtp-Source: AGHT+IE12uIfTTq88knRn0gncFdLQlCuaARRsIkO0Tck6br3otfYQy5pMeQhjo47X03xSvYmLAj4xQ==
X-Received: by 2002:a17:902:c106:b0:1bc:4f04:1803 with SMTP id 6-20020a170902c10600b001bc4f041803mr2898883pli.29.1691697263554;
        Thu, 10 Aug 2023 12:54:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m7-20020a170902768700b001b9be79729csm2161055pll.165.2023.08.10.12.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:54:22 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@kernel.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 2/2] ARM: ptrace: Restore syscall skipping for tracers
Date:   Thu, 10 Aug 2023 12:54:19 -0700
Message-Id: <20230810195422.2304827-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810195141.never.338-kees@kernel.org>
References: <20230810195141.never.338-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2072; i=keescook@chromium.org;
 h=from:subject; bh=oCWnlkmzbAIe4y4dp/g4gh1pykyxBgo3Lt1j/Yzh81Y=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk1UBroXLDSt36LBKBH3QD1hB/vWj2UTsr5QAof
 8bYgVNi7yaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZNVAawAKCRCJcvTf3G3A
 JhOSD/9egw+u3pp34j8SsLGazqJO8pUmQ3eoesW1ZAnDfKQWK6+9+qROic8FR4oMNRdG3vBA167
 Iete1wjq6L9dXIEP8cnmk9Y6p1X5OTt6lh8rFbMwphF0JngJLxGdOPRb+RItyGPse1e6zjUPJKt
 sQTT7MSsl7k2U1J3JyYgTPsUvUG9+aJ+sqYnq3ExujVcRDJ0iyHc9MmkuHm/zcGLJicwv6UqcU/
 U1ewaZUtURzBPCi6zAZVe2hIoVVpmZ5esGIz/OUAgbbg9xwqq/tWEQtbgdt44SPulMIfYhLrQsA
 r8IrCKAuYvHj/tcr7uKPwAOKnEk2hXT0EN3RPnrv+CdFeNwFhuMVhJJMRWSXB0RukPOv4XTRyr/
 v7pQl3eYKX0fimxJsTBEvxCulx05tA9aP0iXoQwzewliaMiN9oItXQ3JIHnFv5Y6YG0++qI7NXH
 so8XY0O2jAP4bo/TC6demv4khUn6c+WKL+5IgoVLEk1vXu01rn3MYqCWQ3SyGpIEhu/1jfYJBHw
 4z3WoePObVEpi1bGfuJaDpdpwqbo7tlHTg5SIJPc8qE03fGCrSr0OoW64IAhrLmGcDGK4dquONs
 qx3CT/hY8VcPETTijHzGMizxdZyUpkfg1hvilRLaY2tt1mOxw1QbdrF/umpiU4z4999RR63arEk QWzSNu0rNWdKkYA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 4e57a4ddf6b0 ("ARM: 9107/1: syscall: always store
thread_info->abi_syscall"), the seccomp selftests "syscall_errno"
and "syscall_faked" have been broken. Both seccomp and PTRACE depend
on using the special value of "-1" for skipping syscalls. This value
wasn't working because it was getting masked by __NR_SYSCALL_MASK in
both PTRACE_SET_SYSCALL and get_syscall_nr().

Explicitly test for -1 in PTRACE_SET_SYSCALL and get_syscall_nr(),
leaving it exposed when present, allowing tracers to skip syscalls
again.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Fixes: 4e57a4ddf6b0 ("ARM: 9107/1: syscall: always store thread_info->abi_syscall")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/include/asm/syscall.h | 3 +++
 arch/arm/kernel/ptrace.c       | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index dfeed440254a..fe4326d938c1 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -25,6 +25,9 @@ static inline int syscall_get_nr(struct task_struct *task,
 	if (IS_ENABLED(CONFIG_AEABI) && !IS_ENABLED(CONFIG_OABI_COMPAT))
 		return task_thread_info(task)->abi_syscall;
 
+	if (task_thread_info(task)->abi_syscall == -1)
+		return -1;
+
 	return task_thread_info(task)->abi_syscall & __NR_SYSCALL_MASK;
 }
 
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 2d8e2516906b..fef32d73f912 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -783,8 +783,9 @@ long arch_ptrace(struct task_struct *child, long request,
 			break;
 
 		case PTRACE_SET_SYSCALL:
-			task_thread_info(child)->abi_syscall = data &
-							__NR_SYSCALL_MASK;
+			if (data != -1)
+				data &= __NR_SYSCALL_MASK;
+			task_thread_info(child)->abi_syscall = data;
 			ret = 0;
 			break;
 
-- 
2.34.1

