Return-Path: <linux-kernel+bounces-153714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C088AD201
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45D3C1C20C8A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62687153BC9;
	Mon, 22 Apr 2024 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eACLT0Gq"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A24153816
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713803875; cv=none; b=QKFrwqsSCfzAABFmbnkRQxA2T0qmqRUi9hPwfyayorg/Up+zwWD3fPe1B5K/U5M1BWssygZh7nszORtSRa4yuQL10fNLDqt3MPTIEghVoF6XdZNK7OaXUmPLlbj9YK/TWQk8UeUbxdm56nfUgTP/rgYpmpNp1dptcsSbqPOq0xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713803875; c=relaxed/simple;
	bh=/6p73t1vQBs60bTu8b+1GCgEu36ZH+1LONSsLqShnFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kX6bBG7RcyR7kK2VthLpJt0lOfA8RY2EpyjQ3SgURH4B48+ZH4qQwBJpUuhMjX6TKIG2d1MN2yQAB/EhmQWv18Fcqf+SON2+LTiEp3wPxQhvy6Iyrmk4STLyES9NTktrvGmszQ71IeSTk1Vz3Qz+Jf8PA5h90PxHZQ6lv9g5UE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eACLT0Gq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41a74e60753so7239455e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713803872; x=1714408672; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0169n4vHsrlup9ubNFunAJmhMk888VjX3f7O4lXGgA=;
        b=eACLT0GqEfloYeH+etkMKy3F97+zbiGVwLmlzyV27saPTlv1e2LWNxH/vVpizkqkeL
         uuDudZiOsXuW2cnap6No9ChALceyjyr4p2xS7Un7nCgn0TAWmX9UynXwP8w5WaiM7paF
         lrjl6cohCIJqQhBXH674ESVtCE841L1ikuQ0okxCm1sXwOJju0q+SNvNqT8ghxtV19W7
         8evXdP2Je6v/4qjyWs97ytHUBsmQoVzUGDoZBQeCv/Mc4Oha7tcxM8HMvnwNc3R5bJfl
         w/lYHMLCVjXkPqJwlAprPFBnVLegbFrTyL9N2URDD2Hl4wNlqYYB0/983vm8nugPhpUq
         cwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713803872; x=1714408672;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0169n4vHsrlup9ubNFunAJmhMk888VjX3f7O4lXGgA=;
        b=vqCd0/99Uqvj/S5TrU4pJeU8lBZ3AkLBLXYaDdArABhcOazh8sx132cwy7w1SSwyfH
         TFs26XVievilqYqEn8o0paO6DVpyihrdH3PtNYj314LvWRUhwW0Z6r5qY/h3Vy3neV/w
         7Jnrbq6begnEFb5Z2UV7voMq/lbBlRY7E7A+UbZwm3iVXXAZ7yy3UvytRtNq8tJa/ZqY
         uQCXnUS9dIlqfxc2P08NDRZtzRn7m9JxWr/d4Jv77/SW4XoA1tiVI43QATiWZcl9M4MP
         T0W2knP9WDLyMHcob5F8z+H14hdGbaCMBgczbl/hLCJobxFm6n9Re+tclAWMea2SjGMo
         mRMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaVibFkNCQGfIbR7uIfOJf+fE9Nf5Nm6VgShxXQ/+wKn3N6XbECz2meqg8O/cy0gURcT8wFIvhsCYuZ9h0QUHYP5bncriYFU+xc3Tw
X-Gm-Message-State: AOJu0YzjTj4KCwm4vZx6p2c6o/oapvPOqMm7iHlMROPUShk7uhNEoUVx
	5Wbbu4OnF6d/pgtDgSz5LZHlFO13Dr8MGJZLXxvL87o8YoRr5e9VEd76nvLTuWU=
X-Google-Smtp-Source: AGHT+IFDAAvb8ETo8De2eJqNKoycsShByig8HHkfyzUlmRRzC/jqyTN43Wz55FLnwpcwrQEy/c1YjQ==
X-Received: by 2002:a05:600c:3acc:b0:41a:5735:66c8 with SMTP id d12-20020a05600c3acc00b0041a573566c8mr2041049wms.24.1713803872432;
        Mon, 22 Apr 2024 09:37:52 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id jp13-20020a05600c558d00b0041a9a6a2bebsm433343wmb.1.2024.04.22.09.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:37:52 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Mon, 22 Apr 2024 17:35:55 +0100
Subject: [PATCH v2 2/7] kdb: Use format-strings rather than '\0' injection
 in kdb_read()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-kgdb_read_refactor-v2-2-ed51f7d145fe@linaro.org>
References: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org>
In-Reply-To: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Daniel Thompson <daniel.thompson@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2732;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=/6p73t1vQBs60bTu8b+1GCgEu36ZH+1LONSsLqShnFQ=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmJpIIW3xYkh3ftEnJ/RSyvRs2J+mRuC9iAg4cv
 Zv/heHfsbCJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZiaSCAAKCRB84yVdOfeI
 oVAsD/9HzAXKmRkN+CwWlgwz8ifB4D9EiWAg0lomCVFYfz20jy6G5Je4ThTVfqFZr8tfx+7UAUc
 w2pmHbzGWIgWyuzvh3fSTrnjyIj+q6fEISivf/zsypr6pEAtT9E2y7QHz7bbw7fkTQ3OCagZQAt
 LxMq8PsMxW01ztK1BF6DOuONiy7kWJVxmIwxR9e51yxBVQ76PZAqddoRujmu0anlxNYpOjgQA3w
 dkv5AVRLwZrAgtaxllo7q+LcjEUYb6HFEsKFxX4jKd556efKst0VcMLuPcCMxmOY6VhP96w3OZV
 zzMOgQMNwRO4Qu78qQ+cApilvVBgyVbOI76UiD3j85Y6cWxqGVzzrZbWT5boHH/xLg+cs8t6t/a
 qvDh65H3v2ov3GUHXBx3HvXycJg6NzOPuULhczsUbldC9moHu427hrZRhJqd+VPsiWBpxAsqmnm
 LAWujzUl5Iz3HhrKUtxJMlpPtf2IXXLfOBvZAby0WI+CpKWJEqJGJHrSxoSuVU/+xWT7cbyQX02
 gGYIrQZmOY3UTAUgug3legb+LA/XGyPc9VP1XwOdjU++aAcEyNEts4gkYVr3AQ0YCNMjxAv9khk
 9PwvW0NcLLJMxAZMtzBiDgKBE9K8L6svrhdenDqu+6fPbesQ0bIW8ixmo8U3NVD7HAb9xXxnxPF
 KKNQOUakutckF1w==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

Currently when kdb_read() needs to reposition the cursor it uses copy and
paste code that works by injecting an '\0' at the cursor position before
delivering a carriage-return and reprinting the line (which stops at the
'\0').

Tidy up the code by hoisting the copy and paste code into an appropriately
named function. Additionally let's replace the '\0' injection with a
proper field width parameter so that the string will be abridged during
formatting instead.

Cc: stable@vger.kernel.org # Not a bug fix but it is needed for later bug fixes
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 06dfbccb10336..a42607e4d1aba 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -184,6 +184,13 @@ char kdb_getchar(void)
 	unreachable();
 }
 
+static void kdb_position_cursor(char *prompt, char *buffer, char *cp)
+{
+	kdb_printf("\r%s", kdb_prompt_str);
+	if (cp > buffer)
+		kdb_printf("%.*s", (int)(cp - buffer), buffer);
+}
+
 /*
  * kdb_read
  *
@@ -249,12 +256,8 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			}
 			*(--lastchar) = '\0';
 			--cp;
-			kdb_printf("\b%s \r", cp);
-			tmp = *cp;
-			*cp = '\0';
-			kdb_printf(kdb_prompt_str);
-			kdb_printf("%s", buffer);
-			*cp = tmp;
+			kdb_printf("\b%s ", cp);
+			kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		}
 		break;
 	case 10: /* linefeed */
@@ -272,19 +275,14 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			memcpy(tmpbuffer, cp+1, lastchar - cp - 1);
 			memcpy(cp, tmpbuffer, lastchar - cp - 1);
 			*(--lastchar) = '\0';
-			kdb_printf("%s \r", cp);
-			tmp = *cp;
-			*cp = '\0';
-			kdb_printf(kdb_prompt_str);
-			kdb_printf("%s", buffer);
-			*cp = tmp;
+			kdb_printf("%s ", cp);
+			kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		}
 		break;
 	case 1: /* Home */
 		if (cp > buffer) {
-			kdb_printf("\r");
-			kdb_printf(kdb_prompt_str);
 			cp = buffer;
+			kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		}
 		break;
 	case 5: /* End */
@@ -390,13 +388,9 @@ static char *kdb_read(char *buffer, size_t bufsize)
 				memcpy(cp+1, tmpbuffer, lastchar - cp);
 				*++lastchar = '\0';
 				*cp = key;
-				kdb_printf("%s\r", cp);
+				kdb_printf("%s", cp);
 				++cp;
-				tmp = *cp;
-				*cp = '\0';
-				kdb_printf(kdb_prompt_str);
-				kdb_printf("%s", buffer);
-				*cp = tmp;
+				kdb_position_cursor(kdb_prompt_str, buffer, cp);
 			} else {
 				*++lastchar = '\0';
 				*cp++ = key;

-- 
2.43.0


