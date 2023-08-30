Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2962278DF0B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238961AbjH3TjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242562AbjH3Ter (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 15:34:47 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E3C4603E;
        Wed, 30 Aug 2023 12:08:57 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-44d4cef5effso71997137.1;
        Wed, 30 Aug 2023 12:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693422458; x=1694027258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R3QMn3OzMi5xvDWjZZaqgwh4xUyJ2cGChp6VBLI0fVo=;
        b=H1g/c5XrkGK/E9+N8gm20LAINAtUUucQYEjTSSo4wqTdP4Uml8U9NulErCq+4xh09r
         nxaaEXW+ktuxjLNg8jrdLrLS6YfhBCOeIexSizLXwnSHt+mojd4vCYhirfK3dbss6E7F
         oc2uK8qd8tbBDxsM+IZC/m1mRHIvdK5RKmwPrc9puV3v90gzLqkSZ5i8mOlPoXwM0unj
         nOOJCP4Q9aASr6lvri4UX3oQCyAoP0gS+XUQXAJt06DbXGl0GO136LkPJg2QdK8Yueb0
         Hi2+4ddZfr3v0Kzg196EJzPazuEjuMogkusE2VDyQfNOlWlINiLpEpz1vo2ICHRsnQHx
         umAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693422458; x=1694027258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3QMn3OzMi5xvDWjZZaqgwh4xUyJ2cGChp6VBLI0fVo=;
        b=eNL5OPzPpYmWYyymcUqB1kij06yYeydbn3XLvgZxkNwKggB0dQBATLmue1NTM3EYUb
         IWsxQEdQGVdtqWMLWfGW3WaAVE2CSIpiOK6otWkdBdhPegw5FyIbWAyqmrSS11rVQULW
         JkO4e8rA5zZ2h5zaf/HtIm1ApyJep0bghrVLdQ6/lBGPCq2SPpFr5SBfYF+i9C9Xi9CO
         QHY2SQ/nx6yTFfWCCvJqecAk4migfuYiXW0o4Gmk7fWI8XQ/5e75tYcYG+aumpv5c8ds
         Xm3c417/JivT7/f6QocQ+DJBMMiRotjwEhEpTTlEWlPuQLB2ST46Ij5NfS+E4rDX9Bjw
         321g==
X-Gm-Message-State: AOJu0YxN0rjP658aovOdUL0goJeTiEf1/YZ9g5IP2I2X+xLMWyGc36u8
        t3gj9CvQOkzr9hINZuHZPCJ5GS/JyRvBLA==
X-Google-Smtp-Source: AGHT+IFXoI/B8H4SvdOW65eHwKS7fn9fnnKb+9GG6GfCU5+IlbLZCQzdxbln6V71KXjOG2kt3Y6mXg==
X-Received: by 2002:a05:6e02:1284:b0:345:a6c5:1ce8 with SMTP id y4-20020a056e02128400b00345a6c51ce8mr3312097ilq.14.1693421677437;
        Wed, 30 Aug 2023 11:54:37 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id r23-20020a028817000000b004310d570d6dsm3921054jai.94.2023.08.30.11.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 11:54:36 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH] m68k/atari: Replace strlcpy with strscpy
Date:   Wed, 30 Aug 2023 18:54:28 +0000
Message-ID: <20230830185428.4109426-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().

Direct replacement is safe here since return value of -errno
is used to check for truncation instead of sizeof(dest).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 arch/m68k/emu/natfeat.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/emu/natfeat.c b/arch/m68k/emu/natfeat.c
index b19dc00026d9..d124c62022c2 100644
--- a/arch/m68k/emu/natfeat.c
+++ b/arch/m68k/emu/natfeat.c
@@ -42,10 +42,10 @@ long nf_get_id(const char *feature_name)
 {
 	/* feature_name may be in vmalloc()ed memory, so make a copy */
 	char name_copy[32];
-	size_t n;
+	ssize_t n;

-	n = strlcpy(name_copy, feature_name, sizeof(name_copy));
-	if (n >= sizeof(name_copy))
+	n = strscpy(name_copy, feature_name, sizeof(name_copy));
+	if (n < 0)
 		return 0;

 	return nf_get_id_phys(virt_to_phys(name_copy));
--
2.42.0.283.g2d96d420d3-goog


