Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892707ADDC3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 19:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjIYRUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 13:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYRUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:20:52 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F109107
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:20:46 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c5bbb205e3so62783005ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695662446; x=1696267246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kPLbH/Tf+wdfFPVL445Q4TNBVYOrnwBXbZL8JKEtuvw=;
        b=iu+sNNU2PCMSdc4vDSJEV2lj2fW8yaSajEyyasj4YQhtXfTprLeHrZcg8Lw2mypyJ8
         kVyEspUVRx45v13jeTtRS9/p1wUN/TuB0aTukwJcFKSvPJ+SOxeEDK3gdN6DnQZm2sxB
         nm0jWge5ktkN6/shuGjvoxbWv/q8hUBQ7q3Ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695662446; x=1696267246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPLbH/Tf+wdfFPVL445Q4TNBVYOrnwBXbZL8JKEtuvw=;
        b=wYtPKRXw3F3efNE3rzuSAWTozvtiKWh62Ls7I8LxuuGeExZiSqtTO/JX7nLUeoq7kU
         ZwY67fQaLCMlqVYwE+kHb2MRkuJinQSRqUab2u+P5SJfcDDHq6kiaAYSfqiV3IT9YBbh
         kgfSQ+/L9400gCbql4u3xyMeE0kiUYkdFwi74l4y5esFpZe6xvkLUDaoVJ5BNBPCV1ck
         BPL9t7IHnArbLDYFYJodnvTaEHNwgYL26GQAN00GkfsQe7NHJ3NS20YfTkVwgHsmTi2G
         h3yxBtNAqljTEhc3YryCjU3YfcoxDWv3AyvQZjxfebgdFei+W/Ctj+xxD+XJ7dbAIVJ0
         oMfQ==
X-Gm-Message-State: AOJu0YxHSV7wmDJ0FkoqXnkZkmmSt8T9H24UB0kl8p7ejG5B+a44nuhb
        FnEBpAqkOyAmJdUO7Ekx9Aw8OQ==
X-Google-Smtp-Source: AGHT+IH/2iId8tq9z0S+QgPxRRa+XsbO8n2kJks60ziSQmgdUQFCwvKzoBFQaNPGDPAy1E/11VievQ==
X-Received: by 2002:a17:902:ab1a:b0:1b6:6f12:502e with SMTP id ik26-20020a170902ab1a00b001b66f12502emr7369227plb.49.1695662446062;
        Mon, 25 Sep 2023 10:20:46 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902b28500b001c62b9a51a4sm202654plr.239.2023.09.25.10.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 10:20:45 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] MAINTAINERS: hardening: Add __counted_by regex
Date:   Mon, 25 Sep 2023 10:20:41 -0700
Message-Id: <20230925172037.work.853-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=680; i=keescook@chromium.org;
 h=from:subject:message-id; bh=rAmWngsH0Gjx5R0B8Ys0oawcRtQO9WskXs2KSeiUA0Q=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlEcFpTbJw89m25nOYSCFD8DEggHluPsQVN8XIj
 Dd0XtZOxYaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRHBaQAKCRCJcvTf3G3A
 JliCD/wOfGWDGI4gYxLuP8jKyzmW7RXSI+PJQ5RlwWdPQlrIl+Us8l+/HAoEMqpJ1Ax5Mr3h0+x
 NpwgnoB1lpv8enkEOTwaZ4CFp8evfv3MwpQhCKJkXKBCix69B+PvOAb2msqVAvT//xFUIUha5go
 /YuGCwJ9gEMBzY1aJf0AHMZCZi8FhcjxnSy4Wi+SF6l6L4AXqvyW5UwQFJ2bqnUt/i87GeQ7OUu
 PQ8R7a+yyVGFxJE7W8pZYFNaslP4M7/wpxCBgnR8eLry38r7xYswvFxxK+6IRF0vyG6Oj0Lqy3P
 Ri2YDmzYXl7+uFLDOmCvVCcpQj2gzlHlwVvhj+q1mo2C0h+QC/wXVj3C+I/ESWFaUXvV9Vw+h/X
 S9ACAHO6c1vswtu6XHKGj0EQDeb7oUvwh2c2QCo0CB82c/7KxqJ2YhX6ZACogah01ILQfBuxCH+
 lCTidggRtPjrcqzAP2n/UYOhRslJgcZWUav64Vj+KcPtg1ub2UBHURQOrjuvpjQC+iCtr61jOjy
 RkzDM9adZPgS51Tg0EVtDIL4BewxrrgohkdaPd0vFKwlVi/uW9EJ7hP9v0ZA4mcGLPzjBhviR8Q
 mSrf0DiCHqEFZoNdIyT0gZZAYVnYJfw/xUHv1XTozZ3UfMrzQQamRvLsAUMZnX87iXmQIxcMgUR
 hk5tj/uB DMwrDKw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since __counted_by annotations may also require that code be changed to
get initialization ordering correct, let's get an extra group of eyes on
code that is working on these annotations.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 737dcc7a2155..741285b8246e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11405,6 +11405,7 @@ F:	kernel/configs/hardening.config
 F:	mm/usercopy.c
 K:	\b(add|choose)_random_kstack_offset\b
 K:	\b__check_(object_size|heap_object)\b
+K:	\b__counted_by\b
 
 KERNEL JANITORS
 L:	kernel-janitors@vger.kernel.org
-- 
2.34.1

