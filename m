Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3AF7AB886
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjIVRyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbjIVRxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:53:53 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CE2E61
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:52:02 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c453379020so21101015ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405122; x=1696009922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RWuKWOMrUoMzQOCKPflMbS6ITer2hgabTUg3ReQt9No=;
        b=CQcsYKffp4HrOBiIYLoQNbFd3ft+zzFGwKKnovcP+rTEpmiYh8Rb1xRbn4cHkE2+kW
         nrQ95I1NRrGhJSNKwxdYuCx+/R/sNZh6jvV0Bt7xedXgwJwCy9gzrvulIKFwlksZEpDe
         aNJ9jHv6YnOnGJK+c3ABuieE7le64IDA3zfJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405122; x=1696009922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RWuKWOMrUoMzQOCKPflMbS6ITer2hgabTUg3ReQt9No=;
        b=fZ4QjAZMOpePwNfH53Rt2C36d5iJxBsWgIDLJAo+6FtQbDQ585sYgC3Kvzvmygij3O
         4iPGTPU5k8Et4p7Pq09jfCB0G9qoT9tAcQpadThggVWkahuXk49cF1KQXQgU9QkrNS2Y
         C5SMw0o6Cefwy/fvMnFzdyQyDUO/liIHcFqQjPqG86EkjNQww/xeSWWVmvm5oBqTF4cP
         njWCk4VtelIx3/vPod1ZzvWxJ1jD4rpmvU/Z+Txaz6lC6BAwYiE0MPFVqlj7nuZTq75U
         mAEOJhW9+2YgyPmMqbeRkTC9XYrNVUI0uoFCp5rK8TuIDzSx0Qq6Y/cPp/89h7i5TLGY
         ikgQ==
X-Gm-Message-State: AOJu0YwjtkNT8jZlv6xa0h6x7ozJpdPBxkCkumflK3FRyJFLkIVQvvRc
        O+UkAFtfpjZw8EHUyYarNNwD+g==
X-Google-Smtp-Source: AGHT+IEEYqGk+GvFAAFqlU+6AHitWBEIi3aarNhM7dp2OV5ey+MRAhoWBJPSVmg4F4cknSaQafnbmA==
X-Received: by 2002:a17:902:7449:b0:1bd:d141:f02d with SMTP id e9-20020a170902744900b001bdd141f02dmr149532plt.68.1695405121759;
        Fri, 22 Sep 2023 10:52:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902f7cb00b001bf2dcfe352sm3765524plw.234.2023.09.22.10.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:52:01 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Kees Cook <keescook@chromium.org>, sparclinux@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] sparc: Annotate struct cpuinfo_tree with __counted_by
Date:   Fri, 22 Sep 2023 10:52:00 -0700
Message-Id: <20230922175159.work.357-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1141; i=keescook@chromium.org;
 h=from:subject:message-id; bh=n9z5FmRNgXALjcjtTQwP0uj0mQ0tiOVTP5YW9P7FSeE=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdRANuxw/YOVkfMe7fQoYeuhYtypfWJE9rimR
 0W611Y2NtaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UQAAKCRCJcvTf3G3A
 JvZfEACAwkw3Hbs4govxC3WH2lH4Hlpz7sGJadYiUoHt+PpNm1GGCy0X2+FNwHI0OvGsu9RRnW5
 H77B+r/0dOLQy/7GkbzM71I5kXTTFiqUZQHDQhHHLefLxR/GjWfuvRNSjlzzAwWeritamzNkyyG
 2sdXgT4uvBxosTfIDag0gWNP3IBDh09NIcjHzu+6Xfmkbc+aL+LPFixecuNOXi3K/GDnL7w5iKs
 RLmHm8t9Ur1Q36dEIiG8mEJcb1lzjJcv+c6vJKDy5y1yCo4Blhl4eF8gdv85j4DbzYDgVVTTWR+
 504vVs9PwUPQe+iNm7jTefR4LBq7wY9RFg5p5URg0LrGQcth+pgkgF/pkolKbjorxKOgfU+Xbc0
 QHT0O6eCUce78B9Owa/I7lfPPginZXq+T3ZyVdbsEwMEoE0FMX3j3eokoiCmVdTtPspH0qxP4Yu
 mrfqBcFSb2TKL7W53hxYUQLOu2/YQs9fY6YKKSrk+soHZD3RtJnhNyfWN1ThpQsZK033DO89J33
 jgTZd1Mni09sKB4DZIr5s5a8Ughcn20T1kEtDI+iM6E5ih0ViruyRUWmYME5ZWuwJ4jHHsaQC+9
 vq3QlCxhToa/GF2Tv1tc7yvQFuCHpBmU7ztDcVockhlYwa1vlLWAVr0KA6FPi0Yuv+hOq0tBOnN
 ig4Tr54 MXlUMSWw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct cpuinfo_tree.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/sparc/kernel/cpumap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/cpumap.c b/arch/sparc/kernel/cpumap.c
index f07ea88a83af..8fcf2d8c6bd2 100644
--- a/arch/sparc/kernel/cpumap.c
+++ b/arch/sparc/kernel/cpumap.c
@@ -50,7 +50,7 @@ struct cpuinfo_tree {
 
 	/* Offsets into nodes[] for each level of the tree */
 	struct cpuinfo_level level[CPUINFO_LVL_MAX];
-	struct cpuinfo_node  nodes[];
+	struct cpuinfo_node  nodes[] __counted_by(total_nodes);
 };
 
 
-- 
2.34.1

