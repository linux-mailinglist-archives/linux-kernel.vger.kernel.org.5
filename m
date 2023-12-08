Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704EA809701
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444238AbjLHAPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444171AbjLHAP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:15:29 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEDF172C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:15:35 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7b0683ff3c8so56367239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701994534; x=1702599334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ssjGxrGLnCtNpGMpTx9cbNQALFXepV0ad8kHMP7VW4=;
        b=NSV6e/FLnzwDrUG4dmprR0tTD6qCD4mp6/GXOd0dQWCoi+S+ir+B9Q8qK3IJK7PW9N
         2dzvknotSxlDCTyK3g9K4paykA1om2CGNBPF/ia8Dr9A0jtsSHttC0oqbUVnYJ3cbUjI
         RFBHQ4ztTu+v4nV36ZF/GWGSdZCNtTP3eNKRAiJ0msdD9pRoQoMVSFz/9Kz78UWCPkTo
         6hbPWZEKiSTea4f//0ODHC7sjwPYw8QLNnZlsXPaUZTYLcnqqQPy3iq4W+ZXSwnvDxWX
         d0VEJqSvcJM3WVAgj1HuEWU542TOnLrBjiqW+WjxBq8+Uvasi/7bNFhunvSN8PvgYRdG
         jcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701994534; x=1702599334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ssjGxrGLnCtNpGMpTx9cbNQALFXepV0ad8kHMP7VW4=;
        b=WHaj7LsE1/rZWZicAza/t8Qh9jMIDP5s8gKtwKEAKlAm4XdvLlH99E0uX/8U0+wL/o
         uQN4XziHtDpASZ0b0MFJlBzhO1fKepxu/54VY73FI94o+oI21UK2xEgRz2cmKycA4mnh
         LQ2hw8DcfOO2SY2WsKAqT4CRhKuSzEY03TubYOX64DyRJSfVr+8cLBOcgOFne6uN7SHW
         cykiSd4zKVnv3IZAt2YErPUruCif07i2tti3Gx941gwsVmCqTlqkHicDNNCuYB1q6QcQ
         CUBOFJqoQwIESW8yWPoL5L0M/FrNnje3hXKtmupNR7OW54JeTkng0deJKWPuVbBQwQ74
         z9lA==
X-Gm-Message-State: AOJu0YzBQhSFbWn4hsaLX2GyexcXI6sZ8fk9BmuksqiqTzggZ8U4ZNnG
        7ulheSJDgOtXMkW4atx5XGA=
X-Google-Smtp-Source: AGHT+IHx2yzYUZdi+ierGHFHR+bR+0mfs96wbv8gEI4LEHmSyEeo4q5ZxOvXR+9crTbrFfZPcZNN+g==
X-Received: by 2002:a6b:e905:0:b0:7b6:fa80:c784 with SMTP id u5-20020a6be905000000b007b6fa80c784mr1808375iof.33.1701994534722;
        Thu, 07 Dec 2023 16:15:34 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z18-20020a056638241200b004664a0a7f2csm184652jat.177.2023.12.07.16.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 16:15:34 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     lb@semihalf.com, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, bleung@google.com, contact@emersion.fr,
        daniel@ffwll.ch, dianders@chromium.org, groeck@google.com,
        jbaron@akamai.com, jim.cromie@gmail.com, john.ogness@linutronix.de,
        keescook@chromium.org, pmladek@suse.com, ppaalanen@gmail.com,
        rostedt@goodmis.org, seanpaul@chromium.org,
        sergey.senozhatsky@gmail.com, upstream@semihalf.com,
        vincent.whitchurch@axis.com, yanivt@google.com,
        gregkh@linuxfoundation.org
Subject: [re: PATCH v2 00/15 -  10/11] dyndbg: move lock,unlock into ddebug_change, drop goto
Date:   Thu,  7 Dec 2023 17:15:13 -0700
Message-ID: <a9030af05886f375beed5f4d75074004fffd896f.1701993656.git.jim.cromie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701993656.git.jim.cromie@gmail.com>
References: <CAK8ByeK8dGcbxfXghw6=LrhSWLmO0a4XuB8C0nsUc812aoU0Pw@mail.gmail.com> <cover.1701993656.git.jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index fc903e90ea0d..b63429462d69 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -537,6 +537,8 @@ static int ddebug_change(const struct ddebug_query *query,
 	struct ddebug_class_map *map = NULL;
 	int __outvar valid_class;
 
+	mutex_lock(&ddebug_lock);
+
 	/* search for matching ddebugs */
 	list_for_each_entry(dt, &ddebug_tables, link) {
 
@@ -625,6 +627,7 @@ static int ddebug_change(const struct ddebug_query *query,
 	if (nfound)
 		update_tr_default_dst(modifiers);
 
+	mutex_unlock(&ddebug_lock);
 	return nfound;
 }
 
@@ -932,23 +935,17 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 
-	mutex_lock(&ddebug_lock);
-
 	/* check flags 1st (last arg) so query is pairs of spec,val */
 	if (ddebug_parse_flags(words[nwords-1], &modifiers)) {
 		pr_err("flags parse failed\n");
-		goto err;
+		return -EINVAL;
 	}
 
 	/* actually go and implement the change */
 	nfound = ddebug_change(&query, &modifiers);
 
-	mutex_unlock(&ddebug_lock);
 	vpr_info_dq(&query, nfound ? "applied" : "no-match");
 	return nfound;
-err:
-	mutex_unlock(&ddebug_lock);
-	return -EINVAL;
 }
 
 /* handle multiple queries in query string, continue on error, return
-- 
2.43.0

