Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE217FAC7F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 22:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbjK0VWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 16:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjK0VWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 16:22:47 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74DD1A2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:22:53 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1f9e0e44fecso2334921fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701120172; x=1701724972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pm/kMep9njZjxl+Bq2GOnT8kjtkMlwSLLZmKqM0eDCk=;
        b=CfiNciztm4wcvW+INUWl8axmRto7oFLFUaOcxWCqsC069OB3vOlngrY3H+qX3PqAK2
         r3DM1LrFTBL1t5gA2NvvrJp0XVZcdP2XiixQOPMWpoNZELJ/3zS5H4UJV0KkA3H70QBB
         Kf8lqT6c+RS0XhqEEmqYbtGkIH6la6ha0lsou6CsQ3gncxWe9LoqLzU1+I4tkRR8FOEj
         TWVcFSFHOLyPXTBAWm0gXfLC06IDIhqRK9VT2t2AioO6MzRN4EXdqgefiWouBGTDlg/9
         nyBu2GZMEuuV7YPcPeCSTlyV7jlu6enP0VyRXX5ak14blTK759sVYzlpR3Dmzm84Xowf
         9pTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701120172; x=1701724972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pm/kMep9njZjxl+Bq2GOnT8kjtkMlwSLLZmKqM0eDCk=;
        b=vSvGnn5FpMBs77gwE3qHEJiGEAYGdj3IPnwrZBvBhLAtvrZERypcBRBzfgz5U0Rmi5
         lY0MvLBjc3VeH34tf8Z3Hc4SK9FlD33tzEWX8TMFUTdkqJvpt2DwSQeK5vk+FEi4NfYv
         q5gibI5dY639R1NuCsXaRHd0/JfbawCz8I/zXyq4a0M0dATzGh7EZQnDqbXoXmrbLBvc
         /ulvFBe1ZXUzFyKI8JpfCFM3tI7KB48Cn0Rk73HIJk/Z3ZAcFsipGrGRy91xs/ssqr/f
         jqEnlbjkI+2f0Dd24Vthk+OrErjH7vAzFOQJEyuJ2eoGc8VLqFBJo9GunwdaQcuLVeuO
         QatA==
X-Gm-Message-State: AOJu0YwaPo+6gDC1WfVJLn/7DYX2T8SD2PQwthx2pBY4YRZpt0zgxicb
        A6gS2FdMAhyaJFHJHBkVcEBxGA==
X-Google-Smtp-Source: AGHT+IFn9ut0+wXHavrWe/+fqYS4omXMegJmOQRWKeJvW3yK1z53dv6HcoK1946rO65k6lUhMGldSA==
X-Received: by 2002:a05:6870:9a14:b0:1fa:ca1:1f1c with SMTP id fo20-20020a0568709a1400b001fa0ca11f1cmr16696833oab.44.1701120172233;
        Mon, 27 Nov 2023 13:22:52 -0800 (PST)
Received: from 6VQ5VV3.attlocal.net ([2600:1700:19e0:a90:9595:6582:b5ef:e730])
        by smtp.googlemail.com with ESMTPSA id op12-20020a0568702dcc00b001f93d190984sm2484770oab.19.2023.11.27.13.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 13:22:51 -0800 (PST)
From:   Stanley Chan <schan@cloudflare.com>
To:     linux-pm@vger.kernel.org
Cc:     kernel-team <kernel-team@cloudflare.com>,
        Stanley Chan <schan@cloudflare.com>,
        Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] tools cpupower bench: Override CFLAGS assignments
Date:   Mon, 27 Nov 2023 15:20:48 -0600
Message-Id: <20231127212049.455008-1-schan@cloudflare.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow user to specify outside CFLAGS values as make argument

Corrects an issue where CFLAGS is passed as a make argument for
cpupower, but bench's makefile does not inherit and append to them.

Fixes: dbc4ca339c8d ("tools cpupower: Override CFLAGS assignments")

Signed-off-by: Stanley Chan <schan@cloudflare.com>
---
 tools/power/cpupower/bench/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/bench/Makefile b/tools/power/cpupower/bench/Makefile
index d9d9923af85c..a4b902f9e1c4 100644
--- a/tools/power/cpupower/bench/Makefile
+++ b/tools/power/cpupower/bench/Makefile
@@ -15,7 +15,7 @@ LIBS = -L../ -L$(OUTPUT) -lm -lcpupower
 OBJS = $(OUTPUT)main.o $(OUTPUT)parse.o $(OUTPUT)system.o $(OUTPUT)benchmark.o
 endif

-CFLAGS += -D_GNU_SOURCE -I../lib -DDEFAULT_CONFIG_FILE=\"$(confdir)/cpufreq-bench.conf\"
+override CFLAGS += -D_GNU_SOURCE -I../lib -DDEFAULT_CONFIG_FILE=\"$(confdir)/cpufreq-bench.conf\"

 $(OUTPUT)%.o : %.c
 	$(ECHO) "  CC      " $@
--
2.34.1

