Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0717EE975
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 23:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345562AbjKPWns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 17:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345568AbjKPWno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 17:43:44 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EE0127
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 14:43:41 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7a66b5f7ea7so45289739f.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 14:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700174620; x=1700779420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2UNwLHsfjJtEfaIA7r+LiQYjr8iboIsfl4RMvTTOCM=;
        b=Az5QZQD6IcXGkFGd6alyN5flrwC/TGD2Vjaa6i2niOFaYlbGVLjqa839GuwhzsCDsw
         pQArccb7jGddA+kgxJ7RGPRFw2+3AfdSHq0ceUz+3t4+gufTDBxmUdxPLoPVNBWRj0vw
         0kMkEq4Bf5YX9UVxAurSW0dETZh4FP5upx67MTBL7VknwBAPm7ShWMohTCj0WKpb1zOf
         s9rmeOEgyy1KlQZVg3Yik+tlYEYkDIJOHNOhiRC5mcgPJM+nTMSlX2m827nosA3pEGFm
         lyWAYwnJG6CFHatd+ESJDEEKqdhnYDx11S/X9+m66PFxixBWxqm3xYFxXPbS4uj482BI
         xx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700174620; x=1700779420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2UNwLHsfjJtEfaIA7r+LiQYjr8iboIsfl4RMvTTOCM=;
        b=nZELDeJ9s9ND+azJ6RJoTwquHKcncdwbz1ypcUitL02uP3t3pst5z7Eg9MPhj0ZqOQ
         VfPwxBX6amOMoU0/xQVCz7JRr6HEDvvZy5H9DnMbke7uHM7ZRnm0gL08Dg6kvKzilClT
         Qp8K3ZttB8ExIpsmocO6Xq59Mn9Y7eUKvIxEPYaD2M5yUiwbmuN1FmPc52fHhzX3slJY
         beJqrW/Om77FIxblCZN6HISlJlhJO15fn178d1XQJAjmIhjqEjLjHw0qwLRm0Rzt+BlQ
         KSC+l3d3mRZZGe8nwKXkCgzAnBfaG/QItThWHV/gP5Zrk+OS+eNY2u3sJanQx3dUAypG
         2p8w==
X-Gm-Message-State: AOJu0Ywff48nTIevFEoZB5+u4HX4MRjbRQroUvdeVEiTDIAYIkzgq626
        pbbtzSN6AimORSpYVsH/fPU3mK5riIk=
X-Google-Smtp-Source: AGHT+IHEdYzDr/CpQ63JjHbr4tjlaXNxSmZ+9XTVRMKqfx+b2O3TJdsZu+kftxvAU6VxDxFwx8f3ag==
X-Received: by 2002:a92:cd8a:0:b0:357:49f1:96a9 with SMTP id r10-20020a92cd8a000000b0035749f196a9mr20616667ilb.26.1700174620499;
        Thu, 16 Nov 2023 14:43:40 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id g12-20020a92520c000000b0035913c8423esm84399ilb.73.2023.11.16.14.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 14:43:39 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, akpm@linux-foundation.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 2/2] kmemleak: add checksum to backtrace report
Date:   Thu, 16 Nov 2023 15:43:18 -0700
Message-ID: <20231116224318.124209-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231116224318.124209-1-jim.cromie@gmail.com>
References: <20231116224318.124209-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change /sys/kernel/debug/kmemleak report format slightly, adding
"(extra info)" to the backtrace header:

from: "  backtrace:"
to:   "  backtrace (crc <cksum>):"

The <cksum> allows a user to see recurring backtraces without
detailed/careful reading of multiline stacks.  So after cycling
kmemleak-test a few times, I know some leaks are repeating.

  bash-5.2# grep backtrace /sys/kernel/debug/kmemleak | wc
     62     186    1792
  bash-5.2# grep backtrace /sys/kernel/debug/kmemleak | sort -u | wc
     37     111    1067

syzkaller parses kmemleak for "unreferenced object" only, so is
unaffected by this change.  Other github repos are moribund.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 mm/kmemleak.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 10c9b611c395..4c22a2d7cab4 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -362,7 +362,7 @@ static void print_unreferenced(struct seq_file *seq,
 	warn_or_seq_printf(seq, "  comm \"%s\", pid %d, jiffies %lu\n",
 			   object->comm, object->pid, object->jiffies);
 	hex_dump_object(seq, object);
-	warn_or_seq_printf(seq, "  backtrace:\n");
+	warn_or_seq_printf(seq, "  backtrace (crc %x):\n", object->checksum);
 
 	for (i = 0; i < nr_entries; i++) {
 		void *ptr = (void *)entries[i];
-- 
2.41.0

