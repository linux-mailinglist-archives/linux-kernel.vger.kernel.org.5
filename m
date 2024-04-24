Return-Path: <linux-kernel+bounces-157040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A99058B0BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200271F28B89
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5BE15ECEB;
	Wed, 24 Apr 2024 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IcMlWtTp"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119C015E209
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967559; cv=none; b=IAjOyo3gjqRql8GUfN1HlTQV0mDuFxImBI2eod9fA/zyBshM5Qu6LlwBAcgmHA1xZvv7rK92cg6R/7LM3TxW+z2R5BXZ5HFeVehVk7n4zJvKFdgx4ZJQPTUyY0gstmZ1r3iwLdW/Xm7yo1s/QBGfkdly+6gwAMiRo9h7jx1c54g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967559; c=relaxed/simple;
	bh=wti5kj6bWe28mBREcjkcFgjgGXuk8vkEPAf7amsQIJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AoNRTzdMZA9HMPO/y5ajB+bSX9wmdDHHNjfPTWP2uAtII9s3N+7+gzRp9+B85dN6NSbKVIdwpqu1n3ta/uXOcbmY1K/6HfwCqR5bS6CZfKSfM1eBzEHhKr2xi3G1jXtBSE7iQObK4xGP969hoyRW9RacWGU897xXL/+KROlJqac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IcMlWtTp; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41b21ed19f5so2119135e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713967553; x=1714572353; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CiQSgCwG9Fjd2pIkvI/eNn2TXAIZ8kV9PyuFCdDbFAA=;
        b=IcMlWtTpKNdt7yNtjhY9H/vg/0adY31kwIUKmZvtvLiuCbxMkFr4eRGr5+zShWspq5
         EGm22IODuDxXRWfeU/Bsh5vvjMgQsMl7KO7AYo0YYZI3LGCtp/L4Nhxks4RreQIXoWT3
         6qp47XX5Q9zbim1KyL6jTZc9lBQo7QFWBRSxdzFTh5MVX7TPOeN0C2D/QkS3Lqew+63+
         a1TUOhqUketsJh47MSqgi3hQtbp7mSIpsE2Lgn5cwvKSLhtkxD9DjqThLCl+CP6gZD96
         Nuqwzt2JikgJP3TU6APs6ASpPiw5gr1BlFrCi/qnRaRc+Z16sg1TXyPRPkv+MbFfsAdb
         aZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713967553; x=1714572353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CiQSgCwG9Fjd2pIkvI/eNn2TXAIZ8kV9PyuFCdDbFAA=;
        b=UCni7oIPP1qiDxCXAMcoQHanHX7CpBoeuzYteYEc0+Qx792tjEOk05cBo98CPnh7FN
         /VdVV1Nyfye6TLTpgKPtnIWjaLkPidUwvNOBOBZPH9KWPTl6ds1MYgIhY/nfxvDhno00
         6rUOSH2Ix5vixkDSMKmGbqIZFlgluW/CBEHchqjOTjN1EsLdzixv+caQNgcr5iXcH2a3
         AKKaQ8b8PA5qyMKz+G8xfqni5WBw/x1YOYPVGvZWVTLN+Y9o/JrXCULnNxWRTcRuNKSt
         RP4u0xOURsSh76NI7+V7huk8/QqT1F1CH/cnVWvT0W9n+egeg3AIImYgm9KBWPGS+oJ9
         whcw==
X-Forwarded-Encrypted: i=1; AJvYcCXv+V1FbozuWVTmXEutFUkg46LBB6/8LzDi2TIGQocNh4ZqMhoGdgw84nbbqNKbhkPaY2wOXnrfvhAnFYP+ePXCB2X2GqRqNmkT3LmV
X-Gm-Message-State: AOJu0Yy4NSIJaCffCQnqOD14qHcSF33M68GCtirFbLkhdYwIkw/73/72
	i6tLXaaka3OlCkVv3k8f5sVX4iInCghPwi6qeJrYRPaRNRuK+hcjU3KZ3IkVJSQDejf1Hb115FR
	cl6s=
X-Google-Smtp-Source: AGHT+IGqG2RVeoMAdeMDYTn9tNZggqfDQ+qae44PwKczUO0hg8teOGcUdrRa+KCXGTu719wfKa2arQ==
X-Received: by 2002:a5d:5449:0:b0:34a:a836:b940 with SMTP id w9-20020a5d5449000000b0034aa836b940mr1496105wrv.18.1713967553671;
        Wed, 24 Apr 2024 07:05:53 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d48c8000000b0034af40b2efdsm9105325wrs.108.2024.04.24.07.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:05:52 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Wed, 24 Apr 2024 15:03:36 +0100
Subject: [PATCH v3 3/7] kdb: Fix console handling when editing and
 tab-completing commands
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-kgdb_read_refactor-v3-3-f236dbe9828d@linaro.org>
References: <20240424-kgdb_read_refactor-v3-0-f236dbe9828d@linaro.org>
In-Reply-To: <20240424-kgdb_read_refactor-v3-0-f236dbe9828d@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Daniel Thompson <daniel.thompson@linaro.org>, stable@vger.kernel.org, 
 Justin Stitt <justinstitt@google.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1858;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=wti5kj6bWe28mBREcjkcFgjgGXuk8vkEPAf7amsQIJY=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmKRF5rcqN5Dgc+qstFjiPAW9G3hYBgyjtuKx/O
 swzPOkiGi2JAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZikReQAKCRB84yVdOfeI
 oZjqD/43oGbEO2TFmRq3wSCHWMsq9Im7d0XzuP6Xg6OkzQSMPMsg/HnNUiCk/wDXM00xOeKEbii
 4cU4AETV3oDjp6xBzEveKXrybeWohUWm5Xw4A7NBghLtRIxQZiqPo1K5ZFYwEx9wJ0H5bV9i8V+
 5+40DrU28YsTTricP5jKJzKqTQX+JRuurE8td8GTROh/0HElI0ivzakG7tSJJd5yzM+FFiTJTin
 sVuW+imTw06DPAVR5SlUiBPtWOQ/maUdfNmCf1HDz9iqG35YH58o4ld3cn/4WiC4GAEfEQQZKn6
 uLMK5tZGYB7/AjkgsKuxbpGhUCzv9U2toh+zg9Uk5RcJnDDm/GXuYPOFZiEpVErNH+2JFt8CBJm
 n8l8XydEaaFvPUgXY6/wJZ1R5R4FqOsosP9RRdIZK7g8SGek6RUebPV7T+RE7FA3n7uEbdQwctI
 7K91q6CqDsJaGD1PeCm/vCiLKC9mNv66KCVzCK0FDtUfjLP8zLTGYuYbCoKbqY/BRYY376R17Vz
 SYuypvrzNgSz0GVneF5COWavX9vMDvfIaDaYcjiALtgCIIHM4NKgDSzBZsX52dflKFeUzDBPWy1
 5sb1DLSBpau+aa0r7C0Mb+MBz/JAMUMyVK4PXUP9PAfDSgAD6nHQEfoQbizf/PhzwHm+nkgTsJ5
 fAV1buYnpy4dfLw==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

Currently, if the cursor position is not at the end of the command buffer
and the user uses the Tab-complete functions, then the console does not
leave the cursor in the correct position.

For example consider the following buffer with the cursor positioned
at the ^:

md kdb_pro 10
          ^

Pressing tab should result in:

md kdb_prompt_str 10
                 ^

However this does not happen. Instead the cursor is placed at the end
(after then 10) and further cursor movement redraws incorrectly. The
same problem exists when we double-Tab but in a different part of the
code.

Fix this by sending a carriage return and then redisplaying the text to
the left of the cursor.

Cc: stable@vger.kernel.org
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 50789c99b3ba8..5fccb46f399e5 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -383,6 +383,8 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			kdb_printf("\n");
 			kdb_printf(kdb_prompt_str);
 			kdb_printf("%s", buffer);
+			if (cp != lastchar)
+				kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		} else if (tab != 2 && count > 0) {
 			/* How many new characters do we want from tmpbuffer? */
 			len_tmp = strlen(p_tmp) - len;
@@ -396,6 +398,9 @@ static char *kdb_read(char *buffer, size_t bufsize)
 				kdb_printf("%s", cp);
 				cp += len_tmp;
 				lastchar += len_tmp;
+				if (cp != lastchar)
+					kdb_position_cursor(kdb_prompt_str,
+							    buffer, cp);
 			}
 		}
 		kdb_nextline = 1; /* reset output line number */

-- 
2.43.0


