Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D2A79C3CC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242159AbjILDOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242185AbjILDN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:13:57 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B4912D56
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:51:23 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d75a77b69052e-4131d4bc82dso61525501cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694483482; x=1695088282; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QwxqNL1zXUB9OAJf/Ygs9mELpjYs6oPReuh29ZTVE2Q=;
        b=IohJ7v4yNEPN4e3HETH7rcD46OlqJZhb20ewU5YC7bgiS+SwIWAvVeyV/xWLruUlQq
         aLunqiQf/HlP3DQzPWNoVSiQAAeBvsavOWnfKbfBm6HQQdh8IRphMFFFaQCGeOTy/ECv
         reZssnY1gmfn/+pQmzizI2bgYR+zEaydG/gfxEsL8QbIpUeQiykiwVi0agD3m5pQ3yFq
         eEHSxKgC0q2/Cu3wNAxvhtkLm9Ju9H2L+oFvqh+7ermjZ51R21nhuxt2KtDDvR4PmdmC
         wDpvDAFleo+a3Z1vDaaOyY6T0L1QBv4e8kj0oRFHAH3eck39rZZ+p6kNXEo69ucBUQoE
         ZG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694483482; x=1695088282;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QwxqNL1zXUB9OAJf/Ygs9mELpjYs6oPReuh29ZTVE2Q=;
        b=fUmSr3orzTVBRpW4cIAtcA/uP1/QcdBZly6rPK/w+l08m5qWoOeDuZReKkfDOPq3kp
         YJKNhzI5DFPfGC2iT2+ga1/BG7vL5Y76p/F01SgJbXzukThUBmXSnv1H44PEIszh0maQ
         LA1KIhlH4mMdGqyaUAUAAi4J5kXlN3wPi+opJ/b5rkdRcgr4EyQJRnyBL8C2nl7NiDJ0
         q12TPHihEqRvAxjI7M1QKqK2HIneU9cLp8x0afmXAfgmDHRm2V5M2pDr9Gf9JxlmIu7n
         Nz6TcGlFmOvuxxwbTbmfcaN+yAJHcaowcjxnMpc0XGy84jEsEUARaNa2kBioYspEhE1r
         qzyQ==
X-Gm-Message-State: AOJu0YxuYMN9PkdYIkScPba7CfGMrQUJRd876CHHq3FASf2DiZMOcePv
        InBZ3Q1Bew4B8W8S4TlRwCLc/YVSRCllPrJqKQ==
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

