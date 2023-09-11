Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E37079C14F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjILArb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 20:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjILArW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 20:47:22 -0400
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD6316BD02
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 17:37:53 -0700 (PDT)
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-64bca259c4bso57805676d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 17:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694478717; x=1695083517; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QwxqNL1zXUB9OAJf/Ygs9mELpjYs6oPReuh29ZTVE2Q=;
        b=umaVmuXttX8a+fXJKY387eT9lX5axcvd8etSOiEHpzNSHHvnivDO5+GK66quCm+sLh
         1k/j1TOR9kzNQkpEhtw8AdPJFOEZ+P2SB8OWPfg8YAoRPkxa8oE5bXg3AOnyeJMHLk83
         5B/nCqMaflZrpxL05an+99W65sHKxGeyRfHbB1d4uq/+7MXxvclmnhEZel3Sncij+iGY
         JmOhZgUkolwOoOcNsfHZ2v8oT22d9Mx0pfiz+hZq1FE4hGrwNWN+fr2RI1Rh83FqBQya
         e8LMpKn37zJfoz+B4Mb4jKK5t+J6PzD/IGpNtHi60NOcNiaSY8Y7vSO2UGRzC8Ujjxuf
         bP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694478717; x=1695083517;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QwxqNL1zXUB9OAJf/Ygs9mELpjYs6oPReuh29ZTVE2Q=;
        b=PdzSXSXAi444ZRxQDTdOGyyGTIpg/dLCjg/8fhK1K+X8MHfC2Imuqq+f1N65VPJED4
         AX8vddPxYZf5IFWlwyXlUTj0N6qEwEgOWkSjdUOHfQUkmnq+EynOiVXckExq0le1Bb9i
         py+c3olwFyBxLTX98tDARyaTBPH7K++c9XaTe+8LgzZO5Z0oQM4XFhhk+mhF8HwYhVQ2
         tn0b9MrWev+/vzE+4QaCCPPLrGK26mvXxkd3f0xFaVc98f/Q3VyOxBUjnFAz8GS9LlGT
         smdC24RzC14JDKYbpED1OmWTFLE89tZDLi8sfe9mX+8YrBg2MAyMCC4N+2+MwWUU1dkr
         S8QQ==
X-Gm-Message-State: AOJu0YzlH5hPUILqHxkU3Xgfz5TEpT17fXFZBF54Q6GE1TEmJJTOiYr9
        jPoyxQ+OlxRE0vcgU+siZqJhUwHq5zgtKlZNaw==
X-Google-Smtp-Source: AGHT+IHcMR+ryqln3fSBxGzKEDejFhIMPnxZUI8UrQblXcfot9EpwsLm83Fof7MdvFLqO8WCd16dz/9x4QOU6vN4eA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:b708:0:b0:581:3939:59a2 with SMTP
 id v8-20020a81b708000000b00581393959a2mr281042ywh.3.1694466550612; Mon, 11
 Sep 2023 14:09:10 -0700 (PDT)
Date:   Mon, 11 Sep 2023 21:09:07 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPOB/2QC/x2NzQrCMBAGX6Xs2YUk/oC+inhIk6+6KEnZLaVS+
 u7GHuYwl5mVDCowunUrKWYxqaWJP3SUXrE8wZKbU3Dh6K7es01a0vjlrDJDjftPTW+OFX8KJk7 swimjj/ni3ZlaaFQMsuyT+2Pbfr6XNDh0AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694466549; l=1855;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=isAQzdD4TDo3zPe9CmPoe7IjN/uC1JjTZgMq1hRyNwE=; b=PhU1KfeKpdN/BDvmqV7i6qAIViRdCxXDRe+/LXWdXeF0pas87bxDJPMKvwHjUa7w8g1DIDeue
 gKAjrn2y7siAoBO+CzhL32W04xXDWNV/yjjqwSJhVE0GfveW0V6sWnm
X-Mailer: b4 0.12.3
Message-ID: <20230911-strncpy-drivers-block-aoe-aoenet-c-v1-1-9643d6137ff9@google.com>
Subject: [PATCH] aoe: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Xu Panda <xu.panda@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

`aoe_iflist` is expected to be NUL-terminated which is evident by its
use with string apis later on like `strspn`:
| 	p = aoe_iflist + strspn(aoe_iflist, WHITESPACE);

It also seems `aoe_iflist` does not need to be NUL-padded which means
`strscpy` [2] is a suitable replacement due to the fact that it
guarantees NUL-termination on the destination buffer while not
unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Cc: Xu Panda <xu.panda@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: This exact same patch exists [3] but seemed to die so I'm
resending. If it was actually picked-up somewhere then we can ignore
this patch.

[3]: https://lore.kernel.org/all/202212051930256039214@zte.com.cn/
---
 drivers/block/aoe/aoenet.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
index 63773a90581d..c51ea95bc2ce 100644
--- a/drivers/block/aoe/aoenet.c
+++ b/drivers/block/aoe/aoenet.c
@@ -39,8 +39,7 @@ static struct ktstate kts;
 #ifndef MODULE
 static int __init aoe_iflist_setup(char *str)
 {
-	strncpy(aoe_iflist, str, IFLISTSZ);
-	aoe_iflist[IFLISTSZ - 1] = '\0';
+	strscpy(aoe_iflist, str, IFLISTSZ);
 	return 1;
 }
 

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230911-strncpy-drivers-block-aoe-aoenet-c-024debad6105

Best regards,
--
Justin Stitt <justinstitt@google.com>

