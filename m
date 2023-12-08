Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3591E809704
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444159AbjLHAQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444181AbjLHAPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:15:30 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AB01735
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:15:36 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7b6f2dd5633so55749239f.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701994536; x=1702599336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YajO8saARSD8SUYuNeZ/5yudETsNrGgGryzCJfBjAjQ=;
        b=guJgvPRfSfPRQZjjyun2yT1S4QX/v1qfsggRcFDTPqeFi+Q1g7wO6a47g9yH1oMHg6
         k6dUOC4A0yRE/Y/QagpXW3kbZR8+t65RHMPkZrQRJEouTXgA/9Oj88/R81mYbyhLIVyg
         dGRgCslmKaK+LKlBK7Arv05SwF138doyj1qOcqthglk15vvyrUuC+TQZKW6ommxMl9wa
         08+hI/EAVowUd/+3IuSHNHOk+Q+CY61dyAD86ufyyuP8qlncMDa4VUVc8MDgABpoyMo8
         yvht+bWw6oIJKGV4F7PlYpfOObRfxpRqZWgjutp3vFGG6UrFeyUmvyIzzSXaNvxM0bd/
         hxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701994536; x=1702599336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YajO8saARSD8SUYuNeZ/5yudETsNrGgGryzCJfBjAjQ=;
        b=r3JJn+mVZLYWrx1GnHrGhSKZpDH5kBuMxxHL0j7X3nMTu5hEgyxiQZM/1B7vIqSS2Y
         YogyAHYuQQozonHU+oX4HGXDeB+w0FvX1pEqOyVt200aD3e2fJPUFeVApxphVBgveNab
         queckNGlpn0KvP35kkilIk7H1n3Q1SJqkiBD/6oVMb1ZoYJEQHWCrktJLEYVMpU0xiq+
         dMIiQtfoiGfQq2axCVNadoAsc/QzK27/ZPB3ZujBQtHFslELOSJFN6UPUG1gJiWnuZzJ
         xKhJ77fQAJLX9g1UFQvBldTUxYIXktTFau2tCWtvRYS6ODma6OYEkRCj5U1XdydybvTn
         aucQ==
X-Gm-Message-State: AOJu0Yy/8R97LtTyzd0Ck6tb+LNDJrY/cNbgZ5UP/wmrXnSJOJRVfKoG
        HM9OHjEnpARSuXr3/asAwFw=
X-Google-Smtp-Source: AGHT+IFFEj5vvI/IZhBjCC5Rkc9/BXlR13aPSbLUAycQolUpUk94zYgRFGHRhZotmL3WlzmNib50Mw==
X-Received: by 2002:a5d:8191:0:b0:7b4:28f8:52b with SMTP id u17-20020a5d8191000000b007b428f8052bmr3833423ion.43.1701994535788;
        Thu, 07 Dec 2023 16:15:35 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z18-20020a056638241200b004664a0a7f2csm184652jat.177.2023.12.07.16.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 16:15:35 -0800 (PST)
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
Subject: [re: PATCH v2 00/15 -  11/11] dyndbg: id the bad word in parse-flags err msg
Date:   Thu,  7 Dec 2023 17:15:14 -0700
Message-ID: <66fa2e4cb98993032f58845218e0d527ef9398f0.1701993656.git.jim.cromie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701993656.git.jim.cromie@gmail.com>
References: <CAK8ByeK8dGcbxfXghw6=LrhSWLmO0a4XuB8C0nsUc812aoU0Pw@mail.gmail.com> <cover.1701993656.git.jim.cromie@gmail.com>
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

if ddebug_parse_flags() rejects user input, identify that input value
in the error message.
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index b63429462d69..f4b1d3ef837d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -937,7 +937,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 
 	/* check flags 1st (last arg) so query is pairs of spec,val */
 	if (ddebug_parse_flags(words[nwords-1], &modifiers)) {
-		pr_err("flags parse failed\n");
+		pr_err("flags parse failed on word-%d: %s\n", nwords-1, words[nwords-1]);
 		return -EINVAL;
 	}
 
-- 
2.43.0

