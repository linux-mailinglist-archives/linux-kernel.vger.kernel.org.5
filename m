Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4A878A1C5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 23:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjH0VOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 17:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjH0VOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 17:14:24 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0670C1;
        Sun, 27 Aug 2023 14:14:22 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31dcd553fecso26640f8f.2;
        Sun, 27 Aug 2023 14:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693170861; x=1693775661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEuyiUjnDtOu7dR9owxX9v0FKvTrdzN40pWJ8696GMc=;
        b=oohInnsxCA//EmDY4Q8ZPTK0VhvvjdIvV6IkYcGqDOoew27+6NTeBU8GYOcil2YlQ9
         SvtXAQdls66MdBIpUuB8U61iC5tiUhs0CPingXS/d6i6QBFF6i1s9gjyfr3LkVbKlYKW
         nhM4cKYWvg4HHC6cB9oBOtTKrBZTgzbporwBLFHaksRLy0s+V3QXiWnqlyCfqRzAKoby
         sN5sDg8/24+6lmazKf4cGsjK9OxkWimyd130RTYM5iMt2tsLldP1DcCDqOszw0YyLyxm
         YFfNrl8cY/wndxzh1ozGjZKwW/eWNca82NN5nxT+eybugaCoogng7y24SjMfnRgMJM+M
         VBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693170861; x=1693775661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEuyiUjnDtOu7dR9owxX9v0FKvTrdzN40pWJ8696GMc=;
        b=GOM101jzyIcFbiDVCpCk3foCCLeMBQtj6ax2gy6XPGWHQapQFQauiR1W1OdpG9yZTo
         82Ar0LHZomtJBFsK/eQXGiSOlMgh2boRRD3jqp69SdxOVLVh71+sYQJ6P2TMj1i7lXM7
         Rw4RF/BIGPTqF7GeY90gdmO/J2W69beQ1utszR13L0Nw5FLHSM2OuxiJhApdNpNE783b
         FkVg5cgueoJkEGwy30FNsa1lEn1sZRj93t/Hqz08VSqnG2GW/K3pxEhnnkE/QfVtmzlB
         a5AnvlFoi5QMjDja2WWBHCipF8qGpbmUs73YnBLGKglEWRf5JyWh+KYmBypU50ODVng3
         i9bw==
X-Gm-Message-State: AOJu0YwqAQ89VHsYafJX4BqfPsmpyNGFudtnfrPoSZZi8MIPgfd5m0CG
        BDlAKwxEvGGYFVm7dOvPn0c=
X-Google-Smtp-Source: AGHT+IHErb8yMhcoLxajYmBWfymwcWBdwCcCG9vfP0RSequX4LujqIwhvWl4Vl15Gn8nsa+vI2QFGw==
X-Received: by 2002:adf:e4ce:0:b0:31c:6697:6947 with SMTP id v14-20020adfe4ce000000b0031c66976947mr10998390wrm.69.1693170861114;
        Sun, 27 Aug 2023 14:14:21 -0700 (PDT)
Received: from xws.fritz.box ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d638e000000b0031971ab70c9sm8541997wru.73.2023.08.27.14.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 14:14:20 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Johan Hovold <johan@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/3] lib/ucs2_string: Add UCS-2 strscpy function
Date:   Sun, 27 Aug 2023 23:14:04 +0200
Message-ID: <20230827211408.689076-2-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230827211408.689076-1-luzmaximilian@gmail.com>
References: <20230827211408.689076-1-luzmaximilian@gmail.com>
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

Add a ucs2_strscpy() function for UCS-2 strings. The behavior is
equivalent to the standard strscpy() function, just for 16-bit character
UCS-2 strings.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
---

Changes in v6:
- Add function documentation
- Clarify that we're copying/working in terms of characters, not bytes
- Change size warning to be INT_MAX bytes, not INT_MAX characters

Changes in v5:
 - Add ucs2_strscpy() instead of ucs2_strlcpy()

Patch introduced in v4.
---
 include/linux/ucs2_string.h |  1 +
 lib/ucs2_string.c           | 52 +++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/linux/ucs2_string.h b/include/linux/ucs2_string.h
index cf3ada3e820e..c499ae809c7d 100644
--- a/include/linux/ucs2_string.h
+++ b/include/linux/ucs2_string.h
@@ -10,6 +10,7 @@ typedef u16 ucs2_char_t;
 unsigned long ucs2_strnlen(const ucs2_char_t *s, size_t maxlength);
 unsigned long ucs2_strlen(const ucs2_char_t *s);
 unsigned long ucs2_strsize(const ucs2_char_t *data, unsigned long maxlength);
+ssize_t ucs2_strscpy(ucs2_char_t *dst, const ucs2_char_t *src, size_t count);
 int ucs2_strncmp(const ucs2_char_t *a, const ucs2_char_t *b, size_t len);
 
 unsigned long ucs2_utf8size(const ucs2_char_t *src);
diff --git a/lib/ucs2_string.c b/lib/ucs2_string.c
index 0a559a42359b..9308bcfb2ad5 100644
--- a/lib/ucs2_string.c
+++ b/lib/ucs2_string.c
@@ -32,6 +32,58 @@ ucs2_strsize(const ucs2_char_t *data, unsigned long maxlength)
 }
 EXPORT_SYMBOL(ucs2_strsize);
 
+/**
+ * ucs2_strscpy() - Copy a UCS2 string into a sized buffer.
+ *
+ * @dst: Pointer to the destination buffer where to copy the string to.
+ * @src: Pointer to the source buffer where to copy the string from.
+ * @count: Size of the destination buffer, in UCS2 (16-bit) characters.
+ *
+ * Like strscpy(), only for UCS2 strings.
+ *
+ * Copy the source string @src, or as much of it as fits, into the destination
+ * buffer @dst. The behavior is undefined if the string buffers overlap. The
+ * destination buffer @dst is always NUL-terminated, unless it's zero-sized.
+ *
+ * Return: The number of characters copied into @dst (excluding the trailing
+ * %NUL terminator) or -E2BIG if @count is 0 or @src was truncated due to the
+ * destination buffer being too small.
+ */
+ssize_t ucs2_strscpy(ucs2_char_t *dst, const ucs2_char_t *src, size_t count)
+{
+	long res;
+
+	/*
+	 * Ensure that we have a valid amount of space. We need to store at
+	 * least one NUL-character.
+	 */
+	if (count == 0 || WARN_ON_ONCE(count > INT_MAX / sizeof(*dst)))
+		return -E2BIG;
+
+	/*
+	 * Copy at most 'count' characters, return early if we find a
+	 * NUL-terminator.
+	 */
+	for (res = 0; res < count; res++) {
+		ucs2_char_t c;
+
+		c = src[res];
+		dst[res] = c;
+
+		if (!c)
+			return res;
+	}
+
+	/*
+	 * The loop above terminated without finding a NUL-terminator,
+	 * exceeding the 'count': Enforce proper NUL-termination and return
+	 * error.
+	 */
+	dst[count - 1] = 0;
+	return -E2BIG;
+}
+EXPORT_SYMBOL(ucs2_strscpy);
+
 int
 ucs2_strncmp(const ucs2_char_t *a, const ucs2_char_t *b, size_t len)
 {
-- 
2.42.0

