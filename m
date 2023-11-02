Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211AD7DFA8B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377378AbjKBTA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377371AbjKBTAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:00:46 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6D0186
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:00:43 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6b496e1e53bso1292285b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698951643; x=1699556443; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uYgheZZZGyuHcjURmTvIQL5X5iZFtwQKbwUqnNega9g=;
        b=qjFYM9lcZ1qV12u5xPsrPKSU2T5hJFoA6EY2FDCP3M7W5KkfbfbUbY87KNei4L9edy
         yhkSkckjbzi7Y0wKT3VWPo9+nvZy1Up6kPGli/JVBANGdzbG9WxLluqRjjwp2g0CXyRm
         P0JgcXkBMCrqChHIRBmpmgvUD7oWOfDPWrZANKswL69EQ95st4AtEJSxwwEmJnKI8oYV
         SHvqDqSqseqjEmR/EfDHpit4xXJlIznRGuXMqIJlHpl7ker6mBPtiK9wM+7b6QIEPVxG
         YacqYZSd7sFgsPcW9uhtAFvmnkM2o3v+CTLsvATG9ayuM1vjjfSeP34cOseFNrK0N2+J
         /Cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698951643; x=1699556443;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYgheZZZGyuHcjURmTvIQL5X5iZFtwQKbwUqnNega9g=;
        b=IcJTwO7m97dzNuyl/B8Q6lQ+rMV+zgdmMzXrm0TkonVKLJBtL7h+Zr/fFnrK/xmnv8
         sf15blUV3Bf+FKQc6XskXZCWlTX9mEGo6wooqwFT5avhsskYvq7f4s+0CSs5oQbPMMMp
         /oKwSwuduhlOq/MlyCbQYbGOrWdnd+/Q1HqfnnUIzlf7MEbRyEtltVt2Xc/PG1PnW642
         qgIYVYTW7SHkETgBDB8sOphTb9TWHy6i4gEdrzZSttoW4bKv+uFcIKy57P0Nh/6Rf/w1
         W8dBqb6gKsNHLY+l6nUueu2oyVetPsVkT9zYowgwKC6x7fWyfvVXiITedkZP0P0b2OAk
         BbTQ==
X-Gm-Message-State: AOJu0YxrQqOdv+/qHvNbPMFv6T3CPDyTyEOeysxlKk5rjLwbYtDT+TrS
        dweR/wYxVTLetf7TH+5lfhNQJGS1na11TA==
X-Google-Smtp-Source: AGHT+IHFdUnaf4X55UtQE96nGIb0AAUJJMcgopess+VGd3j5Ge2chQMYt1y1X77wi6cr6e5hI0mIdLuoOrRPQA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:80d2:b0:68f:f868:a4fb with SMTP
 id ei18-20020a056a0080d200b0068ff868a4fbmr454834pfb.5.1698951642845; Thu, 02
 Nov 2023 12:00:42 -0700 (PDT)
Date:   Thu,  2 Nov 2023 18:59:07 +0000
In-Reply-To: <20231102185934.773885-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-1-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102185934.773885-7-cmllamas@google.com>
Subject: [PATCH 06/21] binder: fix comment on binder_alloc_new_buf() return value
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the comments of binder_alloc_new_buf() to reflect that the return
value of the function is now ERR_PTR(-errno) on failure.

No functional changes in this patch.

Cc: stable@vger.kernel.org
Fixes: 57ada2fb2250 ("binder: add log information for binder transaction failures")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index cd720bb5c9ce..0e8312f4b771 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -558,7 +558,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
  * is the sum of the three given sizes (each rounded up to
  * pointer-sized boundary)
  *
- * Return:	The allocated buffer or %NULL if error
+ * Return:	The allocated buffer or %ERR_PTR(-errno) if error
  */
 struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 					   size_t data_size,
-- 
2.42.0.869.gea05f2083d-goog

