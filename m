Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13917C7433
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379597AbjJLRWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379599AbjJLRVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:21:50 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D96CF;
        Thu, 12 Oct 2023 10:21:48 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-79f9acc857cso43705839f.2;
        Thu, 12 Oct 2023 10:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697131308; x=1697736108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ctyB3lbzkdQhDzqOoTWBErv3Q5efkvJrKvFBj8oTC8=;
        b=RLN5mrT2l6Z2Oe729HjIhZ4Z4utZSdrSpCCLxkFIonGJ1vuzCmPA8Q4YzqrdkCc1l8
         xKXpsBU80oH9I6E337eV0eMJ0wYZqWdm8h4pxI+Y+1klUE3uRDeOSI7UZHPE9NYkKM/n
         amGHIJuSVI9u3pee0u62AqLSb3kexRMGssEWsWPhbvdUYBCpWowNUz3rzFFqknSnhJJg
         whsvaH5UX0e+qP4ArwLUdKP2MN/NueL7IKRczj2T/2POogXgraejd8A1VCDhZukFOuWH
         TNfpEktD+GpsKk1uZJoDmahk1mR1sF23kUeKJlzTPkjRuU+6M94OYTj1HcJzNY4xYWhp
         uVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697131308; x=1697736108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ctyB3lbzkdQhDzqOoTWBErv3Q5efkvJrKvFBj8oTC8=;
        b=ntb1aiRfeMBCXfiAYxwC6nJesMSWuKWfQBFP9/K8eamBsiems3c48wyxYJxyu8YhEC
         td9b9ciqNlRb7T76kXlINr847Ns0m1TO0kuMFRFYyxZ40pEf4GWk3ld6I/DB8REEhzcG
         S0HqJAMP6YZBEkKC8LoXn/SbT8kNoqgrW0chQ78yEqMthjq8gru7aX6FileXS7TpCsJS
         2G4+vzqsXWf5Oss/vtrKLUlvGdUo0zwsU/LQmSzjEBDFupAskXUEg1y0ZjoHbLPnTVbN
         ix0i2xs//SJPadvaHDVaXmsBtqWa+IuRQ493pnspe4sTEAHMpNbYK56otYGv2RXZ7pMb
         jeRg==
X-Gm-Message-State: AOJu0YwpawZBT7QwOX6QFKXG+7+ZQY7fGJaY/1D0uCZTAa9g/aA2H9GN
        chDq3vfJ818j7Ktzd4mmUpgrZwZ5vCJ0HQ==
X-Google-Smtp-Source: AGHT+IEYEoup2+xxLMAtY5S5JU/QjH2X7dDsZoIBInq6ntlj/YADC88/xMNNWWbfetWVAVtM9gkktA==
X-Received: by 2002:a5e:8815:0:b0:790:fab3:2047 with SMTP id l21-20020a5e8815000000b00790fab32047mr27393492ioj.4.1697131307754;
        Thu, 12 Oct 2023 10:21:47 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id r25-20020a028819000000b0043cef0711c1sm3992211jai.158.2023.10.12.10.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:21:47 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, groeck@google.com, yanivt@google.com,
        bleung@google.com, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7 02/25] dyndbg: reword "class unknown," to "class:_UNKNOWN_"
Date:   Thu, 12 Oct 2023 11:21:13 -0600
Message-ID: <20231012172137.3286566-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012172137.3286566-1-jim.cromie@gmail.com>
References: <20231012172137.3286566-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This appears in the control-file to report an unknown class-name, which
indicates that the class_id is not authorized, and dyndbg will ignore
changes to it.  Generally, this means that a DYNDBG_CLASSMAP_DEFINE or
DYNDBG_CLASSMAP_USE is missing.

But the word "unknown" appears in quite a few prdbg formats, so thats
a suboptimal search term to find occurrences of the problem.  Thus
change it to "_UNKNOWN_" which properly shouts the condition.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 6fba6423cc10..ceb3067a5c83 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1151,7 +1151,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-			seq_printf(m, " class unknown, _id:%d", dp->class_id);
+			seq_printf(m, " class:_UNKNOWN_ _id:%d", dp->class_id);
 	}
 	seq_puts(m, "\n");
 
-- 
2.41.0

